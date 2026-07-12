use bevy::{
    prelude::*,
    render::{
        Render, RenderApp, RenderStartup, RenderSystems,
        render_resource::{
            FragmentState, LoadOp, Operations, PipelineCache, RenderPassColorAttachment,
            RenderPassDescriptor, RenderPipelineDescriptor, StoreOp, TextureFormat, VertexState,
        },
        renderer::{RenderDevice, RenderQueue},
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

#[derive(Resource)]
struct ProofShader(Handle<Shader>);

#[derive(Resource)]
struct ProofPipeline(bevy::render::render_resource::CachedRenderPipelineId);

impl Plugin for ShaderProofPlugin {
    fn build(&self, app: &mut App) {
        let shader = app
            .world_mut()
            .resource_mut::<Assets<Shader>>()
            .add(Shader::from_wgsl(WGSL, "warbell_shader_proof.wgsl"));
        app.sub_app_mut(RenderApp)
            .insert_resource(ProofShader(shader))
            .add_systems(RenderStartup, queue_proof_pipeline)
            .add_systems(
                Render,
                draw_proof
                    .after(RenderSystems::PrepareViews)
                    .before(RenderSystems::Render),
            );
    }
}

fn queue_proof_pipeline(
    mut commands: Commands,
    shader: Res<ProofShader>,
    pipeline_cache: Res<PipelineCache>,
) {
    let pipeline = pipeline_cache.queue_render_pipeline(RenderPipelineDescriptor {
        label: Some(LABEL.into()),
        vertex: VertexState {
            shader: shader.0.clone(),
            entry_point: Some("vs_main".into()),
            ..default()
        },
        fragment: Some(FragmentState {
            shader: shader.0.clone(),
            entry_point: Some("fs_main".into()),
            targets: vec![Some(bevy::render::render_resource::ColorTargetState {
                format: TextureFormat::Rgba8Unorm,
                blend: None,
                write_mask: bevy::render::render_resource::ColorWrites::ALL,
            })],
            ..default()
        }),
        ..default()
    });
    commands.insert_resource(ProofPipeline(pipeline));
}

fn draw_proof(
    windows: Res<ExtractedWindows>,
    pipeline_cache: Res<PipelineCache>,
    proof_pipeline: Res<ProofPipeline>,
    render_device: Res<RenderDevice>,
    render_queue: Res<RenderQueue>,
) {
    let window = windows
        .primary
        .and_then(|entity| windows.windows.get(&entity));
    let view = window.and_then(|window| window.swap_chain_texture_view.as_ref());
    let pipeline = pipeline_cache.get_render_pipeline(proof_pipeline.0);
    if !proof_draw_ready(window.is_some(), view.is_some(), pipeline.is_some()) {
        return;
    }
    let view = view.expect("proof draw readiness requires a swap-chain view");
    let pipeline = pipeline.expect("proof draw readiness requires a pipeline");
    let mut encoder = render_device.create_command_encoder(&default());
    {
        let mut pass = encoder.begin_render_pass(&RenderPassDescriptor {
            label: Some(LABEL),
            color_attachments: &[Some(RenderPassColorAttachment {
                view,
                depth_slice: None,
                resolve_target: None,
                ops: Operations {
                    load: LoadOp::Clear(wgpu::Color {
                        r: 0.02,
                        g: 0.08,
                        b: 0.02,
                        a: 1.0,
                    }),
                    store: StoreOp::Store,
                },
            })],
            depth_stencil_attachment: None,
            timestamp_writes: None,
            occlusion_query_set: None,
            multiview_mask: None,
        });
        pass.set_pipeline(pipeline);
        pass.draw(0..3, 0..1);
    }
    render_queue.submit([encoder.finish()]);
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
    use super::proof_draw_ready;

    #[test]
    fn draw_waits_for_window_view_and_pipeline() {
        assert!(proof_draw_ready(true, true, true));
        assert!(!proof_draw_ready(false, true, true));
        assert!(!proof_draw_ready(true, false, true));
        assert!(!proof_draw_ready(true, true, false));
    }
}
