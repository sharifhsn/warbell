struct VertexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    @builtin(instance_index) instance_index: u32,
    @location(0) position: vec3<f32>,
    @location(1) normal: vec3<f32>,
    @location(2) uv: vec2<f32>,
    @location(5) color: vec4<f32>,
}

struct VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    @builtin(position) position: vec4<f32>,
    @location(0) world_position: vec4<f32>,
    @location(1) world_normal: vec3<f32>,
    @location(2) uv: vec2<f32>,
    @location(5) color: vec4<f32>,
    @location(6) @interpolate(flat) instance_index: u32,
}

struct MeshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX {
    world_from_local: mat3x4<f32>,
    previous_world_from_local: mat3x4<f32>,
    local_from_world_transpose_a: mat2x4<f32>,
    local_from_world_transpose_b: f32,
    flags: u32,
    lightmap_uv_rect: vec2<u32>,
    first_vertex_index: u32,
    current_skin_index: u32,
    material_and_lightmap_bind_group_slot: u32,
    tag: u32,
    morph_descriptor_index: u32,
}

struct ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX {
    balance: mat3x3<f32>,
    saturation: vec3<f32>,
    contrast: vec3<f32>,
    gamma: vec3<f32>,
    gain: vec3<f32>,
    lift: vec3<f32>,
    midtone_range: vec2<f32>,
    exposure: f32,
    hue: f32,
    post_saturation: f32,
}

struct ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX {
    clip_from_world: mat4x4<f32>,
    unjittered_clip_from_world: mat4x4<f32>,
    world_from_clip: mat4x4<f32>,
    world_from_view: mat4x4<f32>,
    view_from_world: mat4x4<f32>,
    clip_from_view: mat4x4<f32>,
    view_from_clip: mat4x4<f32>,
    world_position: vec3<f32>,
    exposure: f32,
    viewport: vec4<f32>,
    main_pass_viewport: vec4<f32>,
    frustum: array<vec4<f32>, 6>,
    lod_view_world_position: vec3<f32>,
    color_grading: ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX,
    mip_bias: f32,
    frame_count: u32,
}

struct DirectionalCascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    clip_from_world: mat4x4<f32>,
    texel_size: f32,
    far_bound: f32,
}

struct DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    cascades: array<DirectionalCascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX, 4>,
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

struct RectLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    color: vec4<f32>,
    position: vec3<f32>,
    width: f32,
    right: vec3<f32>,
    height: f32,
    up: vec3<f32>,
    range: f32,
}

struct LightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    directional_lights: array<DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX, 10>,
    ambient_color: vec4<f32>,
    cluster_dimensions: vec4<u32>,
    cluster_factors: vec4<f32>,
    n_directional_lights: u32,
    spot_light_shadowmap_offset: i32,
    ambient_light_affects_lightmapped_meshes: u32,
    n_rect_lights: u32,
    rect_lights: array<RectLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX, 8>,
}

struct ClusteredLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    light_custom_data: vec4<f32>,
    color_inverse_square_range: vec4<f32>,
    position_radius: vec4<f32>,
    flags: u32,
    shadow_depth_bias: f32,
    shadow_normal_bias: f32,
    spot_light_tan_angle: f32,
    soft_shadow_size: f32,
    shadow_map_near_z: f32,
    decal_index: u32,
    range: f32,
}

struct ClusteredLightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    data: array<ClusteredLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX, 204>,
}

struct ClusterableObjectIndexListsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    data: array<vec4<u32>, 1024>,
}

struct ClusterOffsetsAndCountsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    data: array<vec4<u32>, 1024>,
}

struct LightProbeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    light_from_world_transposed: mat3x4<f32>,
    falloff: vec3<f32>,
    bounding_sphere_radius: f32,
    parallax_correction_bounds: vec3<f32>,
    intensity: f32,
    world_position: vec3<f32>,
    cubemap_index: i32,
    flags: u32,
}

struct LightProbesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    reflection_probes: array<LightProbeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX, 8>,
    irradiance_volumes: array<LightProbeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX, 8>,
    reflection_probe_count: i32,
    irradiance_volume_count: i32,
    view_cubemap_index: i32,
    smallest_specular_mip_level_for_view: u32,
    view_rotation: vec4<f32>,
    intensity_for_view: f32,
    view_environment_map_affects_lightmapped_mesh_diffuse: u32,
}

struct GlobalsX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUZ3MN5RGC3DTX {
    time: f32,
    delta_time: f32,
    frame_count: u32,
}

struct PreviousViewUniformsX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV6YTJNZSGS3THOMX {
    view_from_world: mat4x4<f32>,
    clip_from_world: mat4x4<f32>,
    clip_from_view: mat4x4<f32>,
    world_from_clip: mat4x4<f32>,
    view_from_clip: mat4x4<f32>,
}

const MESH_FLAGS_SIGN_DETERMINANT_MODEL_3X3_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX: u32 = 2147483648u;

@group(2) @binding(0) 
var<uniform> meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX_1: array<MeshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX, 93>;
@group(0) @binding(0) 
var<uniform> viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX;
@group(0) @binding(2) 
var<uniform> previous_view_uniformsX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV6YTJNZSGS3THOMX: PreviousViewUniformsX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV6YTJNZSGS3THOMX;

fn affine3_to_squareX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(affine: mat3x4<f32>) -> mat4x4<f32> {
    return transpose(mat4x4<f32>(affine[0], affine[1], affine[2], vec4<f32>(0f, 0f, 0f, 1f)));
}

fn mat2x4_f32_to_mat3x3_unpackX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(a: mat2x4<f32>, b: f32) -> mat3x3<f32> {
    return mat3x3<f32>(a[0].xyz, vec3<f32>(a[0].w, a[1].xy), vec3<f32>(a[1].zw, b));
}

fn position_world_to_clipX_naga_oil_mod_XMJSXM6K7OBRHEOR2OZUWK527ORZGC3TTMZXXE3LBORUW63TTX(world_pos: vec3<f32>) -> vec4<f32> {
    let _e2: mat4x4<f32> = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.clip_from_world;
    let clip_pos: vec4<f32> = (_e2 * vec4<f32>(world_pos, 1f));
    return clip_pos;
}

fn get_world_from_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(instance_index: u32) -> mat4x4<f32> {
    let _e4: mat3x4<f32> = meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX_1[instance_index].world_from_local;
    let _e5: mat4x4<f32> = affine3_to_squareX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e4);
    return _e5;
}

fn mesh_position_local_to_worldX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(world_from_local_1: mat4x4<f32>, vertex_position: vec4<f32>) -> vec4<f32> {
    return (world_from_local_1 * vertex_position);
}

fn mesh_normal_local_to_worldX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(vertex_normal: vec3<f32>, instance_index_1: u32) -> vec3<f32> {
    if any((vertex_normal != vec3(0f))) {
        let _e9: mat2x4<f32> = meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX_1[instance_index_1].local_from_world_transpose_a;
        let _e13: f32 = meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX_1[instance_index_1].local_from_world_transpose_b;
        let _e14: mat3x3<f32> = mat2x4_f32_to_mat3x3_unpackX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e9, _e13);
        return normalize((_e14 * vertex_normal));
    } else {
        return vertex_normal;
    }
}

@vertex 
fn vertex(vertex_no_morph: VertexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX) -> VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    var out: VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX;
    var vertex_1: VertexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX;
    var world_from_local: mat4x4<f32>;

    vertex_1 = vertex_no_morph;
    let _e3: mat4x4<f32> = get_world_from_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(vertex_no_morph.instance_index);
    world_from_local = _e3;
    let _e8: vec3<f32> = vertex_1.normal;
    let _e10: vec3<f32> = mesh_normal_local_to_worldX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(_e8, vertex_no_morph.instance_index);
    out.world_normal = _e10;
    let _e12: mat4x4<f32> = world_from_local;
    let _e14: vec3<f32> = vertex_1.position;
    let _e17: vec4<f32> = mesh_position_local_to_worldX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(_e12, vec4<f32>(_e14, 1f));
    out.world_position = _e17;
    let _e20: vec4<f32> = out.world_position;
    let _e22: vec4<f32> = position_world_to_clipX_naga_oil_mod_XMJSXM6K7OBRHEOR2OZUWK527ORZGC3TTMZXXE3LBORUW63TTX(_e20.xyz);
    out.position = _e22;
    let _e25: vec2<f32> = vertex_1.uv;
    out.uv = _e25;
    let _e28: vec4<f32> = vertex_1.color;
    out.color = _e28;
    out.instance_index = vertex_no_morph.instance_index;
    let _e31: VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX = out;
    return _e31;
}

@fragment 
fn fragment(meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX: VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX) -> @location(0) vec4<f32> {
    return meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX.color;
}
