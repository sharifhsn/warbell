use bevy::{
    app::{AppExit, PluginsState},
    asset::AssetPlugin,
    input::{
        ButtonState,
        gamepad::{
            GamepadAxis, GamepadButton, GamepadConnection, GamepadConnectionEvent,
            RawGamepadAxisChangedEvent, RawGamepadButtonChangedEvent, RawGamepadEvent,
        },
        keyboard::{Key, KeyCode, KeyboardInput, NativeKey},
        mouse::{MouseButton, MouseButtonInput, MouseMotion},
    },
    prelude::*,
    tasks::tick_global_task_pools_on_main_thread,
    window::{Window, WindowPlugin, WindowResolution},
};
#[cfg(target_os = "horizon")]
use std::sync::Arc;

#[cfg(target_os = "horizon")]
#[unsafe(no_mangle)]
static mut __nx_heap_size: usize = 1024 * 1024 * 1024;

#[cfg(all(target_os = "horizon", feature = "switch-emulator"))]
mod emulator_tls {
    use core::{
        ffi::{c_int, c_void},
        ptr,
        sync::atomic::{AtomicPtr, AtomicU32, AtomicU64, Ordering},
    };

    const KEY_CAPACITY: usize = 256;
    const THREAD_CAPACITY: usize = 64;
    const CUR_THREAD_HANDLE: u32 = 0xFFFF_8000;

    struct ThreadValues {
        id: AtomicU64,
        values: [AtomicPtr<c_void>; KEY_CAPACITY],
    }

    impl ThreadValues {
        const fn new() -> Self {
            Self {
                id: AtomicU64::new(0),
                values: [const { AtomicPtr::new(ptr::null_mut()) }; KEY_CAPACITY],
            }
        }
    }

    unsafe extern "C" {
        fn svcGetThreadId(thread_id: *mut u64, handle: u32) -> u32;
    }

    static NEXT_KEY: AtomicU32 = AtomicU32::new(0);
    static THREADS: [ThreadValues; THREAD_CAPACITY] =
        [const { ThreadValues::new() }; THREAD_CAPACITY];

    fn current_thread_values() -> Option<&'static ThreadValues> {
        let mut thread_id = 0_u64;
        if unsafe { svcGetThreadId(&mut thread_id, CUR_THREAD_HANDLE) } != 0 || thread_id == 0 {
            return None;
        }
        for thread in &THREADS {
            let id = thread.id.load(Ordering::Acquire);
            if id == thread_id {
                return Some(thread);
            }
            if id == 0
                && thread
                    .id
                    .compare_exchange(0, thread_id, Ordering::AcqRel, Ordering::Acquire)
                    .is_ok()
            {
                return Some(thread);
            }
        }
        None
    }

    #[unsafe(no_mangle)]
    unsafe extern "C" fn __wrap_pthread_key_create(
        key: *mut u32,
        _destructor: Option<unsafe extern "C" fn(*mut c_void)>,
    ) -> c_int {
        let next = NEXT_KEY.fetch_add(1, Ordering::Relaxed);
        if key.is_null() || next as usize >= KEY_CAPACITY {
            return 11;
        }
        unsafe { key.write(next) };
        0
    }

    #[unsafe(no_mangle)]
    unsafe extern "C" fn __wrap_pthread_key_delete(key: u32) -> c_int {
        let Some(key) = usize::try_from(key).ok().filter(|&key| key < KEY_CAPACITY) else {
            return 22;
        };
        for thread in &THREADS {
            thread.values[key].store(ptr::null_mut(), Ordering::Release);
        }
        0
    }

    #[unsafe(no_mangle)]
    unsafe extern "C" fn __wrap_pthread_getspecific(key: u32) -> *mut c_void {
        current_thread_values()
            .and_then(|thread| thread.values.get(key as usize))
            .map_or(ptr::null_mut(), |value| value.load(Ordering::Relaxed))
    }

    #[unsafe(no_mangle)]
    unsafe extern "C" fn __wrap_pthread_setspecific(key: u32, value: *const c_void) -> c_int {
        let Some(slot) = current_thread_values().and_then(|thread| thread.values.get(key as usize))
        else {
            return 22;
        };
        slot.store(value.cast_mut(), Ordering::Release);
        0
    }
}
// ABI verified against libnx's `switch/runtime/pad.h` and `switch.h` from the
// devkitPro distribution used by the NRO build script.
mod nx {
    unsafe extern "C" {
        pub fn randomGet(buf: *mut core::ffi::c_void, len: usize);
        pub fn romfsMountSelf(name: *const core::ffi::c_char) -> u32;
        pub fn romfsUnmount(name: *const core::ffi::c_char) -> u32;
        pub fn consoleDebugInit(device: i32);
    }

    pub unsafe fn romfs_init() -> u32 {
        unsafe { romfsMountSelf(c"romfs".as_ptr()) }
    }

    pub unsafe fn romfs_exit() -> u32 {
        unsafe { romfsUnmount(c"romfs".as_ptr()) }
    }
}

#[cfg(target_os = "horizon")]
#[unsafe(no_mangle)]
unsafe extern "Rust" fn __getrandom_v03_custom(
    dest: *mut u8,
    len: usize,
) -> Result<(), getrandom::Error> {
    unsafe { nx::randomGet(dest.cast(), len) };
    Ok(())
}

#[cfg(target_os = "horizon")]
#[unsafe(no_mangle)]
unsafe extern "C" fn getrandom(dest: *mut core::ffi::c_void, len: usize, _flags: u32) -> isize {
    if dest.is_null() {
        return -1;
    }
    unsafe { nx::randomGet(dest, len) };
    len as isize
}

#[cfg(target_os = "horizon")]
#[unsafe(no_mangle)]
extern "C" fn sysconf(name: i32) -> isize {
    match name {
        2 => 100,
        8 => 0x1000,
        9 | 10 => 4,
        _ => -1,
    }
}

const STICK_MAX: f32 = 32_767.0;
const STICK_DEADZONE: f32 = 0.18;
const ROMFS_ROOT: &str = "romfs:/";
const ROMFS_ASSET_PATH: &str = "assets";

const A: u64 = 1 << 0;
const B: u64 = 1 << 1;
const X: u64 = 1 << 2;
const Y: u64 = 1 << 3;
const L: u64 = 1 << 6;
const R: u64 = 1 << 7;
const ZL: u64 = 1 << 8;
const ZR: u64 = 1 << 9;
const PLUS: u64 = 1 << 10;
const MINUS: u64 = 1 << 11;
const LEFT: u64 = 1 << 12;
const UP: u64 = 1 << 13;
const RIGHT: u64 = 1 << 14;
const DOWN: u64 = 1 << 15;

mod game;
#[cfg(feature = "switch-probe")]
mod probe;

#[derive(Resource)]
struct HorizonGamepad(Entity);

#[derive(Resource)]
struct PreviousPad {
    buttons: u64,
    left_stick: Vec2,
    right_stick: Vec2,
}

impl Default for PreviousPad {
    fn default() -> Self {
        Self {
            buttons: 0,
            left_stick: Vec2::ZERO,
            right_stick: Vec2::ZERO,
        }
    }
}
#[derive(Resource, Clone, Copy, Debug)]
pub struct SwitchGraphicsConfig {
    pub msaa_samples: u8,
    pub shadows: bool,
    pub ssao: bool,
    pub bloom: bool,
    pub depth_of_field: bool,
    pub motion_blur: bool,
    pub custom_post_effects: bool,
}

impl Default for SwitchGraphicsConfig {
    fn default() -> Self {
        Self {
            msaa_samples: 1,
            shadows: false,
            ssao: false,
            bloom: false,
            depth_of_field: false,
            motion_blur: false,
            custom_post_effects: false,
        }
    }
}

pub fn run() {
    unsafe { nx::consoleDebugInit(1) };
    eprintln!("[warbell-switch] phase=svc_debug_ready");
    println!("[warbell-switch] phase=romfs_mount_begin");
    let mount_result = unsafe { nx::romfs_init() };
    if mount_result != 0 {
        eprintln!("failed to mount RomFS: {mount_result:#010x}");
        return;
    }
    println!("[warbell-switch] phase=romfs_mount_ok");
    probe_romfs();

    // FileAssetReader appends AssetPlugin::file_path to this base while the
    // plugin is constructed. The NRO stages the tree at romfs:/assets/.
    unsafe { std::env::set_var("BEVY_ASSET_ROOT", ROMFS_ROOT) };
    let mut app = App::new();
    app.insert_resource(SwitchGraphicsConfig::default())
        .add_plugins(
            DefaultPlugins
                .build()
                .disable::<bevy::post_process::PostProcessPlugin>()
                .disable::<bevy::anti_alias::AntiAliasPlugin>()
                .set(render_plugin())
                .set(WindowPlugin {
                    primary_window: Some(Window {
                        resolution: WindowResolution::new(1280, 720),
                        ..default()
                    }),
                    ..default()
                })
                .set(AssetPlugin {
                    file_path: ROMFS_ASSET_PATH.into(),
                    watch_for_changes_override: Some(false),
                    ..default()
                }),
        )
        .init_resource::<PreviousPad>()
        .set_runner(horizon_runner);
    #[cfg(feature = "switch-probe")]
    probe::configure(&mut app);
    #[cfg(all(not(feature = "switch-probe"), feature = "switch-full"))]
    crate::full_game::configure(&mut app);
    #[cfg(all(not(feature = "switch-probe"), not(feature = "switch-full")))]
    game::configure(&mut app);
    println!("[warbell-switch] phase=app_run");
    let exit = app.run();
    let unmount_result = unsafe { nx::romfs_exit() };
    if unmount_result != 0 {
        eprintln!("failed to unmount RomFS: {unmount_result:#010x}");
    } else {
        println!("[warbell-switch] phase=romfs_unmount_ok");
    }
    if exit.is_error() {
        eprintln!("Warbell exited with {exit:?}");
    }
}

fn switch_movement(input: &PreviousPad) -> Vec2 {
    let mut movement = input.left_stick;
    if input.buttons & LEFT != 0 {
        movement.x = -1.0;
    } else if input.buttons & RIGHT != 0 {
        movement.x = 1.0;
    }
    if input.buttons & DOWN != 0 {
        movement.y = -1.0;
    } else if input.buttons & UP != 0 {
        movement.y = 1.0;
    }
    if movement.length_squared() <= STICK_DEADZONE * STICK_DEADZONE {
        return Vec2::ZERO;
    }
    movement.normalize_or_zero()
}

#[cfg(target_os = "horizon")]
fn render_plugin() -> bevy::render::RenderPlugin {
    bevy::render::RenderPlugin {
        render_creation: bevy::render::settings::WgpuSettings {
            deko3d_wgsl_artifact_provider: Some(Arc::new(
                crate::deko_provider::WarbellDeko3dProvider::default(),
            )),
            ..default()
        }
        .into(),
        ..default()
    }
}

#[cfg(not(target_os = "horizon"))]
fn render_plugin() -> bevy::render::RenderPlugin {
    default()
}

fn horizon_runner(mut app: App) -> AppExit {
    let mut gamepad = None;
    let exit = bevy_horizon::run(
        &mut app,
        bevy_horizon::Config {
            emulator_frame_ms: cfg!(feature = "switch-emulator").then_some(16),
            log_label: "warbell-switch",
            ..default()
        },
        |mut app, window, pad, frame| {
            let gamepad = gamepad.get_or_insert_with(|| {
                let gamepad = connect_gamepad(&mut app);
                println!("[warbell-switch] phase=gamepad_connected entity={gamepad:?}");
                gamepad
            });
            if pad.buttons_cur & (PLUS | MINUS) == (PLUS | MINUS)
                && pad.buttons_old & (PLUS | MINUS) != (PLUS | MINUS)
            {
                #[cfg(target_os = "horizon")]
                wgpu_hal::deko3d::dump_debug_trace("warbell_button_trigger");
            }
            inject_input(app, window, pad);
            if frame < 4 {
                eprintln!("[warbell-switch] phase=update_begin frame={frame}");
            }
            let _ = gamepad;
        },
        |app, frame| {
            if frame <= 4 {
                eprintln!("[warbell-switch] phase=update_end frame={frame}");
            }
            if matches!(frame, 1 | 60 | 300) {
                log_switch_frame_status(app.world(), frame);
            }
            if frame == 60 {
                #[cfg(feature = "switch-probe")]
                eprintln!("[warbell-switch-probe] phase=probe_ready frame=60");
                #[cfg(all(not(feature = "switch-probe"), feature = "switch-full"))]
                if crate::full_game::ready(app.world()) {
                    eprintln!("[warbell-switch-full] phase=full_ready frame=60");
                } else {
                    eprintln!("[warbell-switch-full] phase=full_not_ready frame=60");
                }
                #[cfg(all(not(feature = "switch-probe"), not(feature = "switch-full")))]
                if game::combat_proven(app.world()) {
                    eprintln!("[warbell-switch-game] phase=game_ready frame=60 combat=proven");
                } else {
                    eprintln!(
                        "[warbell-switch-game] phase=game_not_ready frame=60 combat=unproven"
                    );
                }
            }
            if frame == 300 && cfg!(feature = "switch-emulator") {
                #[cfg(target_os = "horizon")]
                wgpu_hal::deko3d::dump_debug_trace("warbell_emulator_frame_300");
            }
        },
    );
    if let Some(gamepad) = gamepad {
        disconnect_gamepad(&mut app, gamepad);
    }
    drop(app);
    exit
}

fn log_switch_frame_status(world: &World, frame: u64) {
    eprintln!(
        "[warbell-switch] phase=frame frame={frame} provider=embedded_dksh entities={}",
        world.entities().len()
    );
}

fn probe_romfs() {
    for path in [
        "romfs:/assets/fonts/Cinzel.ttf",
        "romfs:/assets/ui/menu_backdrop.png",
        "romfs:/assets/shaders/terrain.wgsl",
    ] {
        match std::fs::read(path) {
            Ok(bytes) => println!(
                "[warbell-switch] phase=asset_probe_ok path={path} bytes={}",
                bytes.len()
            ),
            Err(error) => {
                eprintln!("[warbell-switch] phase=asset_probe_error path={path} error={error}")
            }
        }
    }
}

fn prepare_app(app: &mut App) {
    if app.plugins_state() != PluginsState::Cleaned {
        while app.plugins_state() == PluginsState::Adding {
            tick_global_task_pools_on_main_thread();
        }
        app.finish();
        app.cleanup();
    }
}

fn connect_gamepad(app: &mut App) -> Entity {
    let gamepad = app.world_mut().spawn_empty().id();
    app.world_mut().insert_resource(HorizonGamepad(gamepad));
    let connection = GamepadConnectionEvent::new(
        gamepad,
        GamepadConnection::Connected {
            name: "Nintendo Switch Controller".into(),
            vendor_id: None,
            product_id: None,
        },
    );
    app.world_mut().write_message(connection.clone());
    app.world_mut()
        .write_message(RawGamepadEvent::Connection(connection));
    gamepad
}

fn disconnect_gamepad(app: &mut App, gamepad: Entity) {
    let connection = GamepadConnectionEvent::new(gamepad, GamepadConnection::Disconnected);
    app.world_mut().write_message(connection.clone());
    app.world_mut()
        .write_message(RawGamepadEvent::Connection(connection));
}

fn inject_input(app: &mut App, window: Entity, pad: bevy_horizon::PadSnapshot) {
    let buttons = pad.buttons_cur;
    let left_stick = stick(pad.sticks[0]);
    let right_stick = stick(pad.sticks[1]);
    let (gamepad, previous) = {
        let world = app.world_mut();
        let gamepad = world.resource::<HorizonGamepad>().0;
        let previous = core::mem::take(&mut *world.resource_mut::<PreviousPad>());
        (gamepad, previous)
    };

    for (mask, key) in [
        (A, KeyCode::Space),
        (B, KeyCode::KeyE),
        (X, KeyCode::KeyQ),
        (Y, KeyCode::Tab),
        (L, KeyCode::ShiftLeft),
        (R, KeyCode::AltLeft),
        (MINUS, KeyCode::Escape),
    ] {
        write_key(
            app,
            window,
            key,
            buttons & mask != 0,
            previous.buttons & mask != 0,
        );
    }
    write_mouse(
        app,
        window,
        MouseButton::Left,
        buttons & ZR != 0,
        previous.buttons & ZR != 0,
    );
    write_mouse(
        app,
        window,
        MouseButton::Right,
        buttons & ZL != 0,
        previous.buttons & ZL != 0,
    );

    // Stick input supplements the digital control mirror so existing Warbell
    // systems continue to work without a winit keyboard backend.
    for (key, active, was_active) in [
        (
            KeyCode::KeyW,
            buttons & UP != 0 || left_stick.y > STICK_DEADZONE,
            previous.buttons & UP != 0 || previous.left_stick.y > STICK_DEADZONE,
        ),
        (
            KeyCode::KeyS,
            buttons & DOWN != 0 || left_stick.y < -STICK_DEADZONE,
            previous.buttons & DOWN != 0 || previous.left_stick.y < -STICK_DEADZONE,
        ),
        (
            KeyCode::KeyA,
            buttons & LEFT != 0 || left_stick.x < -STICK_DEADZONE,
            previous.buttons & LEFT != 0 || previous.left_stick.x < -STICK_DEADZONE,
        ),
        (
            KeyCode::KeyD,
            buttons & RIGHT != 0 || left_stick.x > STICK_DEADZONE,
            previous.buttons & RIGHT != 0 || previous.left_stick.x > STICK_DEADZONE,
        ),
    ] {
        write_key(app, window, key, active, was_active);
    }

    app.world_mut()
        .write_message(RawGamepadEvent::Axis(RawGamepadAxisChangedEvent::new(
            gamepad,
            GamepadAxis::LeftStickX,
            left_stick.x,
        )));
    app.world_mut()
        .write_message(RawGamepadEvent::Axis(RawGamepadAxisChangedEvent::new(
            gamepad,
            GamepadAxis::LeftStickY,
            left_stick.y,
        )));
    app.world_mut()
        .write_message(RawGamepadEvent::Axis(RawGamepadAxisChangedEvent::new(
            gamepad,
            GamepadAxis::RightStickX,
            right_stick.x,
        )));
    app.world_mut()
        .write_message(RawGamepadEvent::Axis(RawGamepadAxisChangedEvent::new(
            gamepad,
            GamepadAxis::RightStickY,
            right_stick.y,
        )));
    for (mask, button) in [
        (A, GamepadButton::South),
        (B, GamepadButton::East),
        (X, GamepadButton::North),
        (Y, GamepadButton::West),
        (L, GamepadButton::LeftTrigger),
        (R, GamepadButton::RightTrigger),
        (ZL, GamepadButton::LeftTrigger2),
        (ZR, GamepadButton::RightTrigger2),
        (PLUS, GamepadButton::Start),
        (MINUS, GamepadButton::Select),
        (LEFT, GamepadButton::DPadLeft),
        (UP, GamepadButton::DPadUp),
        (RIGHT, GamepadButton::DPadRight),
        (DOWN, GamepadButton::DPadDown),
    ] {
        app.world_mut()
            .write_message(RawGamepadEvent::Button(RawGamepadButtonChangedEvent::new(
                gamepad,
                button,
                if buttons & mask != 0 { 1.0 } else { 0.0 },
            )));
    }
    let delta = mouse_delta(right_stick, previous.right_stick);
    if delta != Vec2::ZERO {
        app.world_mut().write_message(MouseMotion {
            delta: delta * 18.0,
        });
    }
    app.world_mut().insert_resource(PreviousPad {
        buttons,
        left_stick,
        right_stick,
    });
}

fn mouse_delta(current: Vec2, previous: Vec2) -> Vec2 {
    current - previous
}

fn stick(stick: bevy_horizon::AnalogStick) -> Vec2 {
    Vec2::new(stick.x as f32 / STICK_MAX, stick.y as f32 / STICK_MAX).clamp_length_max(1.0)
}

fn write_key(app: &mut App, window: Entity, key_code: KeyCode, pressed: bool, was_pressed: bool) {
    if pressed == was_pressed {
        return;
    }
    app.world_mut().write_message(KeyboardInput {
        key_code,
        logical_key: Key::Unidentified(NativeKey::Unidentified),
        state: if pressed {
            ButtonState::Pressed
        } else {
            ButtonState::Released
        },
        text: None,
        repeat: false,
        window,
    });
}

fn write_mouse(
    app: &mut App,
    window: Entity,
    button: MouseButton,
    pressed: bool,
    was_pressed: bool,
) {
    if pressed == was_pressed {
        return;
    }
    app.world_mut().write_message(MouseButtonInput {
        button,
        state: if pressed {
            ButtonState::Pressed
        } else {
            ButtonState::Released
        },
        window,
    });
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::path::PathBuf;

    #[test]
    fn romfs_asset_path_matches_the_staged_layout() {
        assert_eq!(
            PathBuf::from(ROMFS_ROOT)
                .join(ROMFS_ASSET_PATH)
                .join("shaders/terrain.wgsl"),
            PathBuf::from("romfs:/assets/shaders/terrain.wgsl"),
        );
    }

    #[test]
    fn mouse_delta_is_relative_to_the_previous_sample() {
        assert_eq!(
            mouse_delta(Vec2::new(0.5, -0.25), Vec2::new(-0.25, 0.5)),
            Vec2::new(0.75, -0.75),
        );
    }

    #[test]
    fn sticks_are_normalized_and_clamped() {
        assert_eq!(
            stick(bevy_horizon::AnalogStick {
                x: 32_767,
                y: -32_767
            }),
            Vec2::new(1.0, -1.0).normalize(),
        );
    }

    #[test]
    fn switch_movement_applies_deadzone_and_dpad() {
        let mut input = PreviousPad::default();
        input.left_stick = Vec2::splat(STICK_DEADZONE * 0.5);
        assert_eq!(switch_movement(&input), Vec2::ZERO);

        input.buttons = RIGHT | UP;
        assert_eq!(switch_movement(&input), Vec2::ONE.normalize());
    }

    #[test]
    fn prepared_apps_are_not_finished_or_cleaned_twice() {
        let mut app = App::new();
        app.finish();
        app.cleanup();
        prepare_app(&mut app);
        assert_eq!(app.plugins_state(), PluginsState::Cleaned);
    }
}
