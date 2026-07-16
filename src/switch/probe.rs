use super::{PreviousPad, switch_movement};
use bevy::prelude::*;

#[derive(Component)]
struct ProbePlayer;

pub(super) fn configure(app: &mut App) {
    app.add_systems(Startup, setup_scene)
        .add_systems(Update, move_player);
}

fn setup_scene(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut materials: ResMut<Assets<StandardMaterial>>,
) {
    commands.insert_resource(GlobalAmbientLight {
        color: Color::srgb(0.88, 0.93, 1.0),
        brightness: 1_000.0,
        affects_lightmapped_meshes: true,
    });
    let grass = materials.add(StandardMaterial {
        base_color: Color::srgb(0.12, 0.35, 0.12),
        perceptual_roughness: 0.9,
        cull_mode: None,
        ..default()
    });
    let stone = materials.add(StandardMaterial {
        base_color: Color::srgb(0.42, 0.39, 0.34),
        perceptual_roughness: 0.8,
        ..default()
    });
    let timber = materials.add(StandardMaterial {
        base_color: Color::srgb(0.30, 0.12, 0.05),
        perceptual_roughness: 0.75,
        ..default()
    });
    let blue = materials.add(StandardMaterial {
        base_color: Color::srgb(0.08, 0.22, 0.62),
        perceptual_roughness: 0.6,
        ..default()
    });
    let steel = materials.add(StandardMaterial {
        base_color: Color::srgb(0.58, 0.62, 0.68),
        metallic: 0.7,
        perceptual_roughness: 0.35,
        ..default()
    });
    let wall_mesh = meshes.add(Cuboid::new(5.5, 1.8, 0.45));
    let tower_mesh = meshes.add(Cuboid::new(1.35, 3.0, 1.35));

    commands.spawn((
        Mesh3d(meshes.add(Plane3d::default().mesh().size(18.0, 18.0))),
        MeshMaterial3d(grass),
    ));
    for (translation, rotation) in [
        (Vec3::new(0.0, 0.9, -5.0), 0.0),
        (Vec3::new(-5.0, 0.9, 0.0), core::f32::consts::FRAC_PI_2),
        (Vec3::new(5.0, 0.9, 0.0), core::f32::consts::FRAC_PI_2),
    ] {
        commands.spawn((
            Mesh3d(wall_mesh.clone()),
            MeshMaterial3d(stone.clone()),
            Transform::from_translation(translation).with_rotation(Quat::from_rotation_y(rotation)),
        ));
    }
    for x in [-5.0, 5.0] {
        for z in [-5.0, 5.0] {
            commands.spawn((
                Mesh3d(tower_mesh.clone()),
                MeshMaterial3d(stone.clone()),
                Transform::from_xyz(x, 1.5, z),
            ));
        }
    }
    commands.spawn((
        Mesh3d(meshes.add(Cuboid::new(3.0, 0.22, 0.8))),
        MeshMaterial3d(timber),
        Transform::from_xyz(0.0, 0.12, 2.2),
    ));
    commands
        .spawn((
            ProbePlayer,
            Transform::from_xyz(0.0, 0.0, 1.0),
            Visibility::default(),
        ))
        .with_children(|player| {
            player.spawn((
                Mesh3d(meshes.add(Cuboid::new(0.75, 1.05, 0.45))),
                MeshMaterial3d(blue),
                Transform::from_xyz(0.0, 0.85, 0.0),
            ));
            player.spawn((
                Mesh3d(meshes.add(Cuboid::new(0.58, 0.55, 0.58))),
                MeshMaterial3d(steel.clone()),
                Transform::from_xyz(0.0, 1.65, 0.0),
            ));
            player.spawn((
                Mesh3d(meshes.add(Cuboid::new(0.12, 1.25, 0.12))),
                MeshMaterial3d(steel),
                Transform::from_xyz(0.62, 0.85, 0.0).with_rotation(Quat::from_rotation_z(-0.25)),
            ));
        });
    commands.spawn((
        DirectionalLight {
            illuminance: 12_000.0,
            shadow_maps_enabled: false,
            ..default()
        },
        Transform::from_rotation(Quat::from_euler(EulerRot::XYZ, -0.8, -0.6, 0.0)),
    ));
    commands.spawn((
        Camera3d::default(),
        bevy::core_pipeline::tonemapping::Tonemapping::AgX,
        Msaa::Off,
        Transform::from_xyz(-7.5, 7.0, 10.0).looking_at(Vec3::new(0.0, 0.8, 0.0), Vec3::Y),
    ));
}

fn move_player(
    time: Res<Time>,
    input: Res<PreviousPad>,
    mut player: Single<&mut Transform, With<ProbePlayer>>,
) {
    let movement = switch_movement(&input);
    if movement == Vec2::ZERO {
        return;
    }
    player.translation += Vec3::new(movement.x, 0.0, -movement.y) * 3.5 * time.delta_secs();
    player.translation.x = player.translation.x.clamp(-4.2, 4.2);
    player.translation.z = player.translation.z.clamp(-4.2, 4.2);
    player.rotation = Quat::from_rotation_y(movement.x.atan2(-movement.y));
}
