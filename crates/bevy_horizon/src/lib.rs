use bevy_app::{App, AppExit, PluginsState};
use bevy_ecs::{entity::Entity, query::With};
use bevy_tasks::tick_global_task_pools_on_main_thread;
use bevy_window::{PrimaryWindow, Window};

#[repr(C)]
#[derive(Clone, Copy, Default)]
pub struct AnalogStick {
    pub x: i32,
    pub y: i32,
}

#[repr(C)]
struct PadState {
    pub id_mask: u8,
    pub active_id_mask: u8,
    pub read_handheld: bool,
    pub active_handheld: bool,
    pub style_set: u32,
    pub attributes: u32,
    pub buttons_cur: u64,
    pub buttons_old: u64,
    pub sticks: [AnalogStick; 2],
    pub gc_triggers: [u32; 2],
}

impl PadState {
    fn zeroed() -> Self {
        unsafe { core::mem::zeroed() }
    }
}

#[derive(Clone, Copy)]
pub struct PadSnapshot {
    pub buttons_cur: u64,
    pub buttons_old: u64,
    pub sticks: [AnalogStick; 2],
}

pub struct Config {
    pub width: u32,
    pub height: u32,
    pub emulator_frame_ms: Option<u64>,
    pub log_label: &'static str,
}

impl Default for Config {
    fn default() -> Self {
        Self {
            width: 1280,
            height: 720,
            emulator_frame_ms: None,
            log_label: "horizon",
        }
    }
}

pub fn run(
    app: &mut App,
    config: Config,
    mut before: impl FnMut(&mut App, Entity, PadSnapshot, u64),
    mut after: impl FnMut(&mut App, u64),
) -> AppExit {
    unsafe { padConfigureInput(1, HID_NPAD_STYLE_SET_NPAD_STANDARD) };
    let mut pad = PadState::zeroed();
    unsafe { padInitializeWithMask(&mut pad, (1 << 0) | (1 << 0x20)) };
    if app.plugins_state() != PluginsState::Cleaned {
        while app.plugins_state() == PluginsState::Adding {
            tick_global_task_pools_on_main_thread();
        }
        app.finish();
        app.cleanup();
    }
    println!("[{}] phase=plugins_ready", config.log_label);
    let window = app
        .world_mut()
        .query_filtered::<Entity, With<PrimaryWindow>>()
        .single(app.world())
        .expect("Horizon runner requires the single primary Bevy window");
    let w = app
        .world()
        .get::<Window>(window)
        .expect("primary window missing");
    assert_eq!(w.resolution.physical_width(), config.width);
    assert_eq!(w.resolution.physical_height(), config.height);
    println!(
        "[{}] phase=window_ready width={} height={}",
        config.log_label, config.width, config.height
    );
    let mut frame = 0;
    let exit = loop {
        if !unsafe { appletMainLoop() } && config.emulator_frame_ms.is_none() {
            break AppExit::Success;
        }
        unsafe { padUpdate(&mut pad) };
        before(
            app,
            window,
            PadSnapshot {
                buttons_cur: pad.buttons_cur,
                buttons_old: pad.buttons_old,
                sticks: pad.sticks,
            },
            frame,
        );
        app.update();
        tick_global_task_pools_on_main_thread();
        frame += 1;
        after(app, frame);
        if let Some(exit) = app.should_exit() {
            break exit;
        }
        if let Some(ms) = config.emulator_frame_ms {
            std::thread::sleep(std::time::Duration::from_millis(ms));
        }
    };
    println!(
        "[{}] phase=runner_exit frame={} exit={exit:?}",
        config.log_label, frame
    );
    exit
}

const HID_NPAD_STYLE_SET_NPAD_STANDARD: u32 = 0x1f;
unsafe extern "C" {
    fn appletMainLoop() -> bool;
    fn padConfigureInput(players: u32, style: u32);
    fn padInitializeWithMask(pad: *mut PadState, mask: u64);
    fn padUpdate(pad: *mut PadState);
}
