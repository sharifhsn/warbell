use bevy::{
    asset::{AssetLoader, AssetServer, LoadContext, LoadState, io::Reader},
    prelude::*,
    reflect::TypePath,
    render::{
        RenderApp, RenderStartup,
        extract_resource::{ExtractResource, ExtractResourcePlugin},
        render_resource::{
            LoadOp, Operations, RenderPassColorAttachment, RenderPassDescriptor, RenderPipeline,
            StoreOp,
        },
        renderer::{PendingCommandBuffers, RenderDevice, RenderGraph, RenderGraphSystems},
        view::window::ExtractedWindows,
    },
};

#[cfg(feature = "shader-proof-capture")]
use bevy::app::AppExit;

const LABEL: &str = "warbell_shader_proof";
const WGSL: &str = r#"
struct VertexOutput {
    @builtin(position) position: vec4<f32>,
};

@vertex
fn vs_main(@builtin(vertex_index) index: u32) -> VertexOutput {
    let positions = array<vec2<f32>, 3>(
        vec2<f32>(0.0, 0.8),
        vec2<f32>(-0.8, -0.8),
        vec2<f32>(0.8, -0.8),
    );
    var output: VertexOutput;
    output.position = vec4<f32>(positions[index], 0.0, 1.0);
    return output;
}

@fragment
fn fs_main() -> @location(0) vec4<f32> {
    return vec4<f32>(0.1, 0.8, 0.3, 1.0);
}
"#;

#[cfg(feature = "shader-proof-capture")]
pub fn run_capture() {
    let mut app = App::new();
    app.add_plugins(DefaultPlugins)
        .add_plugins(ShaderProofPlugin)
        .add_systems(Update, exit_after_capture);
    app.run();
}

pub struct ShaderProofPlugin;

#[derive(Clone, Copy, Debug, Default, PartialEq, Resource)]
pub struct ProofInputState {
    left_stick: Vec2,
    action_pressed: bool,
}

#[derive(Clone, Copy, Debug, Default, PartialEq, Resource)]
struct ExtractedProofInput(ProofInputState);

impl ExtractResource for ExtractedProofInput {
    type Source = ProofInputState;

    fn extract_resource(source: &Self::Source) -> Self {
        Self(*source)
    }
}

#[derive(Clone, Copy, Debug, Default, Eq, PartialEq)]
enum ProofAssetState {
    #[default]
    NotLoaded,
    Loading,
    Loaded,
    Failed,
}

impl ProofAssetState {
    fn from_load_state(state: &LoadState) -> Self {
        match state {
            LoadState::NotLoaded => Self::NotLoaded,
            LoadState::Loading => Self::Loading,
            LoadState::Loaded => Self::Loaded,
            LoadState::Failed(_) => Self::Failed,
        }
    }
}

#[derive(Resource)]
struct ProofAssets {
    png: Handle<Image>,
    font: Handle<ProofFontAsset>,
    wgsl: Handle<Shader>,
}

#[derive(Asset, TypePath)]
struct ProofFontAsset;

#[derive(Default, TypePath)]
struct ProofFontLoader;

impl AssetLoader for ProofFontLoader {
    type Asset = ProofFontAsset;
    type Settings = ();
    type Error = std::io::Error;

    async fn load(
        &self,
        reader: &mut dyn Reader,
        _settings: &(),
        _load_context: &mut LoadContext<'_>,
    ) -> Result<Self::Asset, Self::Error> {
        let mut bytes = Vec::new();
        reader.read_to_end(&mut bytes).await?;
        if bytes.starts_with(&[0, 1, 0, 0]) || bytes.starts_with(b"OTTO") {
            Ok(ProofFontAsset)
        } else {
            Err(std::io::Error::new(
                std::io::ErrorKind::InvalidData,
                "proof font has an unsupported signature",
            ))
        }
    }

    fn extensions(&self) -> &[&str] {
        &["ttf", "otf"]
    }
}

#[derive(Clone, Copy, Debug, Default, Resource)]
struct ProofAssetStates {
    png: ProofAssetState,
    font: ProofAssetState,
    wgsl: ProofAssetState,
}

#[derive(Resource)]
struct ProofPipeline(RenderPipeline);

impl Plugin for ShaderProofPlugin {
    fn build(&self, app: &mut App) {
        app.init_asset::<ProofFontAsset>()
            .init_asset_loader::<ProofFontLoader>();
        let proof_assets = {
            let asset_server = app.world().resource::<AssetServer>();
            ProofAssets {
                png: asset_server.load("ui/menu_backdrop.png"),
                font: asset_server.load("fonts/Cinzel.ttf"),
                wgsl: asset_server.load("shaders/terrain.wgsl"),
            }
        };
        app.insert_resource(proof_assets)
            .init_resource::<ProofAssetStates>()
            .init_resource::<ProofInputState>()
            .add_plugins(ExtractResourcePlugin::<ExtractedProofInput>::default())
            .add_systems(Update, track_proof_assets);
        app.sub_app_mut(RenderApp)
            .add_systems(RenderStartup, queue_proof_pipeline)
            .add_systems(
                RenderGraph,
                draw_proof
                    .after(RenderGraphSystems::Render)
                    .before(RenderGraphSystems::Submit),
            );
    }
}

fn queue_proof_pipeline(mut commands: Commands, render_device: Res<RenderDevice>) {
    let shader = render_device
        .wgpu_device()
        .create_shader_module(wgpu::ShaderModuleDescriptor {
            label: Some(LABEL),
            source: wgpu::ShaderSource::Wgsl(WGSL.into()),
        });
    let layout =
        render_device
            .wgpu_device()
            .create_pipeline_layout(&wgpu::PipelineLayoutDescriptor {
                label: Some(LABEL),
                bind_group_layouts: &[],
                immediate_size: 0,
            });
    let pipeline = render_device.create_render_pipeline(&wgpu::RenderPipelineDescriptor {
        label: Some(LABEL),
        layout: Some(&layout),
        vertex: wgpu::VertexState {
            module: &shader,
            entry_point: Some("vs_main"),
            buffers: &[],
            compilation_options: default(),
        },
        primitive: default(),
        depth_stencil: None,
        multisample: default(),
        fragment: Some(wgpu::FragmentState {
            module: &shader,
            entry_point: Some("fs_main"),
            targets: &[Some(wgpu::ColorTargetState {
                format: wgpu::TextureFormat::Rgba8UnormSrgb,
                blend: None,
                write_mask: wgpu::ColorWrites::ALL,
            })],
            compilation_options: default(),
        }),
        multiview_mask: None,
        cache: None,
    });
    commands.insert_resource(ProofPipeline(pipeline));
}

fn draw_proof(
    windows: Res<ExtractedWindows>,
    proof_pipeline: Res<ProofPipeline>,
    render_device: Res<RenderDevice>,
    mut pending_command_buffers: ResMut<PendingCommandBuffers>,
) {
    let primary = windows.primary;
    let view = primary
        .and_then(|entity| windows.windows.get(&entity))
        .and_then(|window| window.swap_chain_texture_view.clone());
    if !proof_draw_ready(primary.is_some(), view.is_some(), true) {
        return;
    }
    let view = view.expect("proof draw readiness requires a swap-chain view");
    let pipeline = &proof_pipeline.0;
    let mut encoder = render_device.create_command_encoder(&default());
    {
        let mut pass = encoder.begin_render_pass(&RenderPassDescriptor {
            label: Some(LABEL),
            color_attachments: &[Some(RenderPassColorAttachment {
                view: &view,
                depth_slice: None,
                resolve_target: None,
                ops: Operations {
                    load: LoadOp::Load,
                    store: StoreOp::Store,
                },
            })],
            depth_stencil_attachment: None,
            timestamp_writes: None,
            occlusion_query_set: None,
            multiview_mask: None,
        });
        pass.set_pipeline(pipeline);
        pass.set_viewport(0.0, 0.0, 320.0, 180.0, 0.0, 1.0);
        pass.draw(0..3, 0..1);
    }
    pending_command_buffers.push([encoder.finish()]);
}

pub fn set_switch_input(world: &mut World, left_stick: Vec2, action_pressed: bool) {
    let next = ProofInputState {
        left_stick,
        action_pressed,
    };
    let mut input = world.resource_mut::<ProofInputState>();
    if *input != next {
        *input = next;
    }
}

pub fn log_switch_frame_status(world: &World, frame: u64) {
    let assets = world.resource::<ProofAssetStates>();
    let input = world.resource::<ProofInputState>();
    eprintln!(
        "[warbell-switch] phase=frame frame={frame} asset_png={:?} asset_font={:?} asset_wgsl={:?} provider=embedded_dksh proof_input_x={:.3} proof_input_y={:.3} proof_action={} proof_assets_ready={}",
        assets.png,
        assets.font,
        assets.wgsl,
        input.left_stick.x,
        input.left_stick.y,
        input.action_pressed,
        proof_assets_ready(*assets),
    );
}

fn track_proof_assets(
    asset_server: Res<AssetServer>,
    assets: Res<ProofAssets>,
    mut states: ResMut<ProofAssetStates>,
) {
    update_asset_state(
        "png",
        &mut states.png,
        asset_server.get_load_state(&assets.png),
    );
    update_asset_state(
        "font",
        &mut states.font,
        asset_server.get_load_state(&assets.font),
    );
    update_asset_state(
        "wgsl",
        &mut states.wgsl,
        asset_server.get_load_state(&assets.wgsl),
    );
}

fn update_asset_state(name: &str, current: &mut ProofAssetState, observed: Option<LoadState>) {
    let observed = observed.unwrap_or(LoadState::NotLoaded);
    let next = ProofAssetState::from_load_state(&observed);
    if !asset_state_changed(*current, next) {
        return;
    }
    *current = next;
    match observed {
        LoadState::Loaded => {
            println!("[warbell-switch] phase=proof_asset_loaded asset={name}")
        }
        LoadState::Failed(error) => {
            eprintln!("[warbell-switch] phase=proof_asset_failed asset={name} error={error}")
        }
        _ => println!("[warbell-switch] phase=proof_asset_state asset={name} state={next:?}"),
    }
}

fn asset_state_changed(current: ProofAssetState, next: ProofAssetState) -> bool {
    current != next
}

fn proof_assets_ready(states: ProofAssetStates) -> bool {
    matches!(states.png, ProofAssetState::Loaded)
        && matches!(states.font, ProofAssetState::Loaded)
        && matches!(states.wgsl, ProofAssetState::Loaded)
}

fn proof_clear_color(input: ProofInputState) -> wgpu::Color {
    let stick = input.left_stick;
    let x = stick.x as f64;
    let y = stick.y as f64;
    let action = if input.action_pressed { 0.55 } else { 0.0 };
    wgpu::Color {
        r: (0.55 + 0.25 * x.max(0.0) + action).min(1.0),
        g: (0.08 + 0.25 * y.max(0.0) + action * 0.3).min(1.0),
        b: (0.08 + 0.25 * (-x).max(0.0)).min(1.0),
        a: 1.0,
    }
}

#[cfg(feature = "shader-proof-capture")]
fn exit_after_capture(mut exit: MessageWriter<AppExit>) {
    let directory = std::env::var_os("BEVY_SHADER_CAPTURE_DIR")
        .map(std::path::PathBuf::from)
        .unwrap_or_else(|| "shader-captures".into());
    let Ok(manifest) = std::fs::read_to_string(directory.join("manifest.json")) else {
        return;
    };
    if manifest.contains(LABEL) {
        exit.write(AppExit::Success);
    }
}

fn proof_draw_ready(
    has_primary_window: bool,
    has_texture_view: bool,
    pipeline_ready: bool,
) -> bool {
    has_primary_window && has_texture_view && pipeline_ready
}

#[cfg(test)]
mod tests {
    use super::{
        ExtractedProofInput, ProofAssetState, ProofInputState, asset_state_changed,
        proof_clear_color, proof_draw_ready,
    };
    use bevy::prelude::Vec2;
    use bevy::render::extract_resource::ExtractResource;

    #[test]
    fn draw_waits_for_window_view_and_pipeline() {
        assert!(proof_draw_ready(true, true, true));
        assert!(!proof_draw_ready(false, true, true));
        assert!(!proof_draw_ready(true, false, true));
        assert!(!proof_draw_ready(true, true, false));
    }

    #[test]
    fn asset_state_transitions_are_logged_once_per_change() {
        assert!(asset_state_changed(
            ProofAssetState::NotLoaded,
            ProofAssetState::Loading
        ));
        assert!(asset_state_changed(
            ProofAssetState::Loading,
            ProofAssetState::Loaded
        ));
        assert!(!asset_state_changed(
            ProofAssetState::Loaded,
            ProofAssetState::Loaded
        ));
    }

    #[test]
    fn extracted_input_changes_the_clear_color() {
        let idle = proof_clear_color(ProofInputState::default());
        let active = proof_clear_color(ProofInputState {
            left_stick: Vec2::new(1.0, 0.5),
            action_pressed: true,
        });
        assert!(active.r > idle.r);
        assert!(active.g > idle.g);
    }

    #[test]
    fn extraction_preserves_controller_input_for_the_render_world() {
        let source = ProofInputState {
            left_stick: Vec2::new(-0.75, 0.25),
            action_pressed: true,
        };
        assert_eq!(ExtractedProofInput::extract_resource(&source).0, source);
    }
}
