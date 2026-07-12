use bevy::{
    app::AppExit,
    prelude::*,
    render::{
        render_resource::{FragmentState, PipelineCache, RenderPipelineDescriptor, VertexState},
        RenderApp, RenderStartup,
    },
};

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

pub fn run_capture() {
    let mut app = App::new();
    app.add_plugins(DefaultPlugins)
        .add_plugins(ShaderProofPlugin)
        .add_systems(Update, exit_after_capture);
    app.run();
}

struct ShaderProofPlugin;

#[derive(Resource)]
struct ProofShader(Handle<Shader>);

impl Plugin for ShaderProofPlugin {
    fn build(&self, app: &mut App) {
        let shader = app
            .world_mut()
            .resource_mut::<Assets<Shader>>()
            .add(Shader::from_wgsl(WGSL, "warbell_shader_proof.wgsl"));
        app.sub_app_mut(RenderApp)
            .insert_resource(ProofShader(shader))
            .add_systems(RenderStartup, queue_proof_pipeline);
    }
}

fn queue_proof_pipeline(shader: Res<ProofShader>, pipeline_cache: Res<PipelineCache>) {
    pipeline_cache.queue_render_pipeline(RenderPipelineDescriptor {
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
                format: bevy::render::render_resource::TextureFormat::Bgra8UnormSrgb,
                blend: None,
                write_mask: bevy::render::render_resource::ColorWrites::ALL,
            })],
            ..default()
        }),
        ..default()
    });
}

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
