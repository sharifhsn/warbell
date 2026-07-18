use bevy::prelude::*;

#[path = "lines.rs"]
pub(crate) mod lines;
pub(crate) use lines::{Concept, Speaker};

#[derive(Clone, Copy, PartialEq, Eq)]
pub enum Surface {
    Dirt,
    Snow,
    Stone,
}

#[derive(Message, Clone, Copy)]
pub enum AudioCue {
    Swing,
    Dash,
    Roll,
    Sweep,
    Slam,
    Impact { kill: bool, crit: bool },
    Block,
    Footstep { surface: Surface, landing: bool },
    UiSelect,
    HeroGruntSwing,
    HeroJump,
    HeroHurt,
    HeroDeath,
    OrkGrunt(Vec3),
    OrkRoar(Vec3),
    BossRoar(Vec3),
    BossWindup(Vec3),
    CreatureBite { at: Vec3, big: bool },
    GuardStrike(Vec3),
    BowShot(Vec3),
    OreChip,
    WoodChop,
    TreeFall { cactus: bool },
    Forage,
    WarBell,
    OreShatter,
    ChestOpen,
    LevelUp,
    Gold,
    ShopBuy,
    CampRescue(Vec3),
    LowHp,
    FortressHorn(Vec3),
    WarpCast(Vec3),
    CreatureAggro(Vec3),
    SnowmanWake(Vec3),
    SnowmanSlam(Vec3),
}

#[derive(Message, Clone, Copy)]
pub struct Speak {
    pub concept: Concept,
    pub at: Option<Vec3>,
}
impl Speak {
    pub fn new(concept: Concept) -> Self {
        Self { concept, at: None }
    }
    pub fn at(concept: Concept, at: Vec3) -> Self {
        Self {
            concept,
            at: Some(at),
        }
    }
}

#[derive(Resource)]
pub struct AudioConfig {
    pub ambience_vol: f32,
    pub audible_range: f32,
    pub call_min: f32,
    pub call_max: f32,
    pub sfx_vol: f32,
    pub voice_vol: f32,
    pub music_vol: f32,
    pub narration_vol: f32,
    pub combat_music: f32,
}
impl AudioConfig {
    pub fn defaults() -> Self {
        Self {
            ambience_vol: 0.1,
            audible_range: 32.0,
            call_min: 30.0,
            call_max: 70.0,
            sfx_vol: 0.6,
            voice_vol: 0.6,
            music_vol: 0.154,
            narration_vol: 0.57,
            combat_music: 1.0,
        }
    }
}
impl Default for AudioConfig {
    fn default() -> Self {
        Self::defaults()
    }
}

#[derive(Resource, Default)]
pub struct MusicState {
    pub fighting: bool,
    pub warden_active: bool,
}

pub(crate) mod director {
    use super::*;
    use std::collections::HashSet;

    #[derive(Clone, Copy)]
    pub struct Offer {
        pub chain: lines::Chain,
        pub pos: Option<Vec3>,
        pub expires_at: f32,
    }
    #[derive(Component)]
    pub struct VoiceSink(pub Speaker);
    #[derive(Resource, Default)]
    pub struct OfferedReply(pub Option<Offer>);
    #[derive(Resource, Default)]
    pub struct VoiceManager {
        pub played_once: HashSet<&'static str>,
    }
    impl VoiceManager {
        pub fn hero_speaking(&self, _: f32) -> bool {
            false
        }
        pub fn others_speaking(&self, _: f32) -> bool {
            false
        }
        pub fn accept_reply(&mut self, _: Offer, _: f32) {}
    }
    pub use super::Speak;
}

#[derive(Component)]
pub struct SpatialListener;

impl SpatialListener {
    pub fn new(_: f32) -> Self {
        Self
    }
}
#[derive(Resource, Default)]
pub(crate) struct HeroLineGates;
#[derive(Resource, Default)]
pub(crate) struct HeroLineCooldown;
#[derive(Resource, Default)]
pub(crate) struct HeroThreat;
#[derive(Resource, Default)]
pub(crate) struct RemarkTrigger;

pub struct GameAudioPlugin;
impl Plugin for GameAudioPlugin {
    fn build(&self, app: &mut App) {
        app.init_resource::<AudioConfig>()
            .init_resource::<MusicState>()
            .init_resource::<HeroLineGates>()
            .init_resource::<HeroLineCooldown>()
            .init_resource::<HeroThreat>()
            .init_resource::<RemarkTrigger>()
            .init_resource::<director::VoiceManager>()
            .init_resource::<director::OfferedReply>()
            .add_message::<AudioCue>()
            .add_message::<Speak>()
            .add_systems(Update, drain_audio_requests);
    }
}

fn drain_audio_requests(mut cues: MessageReader<AudioCue>, mut speech: MessageReader<Speak>) {
    cues.clear();
    speech.clear();
}
