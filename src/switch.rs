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
    window::{PrimaryWindow, Window, WindowPlugin, WindowResolution},
};
// ABI verified against libnx's `switch/runtime/pad.h` and `switch.h` from the
// devkitPro distribution used by the NRO build script.
mod nx {
    #[repr(C)]
    #[derive(Clone, Copy)]
    pub struct HidAnalogStickState {
        pub x: i32,
        pub y: i32,
    }

    #[repr(C)]
    pub struct PadState {
        pub id_mask: u8,
        pub active_id_mask: u8,
        pub read_handheld: bool,
        pub active_handheld: bool,
        pub style_set: u32,
        pub attributes: u32,
        pub buttons_cur: u64,
        pub buttons_old: u64,
        pub sticks: [HidAnalogStickState; 2],
        pub gc_triggers: [u32; 2],
    }

    impl PadState {
        pub const fn zeroed() -> Self {
            Self {
                id_mask: 0,
                active_id_mask: 0,
                read_handheld: false,
                active_handheld: false,
                style_set: 0,
                attributes: 0,
                buttons_cur: 0,
                buttons_old: 0,
                sticks: [HidAnalogStickState { x: 0, y: 0 }; 2],
                gc_triggers: [0; 2],
            }
        }
    }

    pub const HID_NPAD_STYLE_SET_NPAD_STANDARD: u32 = 0x1f;

    unsafe extern "C" {
        pub fn appletMainLoop() -> bool;
        pub fn randomGet(buf: *mut core::ffi::c_void, len: usize);
        pub fn romfsMountSelf(name: *const core::ffi::c_char) -> u32;
        pub fn romfsUnmount(name: *const core::ffi::c_char) -> u32;
        pub fn padConfigureInput(max_players: u32, style_set: u32);
        pub fn padInitializeWithMask(pad: *mut PadState, mask: u64);
        pub fn padUpdate(pad: *mut PadState);
    }

    pub unsafe fn romfs_init() -> u32 {
        unsafe { romfsMountSelf(c"romfs".as_ptr()) }
    }

    pub unsafe fn romfs_exit() -> u32 {
        unsafe { romfsUnmount(c"romfs".as_ptr()) }
    }

    pub unsafe fn pad_initialize_default(pad: *mut PadState) {
        unsafe { padInitializeWithMask(pad, (1 << 0) | (1 << 0x20)) }
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
    let mount_result = unsafe { nx::romfs_init() };
    if mount_result != 0 {
        eprintln!("failed to mount RomFS: {mount_result:#010x}");
        return;
    }

    // FileAssetReader appends AssetPlugin::file_path to this base while the
    // plugin is constructed. The NRO stages the tree at romfs:/assets/.
    unsafe { std::env::set_var("BEVY_ASSET_ROOT", ROMFS_ROOT) };
    let mut app = App::new();
    app.insert_resource(SwitchGraphicsConfig::default())
        .add_plugins(
            DefaultPlugins
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
    let exit = app.run();
    let unmount_result = unsafe { nx::romfs_exit() };
    if unmount_result != 0 {
        eprintln!("failed to unmount RomFS: {unmount_result:#010x}");
    }
    if exit.is_error() {
        eprintln!("Warbell exited with {exit:?}");
    }
}

fn horizon_runner(mut app: App) -> AppExit {
    unsafe { nx::padConfigureInput(1, nx::HID_NPAD_STYLE_SET_NPAD_STANDARD) };
    let mut pad = nx::PadState::zeroed();
    unsafe { nx::pad_initialize_default(&mut pad) };

    prepare_app(&mut app);

    // WindowPlugin creates the primary window during plugin setup. It must be
    // available before the first applet grant, but the first app.update must
    // still run inside one.
    let window = {
        let world = app.world_mut();
        let mut windows = world.query_filtered::<Entity, With<PrimaryWindow>>();
        windows
            .single(world)
            .expect("Horizon runner requires the single primary Bevy window")
    };
    let window_component = app
        .world()
        .get::<Window>(window)
        .expect("primary window missing");
    assert_eq!(window_component.resolution.physical_width(), 1280);
    assert_eq!(window_component.resolution.physical_height(), 720);
    let mut gamepad = None;
    let exit = loop {
        if !unsafe { nx::appletMainLoop() } {
            break AppExit::Success;
        }
        gamepad.get_or_insert_with(|| connect_gamepad(&mut app));
        unsafe { nx::padUpdate(&mut pad) };
        inject_input(&mut app, window, &pad);
        app.update();
        if let Some(exit) = app.should_exit() {
            break exit;
        }
    };

    if let Some(gamepad) = gamepad {
        disconnect_gamepad(&mut app, gamepad);
    }

    // Let render and gameplay resources drop after libnx has ended the frame;
    // Deko3D's default window remains valid for the process lifetime.
    drop(app);
    exit
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

fn inject_input(app: &mut App, window: Entity, pad: &nx::PadState) {
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

fn stick(stick: nx::HidAnalogStickState) -> Vec2 {
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
            stick(nx::HidAnalogStickState {
                x: 32_767,
                y: -32_767
            }),
            Vec2::new(1.0, -1.0).normalize(),
        );
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
