struct VertexOutput {
    @builtin(position) position: vec4<f32>,
    @location(0) world_position: vec4<f32>,
    @location(1) world_normal: vec3<f32>,
    @location(2) uv: vec2<f32>,
    @location(6) @interpolate(flat) instance_index: u32,
}

struct DirectionalCascade {
    clip_from_world: mat4x4<f32>,
    texel_size: f32,
    far_bound: f32,
}

struct DirectionalLight {
    cascades: array<DirectionalCascade, 4>,
    color: vec4<f32>,
    direction_to_light: vec3<f32>,
    flags: u32,
    soft_shadow_size: f32,
    shadow_depth_bias: f32,
    shadow_normal_bias: f32,
    num_cascades: u32,
    cascades_overlap_proportion: f32,
    depth_texture_base_index: u32,
    decal_index: u32,
    sun_disk_angular_size: f32,
    sun_disk_intensity: f32,
}

struct RectLight {
    color: vec4<f32>,
    position: vec3<f32>,
    width: f32,
    right: vec3<f32>,
    height: f32,
    up: vec3<f32>,
    range: f32,
}

struct Lights {
    directional_lights: array<DirectionalLight, 10>,
    ambient_color: vec4<f32>,
    cluster_dimensions: vec4<u32>,
    cluster_factors: vec4<f32>,
    n_directional_lights: u32,
    spot_light_shadowmap_offset: i32,
    ambient_light_affects_lightmapped_meshes: u32,
    n_rect_lights: u32,
    rect_lights: array<RectLight, 8>,
}

struct Material {
    base_color: vec4<f32>,
}

@group(0) @binding(1)
var<uniform> lights: Lights;
@group(3) @binding(0)
var<uniform> material: Material;
@group(3) @binding(1)
var base_color_texture: texture_2d<f32>;
@group(3) @binding(2)
var base_color_sampler: sampler;

@fragment
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
    let base = material.base_color
        * textureSampleBias(base_color_texture, base_color_sampler, in.uv, 0.0);
    let normal = normalize(in.world_normal);
    var lighting = vec3(0.18);
    if lights.n_directional_lights > 0u {
        let light = lights.directional_lights[0];
        let light_color_max = max(max(light.color.r, light.color.g), light.color.b);
        let light_tint = light.color.rgb / max(light_color_max, 0.0001);
        let diffuse = max(dot(normal, normalize(light.direction_to_light)), 0.0);
        lighting += light_tint * diffuse * 0.82;
    }
    return vec4(base.rgb * lighting, base.a);
}
