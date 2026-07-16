use super::{PreviousPad, switch_movement};
use bevy::prelude::*;

#[derive(Component)]
struct WarbellHero;

#[derive(Component)]
struct WarbellCamera;

#[derive(Component)]
struct WarbellRival {
    health: u8,
    hurt_for: f32,
}

#[derive(Resource, Default)]
struct HeroAttack {
    elapsed: f32,
    active: bool,
    hit_dealt: bool,
    auto_frames: u32,
    hits: u32,
}

#[derive(Component, Clone, Copy)]
enum KnightJoint {
    Torso,
    ShoulderL,
    ShoulderR,
    HipL,
    HipR,
    Sword,
}

pub(super) fn configure(app: &mut App) {
    app.add_plugins(crate::shared_render::SharedRenderPlugin)
        .add_plugins(crate::ui::UiKitPlugin)
        .init_resource::<HeroAttack>()
        .add_systems(Startup, setup_game)
        .add_systems(Startup, setup_combat_hud)
        .add_systems(
            Update,
            (
                move_hero,
                start_attack,
                advance_attack,
                animate_hero,
                animate_rival_hit,
                follow_camera,
                update_combat_hud,
            )
                .chain(),
        );
}

#[derive(Component)]
struct CombatHudText;

fn setup_combat_hud(mut commands: Commands, fonts: Res<crate::ui::UiFonts>) {
    commands.spawn((
        Text::new("HERO 100%   RIVAL 100%   READY"),
        TextFont {
            font: fonts.bold.clone().into(),
            font_size: FontSize::Px(22.0),
            ..default()
        },
        TextColor(Color::srgb(0.96, 0.84, 0.45)),
        Node {
            position_type: PositionType::Absolute,
            left: Val::Px(24.0),
            top: Val::Px(24.0),
            padding: UiRect::all(Val::Px(10.0)),
            ..default()
        },
        BackgroundColor(Color::srgba(0.04, 0.03, 0.02, 0.82)),
        CombatHudText,
    ));
}

fn update_combat_hud(
    attack: Res<HeroAttack>,
    rivals: Query<&WarbellRival>,
    mut text: Single<&mut Text, With<CombatHudText>>,
) {
    let rival_hp = rivals.iter().next().map_or(0, |r| r.health);
    text.0 = format!(
        "HERO 100%   RIVAL {}%   {}",
        rival_hp * 25,
        if attack.active { "ATTACK" } else { "READY" }
    );
}

fn setup_game(
    mut commands: Commands,
    mut meshes: ResMut<Assets<Mesh>>,
    mut standard_materials: ResMut<Assets<StandardMaterial>>,
    mut creature_materials: ResMut<Assets<crate::creature::CreatureMaterial>>,
) {
    println!("[warbell-switch-game] phase=game_startup");
    commands.insert_resource(GlobalAmbientLight {
        color: Color::srgb(0.88, 0.93, 1.0),
        brightness: 700.0,
        affects_lightmapped_meshes: true,
    });

    let grass = standard_materials.add(StandardMaterial {
        base_color: Color::srgb(0.10, 0.30, 0.09),
        perceptual_roughness: 0.95,
        cull_mode: None,
        ..default()
    });
    let earth = standard_materials.add(StandardMaterial {
        base_color: Color::srgb(0.29, 0.19, 0.10),
        perceptual_roughness: 0.9,
        ..default()
    });
    let stone = standard_materials.add(StandardMaterial {
        base_color: Color::srgb(0.37, 0.39, 0.41),
        perceptual_roughness: 0.8,
        ..default()
    });

    commands.spawn((
        Mesh3d(meshes.add(Plane3d::default().mesh().size(60.0, 60.0))),
        MeshMaterial3d(grass),
    ));
    commands.spawn((
        Mesh3d(meshes.add(Cuboid::new(6.0, 0.08, 28.0))),
        MeshMaterial3d(earth),
        Transform::from_xyz(0.0, 0.04, -7.0),
    ));
    for x in [-7.0, 7.0] {
        commands.spawn((
            Mesh3d(meshes.add(Cuboid::new(3.2, 8.0, 3.2))),
            MeshMaterial3d(stone.clone()),
            Transform::from_xyz(x, 4.0, -15.0),
        ));
    }
    commands.spawn((
        Mesh3d(meshes.add(Cuboid::new(11.0, 4.5, 4.0))),
        MeshMaterial3d(stone),
        Transform::from_xyz(0.0, 2.25, -17.0),
    ));

    let hero_material = crate::creature::make_hero_material(&mut creature_materials);
    let hero = commands
        .spawn((
            WarbellHero,
            Transform {
                translation: Vec3::new(0.0, 0.0, 3.0),
                scale: Vec3::splat(0.6345),
                ..default()
            },
            Visibility::Visible,
        ))
        .id();
    spawn_knight(
        &mut commands,
        hero,
        crate::switch_knight_model::build_knight(None, None),
        &mut meshes,
        &hero_material,
        true,
    );

    let rival = commands
        .spawn((
            WarbellRival {
                health: 4,
                hurt_for: 0.0,
            },
            Transform {
                translation: Vec3::new(0.0, 0.0, 0.35),
                rotation: Quat::from_rotation_y(std::f32::consts::PI),
                scale: Vec3::splat(0.6345),
            },
            Visibility::Visible,
        ))
        .id();
    spawn_knight(
        &mut commands,
        rival,
        crate::switch_knight_model::build_knight(Some("stone_maul"), Some("dragon_plate")),
        &mut meshes,
        &hero_material,
        false,
    );

    commands.spawn((
        DirectionalLight {
            illuminance: 11_000.0,
            shadow_maps_enabled: false,
            ..default()
        },
        Transform::from_rotation(Quat::from_euler(EulerRot::XYZ, -0.8, -0.55, 0.0)),
    ));
    commands.spawn((
        Camera3d::default(),
        WarbellCamera,
        bevy::core_pipeline::tonemapping::Tonemapping::AgX,
        Msaa::Off,
        Transform::from_xyz(4.5, 3.2, 9.0).looking_at(Vec3::new(0.0, 0.8, 3.0), Vec3::Y),
    ));
    println!("[warbell-switch-game] phase=recognizable_slice_spawned");
}

fn spawn_knight(
    commands: &mut Commands,
    root: Entity,
    model: crate::switch_knight_model::KnightMeshes,
    meshes: &mut Assets<Mesh>,
    material: &Handle<crate::creature::CreatureMaterial>,
    animated: bool,
) {
    use crate::switch_knight_model as m;

    fn joint(
        commands: &mut Commands,
        parent: Entity,
        transform: Transform,
        mesh: Option<Mesh>,
        meshes: &mut Assets<Mesh>,
        material: &Handle<crate::creature::CreatureMaterial>,
    ) -> Entity {
        let entity = commands.spawn((transform, Visibility::Visible)).id();
        if let Some(mesh) = mesh {
            commands
                .entity(entity)
                .insert((Mesh3d(meshes.add(mesh)), MeshMaterial3d(material.clone())));
        }
        commands.entity(parent).add_child(entity);
        entity
    }

    let rig = joint(commands, root, Transform::default(), None, meshes, material);
    let hips = joint(
        commands,
        rig,
        Transform::from_xyz(0.0, m::Y_HIPS, 0.0),
        Some(model.hips),
        meshes,
        material,
    );
    let torso = joint(
        commands,
        hips,
        Transform::from_xyz(0.0, m::O_TORSO, 0.0),
        Some(model.torso),
        meshes,
        material,
    );
    if animated {
        commands.entity(torso).insert(KnightJoint::Torso);
    }
    let neck = joint(
        commands,
        torso,
        Transform::from_xyz(0.0, m::O_NECK, 0.0),
        Some(model.neck),
        meshes,
        material,
    );
    joint(
        commands,
        neck,
        Transform::from_xyz(0.0, m::O_HEAD, 0.0),
        Some(model.head),
        meshes,
        material,
    );

    let shoulder_l = joint(
        commands,
        torso,
        Transform::from_xyz(-m::SHOULDER_DX, m::O_SHOULDER_Y, 0.01),
        Some(model.shoulder_l),
        meshes,
        material,
    );
    if animated {
        commands.entity(shoulder_l).insert(KnightJoint::ShoulderL);
    }
    let elbow_l = joint(
        commands,
        shoulder_l,
        Transform::from_xyz(0.0, m::O_ELBOW, 0.0),
        Some(model.elbow_l),
        meshes,
        material,
    );
    let hand_l = joint(
        commands,
        elbow_l,
        Transform::from_xyz(0.0, m::O_HAND, 0.0),
        None,
        meshes,
        material,
    );
    let shield = joint(
        commands,
        hand_l,
        Transform {
            translation: Vec3::new(-0.07, -0.08, 0.13),
            rotation: Quat::from_euler(EulerRot::XYZ, 0.12, -1.5, 0.0),
            scale: Vec3::ONE,
        },
        Some(model.shield),
        meshes,
        material,
    );
    joint(
        commands,
        shield,
        Transform::from_xyz(0.0, -0.03, 0.033),
        Some(model.lion),
        meshes,
        material,
    );

    let shoulder_r = joint(
        commands,
        torso,
        Transform::from_xyz(m::SHOULDER_DX, m::O_SHOULDER_Y, 0.01),
        Some(model.shoulder_r),
        meshes,
        material,
    );
    if animated {
        commands.entity(shoulder_r).insert(KnightJoint::ShoulderR);
    }
    let elbow_r = joint(
        commands,
        shoulder_r,
        Transform::from_xyz(0.0, m::O_ELBOW, 0.0),
        Some(model.elbow_r),
        meshes,
        material,
    );
    let hand_r = joint(
        commands,
        elbow_r,
        Transform::from_xyz(0.0, m::O_HAND, 0.0),
        None,
        meshes,
        material,
    );
    let sword = joint(
        commands,
        hand_r,
        Transform::from_rotation(Quat::from_euler(EulerRot::XYZ, 0.15, 0.0, -0.35)),
        Some(model.weapon),
        meshes,
        material,
    );
    if animated {
        commands.entity(sword).insert(KnightJoint::Sword);
    }

    let hip_l = joint(
        commands,
        hips,
        Transform::from_xyz(-m::HIP_DX, m::O_HIP_Y, 0.0),
        Some(model.hip_l),
        meshes,
        material,
    );
    if animated {
        commands.entity(hip_l).insert(KnightJoint::HipL);
    }
    let knee_l = joint(
        commands,
        hip_l,
        Transform::from_xyz(0.0, m::O_KNEE, 0.0),
        Some(model.knee_l),
        meshes,
        material,
    );
    joint(
        commands,
        knee_l,
        Transform::from_xyz(0.0, m::O_FOOT, 0.0),
        Some(model.foot_l),
        meshes,
        material,
    );
    let hip_r = joint(
        commands,
        hips,
        Transform::from_xyz(m::HIP_DX, m::O_HIP_Y, 0.0),
        Some(model.hip_r),
        meshes,
        material,
    );
    if animated {
        commands.entity(hip_r).insert(KnightJoint::HipR);
    }
    let knee_r = joint(
        commands,
        hip_r,
        Transform::from_xyz(0.0, m::O_KNEE, 0.0),
        Some(model.knee_r),
        meshes,
        material,
    );
    joint(
        commands,
        knee_r,
        Transform::from_xyz(0.0, m::O_FOOT, 0.0),
        Some(model.foot_r),
        meshes,
        material,
    );
}

fn move_hero(
    time: Res<Time>,
    input: Res<PreviousPad>,
    mut hero: Single<&mut Transform, With<WarbellHero>>,
) {
    let movement = switch_movement(&input);
    if movement == Vec2::ZERO {
        return;
    }
    hero.translation += Vec3::new(movement.x, 0.0, -movement.y) * 5.0 * time.delta_secs();
    hero.rotation = Quat::from_rotation_y(movement.x.atan2(-movement.y));
}

fn animate_hero(
    time: Res<Time>,
    input: Res<PreviousPad>,
    attack: Res<HeroAttack>,
    mut joints: Query<(&KnightJoint, &mut Transform)>,
) {
    let moving = switch_movement(&input) != Vec2::ZERO;
    let phase = time.elapsed_secs() * if moving { 9.0 } else { 2.0 };
    let stride = if moving { phase.sin() * 0.55 } else { 0.0 };
    let idle = phase.sin() * 0.018;
    let attack_phase = (attack.elapsed / 0.48).clamp(0.0, 1.0);
    let swing = if attack.active {
        (attack_phase * std::f32::consts::PI).sin()
    } else {
        0.0
    };
    for (joint, mut transform) in &mut joints {
        match joint {
            KnightJoint::Torso => {
                transform.translation.y = crate::switch_knight_model::O_TORSO + idle
            }
            KnightJoint::ShoulderL => transform.rotation = Quat::from_rotation_x(stride * 0.65),
            KnightJoint::ShoulderR => {
                transform.rotation = Quat::from_rotation_x(-stride * 0.65 - swing * 1.05)
            }
            KnightJoint::HipL => transform.rotation = Quat::from_rotation_x(-stride),
            KnightJoint::HipR => transform.rotation = Quat::from_rotation_x(stride),
            KnightJoint::Sword => {
                transform.rotation = Quat::from_euler(
                    EulerRot::XYZ,
                    0.15 - swing * 1.25,
                    0.0,
                    -0.35 + swing * 0.85,
                )
            }
        }
    }
}

fn start_attack(mouse: Res<ButtonInput<MouseButton>>, mut attack: ResMut<HeroAttack>) {
    attack.auto_frames += 1;
    let auto_attack = cfg!(feature = "switch-emulator") && attack.auto_frames >= 12;
    if !attack.active && (mouse.just_pressed(MouseButton::Left) || auto_attack) {
        attack.elapsed = 0.0;
        attack.active = true;
        attack.hit_dealt = false;
        attack.auto_frames = 0;
        eprintln!("[warbell-switch-game] event=hero_attack_started");
    }
}

fn advance_attack(
    time: Res<Time>,
    hero: Single<&Transform, (With<WarbellHero>, Without<WarbellRival>)>,
    mut attack: ResMut<HeroAttack>,
    mut rivals: Query<(&Transform, &mut WarbellRival), Without<WarbellHero>>,
) {
    if !attack.active {
        return;
    }
    attack.elapsed += time.delta_secs();
    if !attack.hit_dealt && attack.elapsed >= 0.20 {
        attack.hit_dealt = true;
        let forward = hero.rotation * -Vec3::Z;
        for (transform, mut rival) in &mut rivals {
            let to_rival = transform.translation - hero.translation;
            let planar = Vec3::new(to_rival.x, 0.0, to_rival.z);
            if planar.length() <= 3.0 && planar.normalize_or_zero().dot(forward) >= 0.45 {
                rival.health = rival.health.saturating_sub(1);
                rival.hurt_for = 0.18;
                attack.hits += 1;
                eprintln!(
                    "[warbell-switch-game] event=rival_hit health={}",
                    rival.health
                );
                if rival.health == 0 {
                    rival.health = 4;
                    eprintln!("[warbell-switch-game] event=rival_defeated_and_reset");
                }
            }
        }
    }
    if attack.elapsed >= 0.48 {
        attack.active = false;
    }
}

pub(super) fn combat_proven(world: &World) -> bool {
    world.resource::<HeroAttack>().hits > 0
}

fn animate_rival_hit(time: Res<Time>, mut rivals: Query<(&mut Transform, &mut WarbellRival)>) {
    for (mut transform, mut rival) in &mut rivals {
        rival.hurt_for = (rival.hurt_for - time.delta_secs()).max(0.0);
        let pulse = if rival.hurt_for > 0.0 { 1.12 } else { 1.0 };
        transform.scale = Vec3::splat(0.6345 * pulse);
    }
}

fn follow_camera(
    hero: Single<&Transform, With<WarbellHero>>,
    mut camera: Single<&mut Transform, (With<WarbellCamera>, Without<WarbellHero>)>,
) {
    let target = hero.translation + Vec3::Y * 0.8;
    camera.translation = hero.translation + Vec3::new(4.5, 3.2, 6.0);
    camera.look_at(target, Vec3::Y);
}
