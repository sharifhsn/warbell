//! **UI kit** — the shared design system the whole HUD/menus are built on: palette + chrome
//! ([`theme`]), bundled fonts ([`fonts`]), Twemoji item icons ([`icons`]), entrance/hover motion
//! ([`anim`]), widget paint bundles ([`widgets`]), and the [`notice`] queue.
//!
//! `UiKitPlugin` is added **first** (before the HUD/panel plugins) so `UiFonts` and the icon atlas
//! exist by the time those plugins spawn. Its systems are ungated, so chrome animates in every state.

use bevy::prelude::*;

pub mod anim;
pub mod focus;
pub mod fonts;
#[cfg(feature = "desktop")]
pub mod graphics_menu;
#[cfg(not(feature = "desktop"))]
pub mod graphics_menu {
    use bevy::prelude::*;

    #[derive(Resource, Default)]
    pub struct GraphicsMenuOpen(pub bool);
}
pub mod icons;
pub mod notice;
#[cfg(feature = "desktop")]
pub mod settings;
pub mod texture;
pub mod theme;
pub mod widgets;

pub use fonts::{UiFonts, label};
pub use icons::IconAtlas;

pub struct UiKitPlugin;

impl Plugin for UiKitPlugin {
    fn build(&self, app: &mut App) {
        // Load fonts at build time (AssetServer is ready once DefaultPlugins are added) so the
        // `UiFonts` resource exists before any `Startup` spawn system queries it.
        let assets = app.world().resource::<AssetServer>().clone();
        app.insert_resource(UiFonts::load(&assets));
        app.add_plugins((
            icons::IconsPlugin,
            anim::AnimPlugin,
            notice::NoticePlugin,
            texture::UiTexturePlugin,
            focus::FocusPlugin,
            focus::TooltipPlugin,
        ));
        #[cfg(feature = "desktop")]
        app.add_plugins((settings::SettingsPlugin, graphics_menu::GraphicsMenuPlugin));
        #[cfg(not(feature = "desktop"))]
        app.init_resource::<graphics_menu::GraphicsMenuOpen>();
        // NB: the Slider/Checkbox widget plugins are added automatically by `DefaultPlugins` when the
        // `bevy_ui_widgets` feature is on — adding them again here panics ("already added").
    }
}
