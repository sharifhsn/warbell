use bevy::prelude::*;

pub struct SharedRenderPlugin;

impl Plugin for SharedRenderPlugin {
    fn build(&self, app: &mut App) {
        app.add_plugins((
            crate::terrain::TerrainPlugin,
            crate::water::WaterPlugin,
            crate::creature::CreaturePlugin,
        ));
    }
}
