struct VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    @builtin(position) position: vec4<f32>,
    @location(0) world_position: vec4<f32>,
    @location(1) world_normal: vec3<f32>,
    @location(2) uv: vec2<f32>,
    @location(5) color: vec4<f32>,
    @location(6) @interpolate(flat) instance_index: u32,
}

struct FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    @location(0) color: vec4<f32>,
}

struct StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX {
    base_color: vec4<f32>,
    emissive: vec4<f32>,
    attenuation_color: vec4<f32>,
    uv_transform: mat3x3<f32>,
    reflectance: vec3<f32>,
    perceptual_roughness: f32,
    metallic: f32,
    diffuse_transmission: f32,
    specular_transmission: f32,
    thickness: f32,
    ior: f32,
    attenuation_distance: f32,
    clearcoat: f32,
    clearcoat_perceptual_roughness: f32,
    anisotropy_strength: f32,
    anisotropy_rotation: vec2<f32>,
    flags: u32,
    alpha_cutoff: f32,
    parallax_depth_scale: f32,
    max_parallax_layer_count: f32,
    lightmap_exposure: f32,
    max_relief_mapping_search_steps: u32,
    deferred_lighting_pass_id: u32,
}

struct PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX {
    material: StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX,
    diffuse_occlusion: vec3<f32>,
    specular_occlusion: f32,
    frag_coord: vec4<f32>,
    world_position: vec4<f32>,
    world_normal: vec3<f32>,
    N: vec3<f32>,
    V: vec3<f32>,
    lightmap_light: vec3<f32>,
    clearcoat_N: vec3<f32>,
    anisotropy_strength: f32,
    anisotropy_T: vec3<f32>,
    anisotropy_B: vec3<f32>,
    is_orthographic: bool,
    flags: u32,
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

struct LayerLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX {
    N: vec3<f32>,
    R: vec3<f32>,
    NdotV: f32,
    perceptual_roughness: f32,
    roughness: f32,
}

struct LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX {
    layers: array<LayerLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX, 1>,
    P: vec3<f32>,
    V: vec3<f32>,
    diffuse_color: vec3<f32>,
    metallic: f32,
    F0_dielectric: vec3<f32>,
    F0_metallic: vec3<f32>,
    F_ab: vec2<f32>,
}

struct DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX {
    H: vec3<f32>,
    NdotL: f32,
    NdotH: f32,
    LdotH: f32,
}

struct ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX {
    first_point_light_index_offset: u32,
    first_spot_light_index_offset: u32,
    first_reflection_probe_index_offset: u32,
    first_irradiance_volume_index_offset: u32,
    first_decal_offset: u32,
    last_clusterable_object_index_offset: u32,
}

struct SampleBiasX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX {
    mip_bias: f32,
}

struct PreviousViewUniformsX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV6YTJNZSGS3THOMX {
    view_from_world: mat4x4<f32>,
    clip_from_world: mat4x4<f32>,
    clip_from_view: mat4x4<f32>,
    world_from_clip: mat4x4<f32>,
    view_from_clip: mat4x4<f32>,
}

struct CreatureParams {
    params: vec4<f32>,
}

const STANDARD_MATERIAL_FLAGS_BASE_COLOR_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 1u;
const STANDARD_MATERIAL_FLAGS_EMISSIVE_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 2u;
const STANDARD_MATERIAL_FLAGS_METALLIC_ROUGHNESS_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 4u;
const STANDARD_MATERIAL_FLAGS_OCCLUSION_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 8u;
const STANDARD_MATERIAL_FLAGS_DOUBLE_SIDED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 16u;
const STANDARD_MATERIAL_FLAGS_UNLIT_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 32u;
const STANDARD_MATERIAL_FLAGS_ALPHA_MODE_OPAQUEX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 0u;
const STANDARD_MATERIAL_FLAGS_TWO_COMPONENT_NORMAL_MAPX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 64u;
const STANDARD_MATERIAL_FLAGS_FLIP_NORMAL_MAP_YX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 128u;
const STANDARD_MATERIAL_FLAGS_ALPHA_MODE_RESERVED_BITSX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX: u32 = 3758096384u;
const PIX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX: f32 = 3.1415927f;
const POINT_LIGHT_FLAGS_SPOT_LIGHT_Y_NEGATIVEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX: u32 = 2u;
const LAYER_BASEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX: u32 = 0u;
const CLUSTER_COUNT_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX: u32 = 9u;
const MESH_FLAGS_SHADOW_RECEIVER_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX: u32 = 536870912u;
const POINT_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX: u32 = 1u;
const DIRECTIONAL_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX: u32 = 1u;
const PI_2X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX: f32 = 6.2831855f;
const SPIRAL_OFFSET_0_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX: vec2<f32> = vec2<f32>(-0.7071f, 0.7071f);
const SPIRAL_OFFSET_1_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX: vec2<f32> = vec2<f32>(-0f, -0.875f);
const SPIRAL_OFFSET_2_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX: vec2<f32> = vec2<f32>(0.5303f, 0.5303f);
const SPIRAL_OFFSET_3_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX: vec2<f32> = vec2<f32>(-0.625f, -0f);
const SPIRAL_OFFSET_4_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX: vec2<f32> = vec2<f32>(0.3536f, -0.3536f);
const SPIRAL_OFFSET_5_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX: vec2<f32> = vec2<f32>(-0f, 0.375f);
const SPIRAL_OFFSET_6_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX: vec2<f32> = vec2<f32>(-0.1768f, -0.1768f);
const SPIRAL_OFFSET_7_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX: vec2<f32> = vec2<f32>(0.125f, -0f);
const SPOT_SHADOW_TEXEL_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX: f32 = 0.013427734f;
const POINT_SHADOW_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX: f32 = 0.003f;
const POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX: f32 = 0.5f;
const FRAC_PI_3X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX: f32 = 1.0471976f;
const flip_zX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX: vec3<f32> = vec3<f32>(1f, 1f, -1f);
const MESH_FLAGS_SIGN_DETERMINANT_MODEL_3X3_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX: u32 = 2147483648u;

@group(2) @binding(0) 
var<uniform> meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX: array<MeshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX, 93>;
@group(0) @binding(0) 
var<uniform> viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX;
@group(0) @binding(1) 
var<uniform> lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: LightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX;
@group(0) @binding(8) 
var<uniform> clustered_lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: ClusteredLightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX;
@group(0) @binding(9) 
var<uniform> clusterable_object_index_listsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: ClusterableObjectIndexListsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX;
@group(0) @binding(10) 
var<uniform> cluster_offsets_and_countsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: ClusterOffsetsAndCountsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX;
@group(0) @binding(2) 
var point_shadow_texturesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: texture_depth_cube_array;
@group(0) @binding(3) 
var point_shadow_textures_comparison_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: sampler_comparison;
@group(0) @binding(5) 
var directional_shadow_texturesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: texture_depth_2d_array;
@group(0) @binding(6) 
var directional_shadow_textures_comparison_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: sampler_comparison;
@group(0) @binding(11) 
var<uniform> globalsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX: GlobalsX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUZ3MN5RGC3DTX;
@group(0) @binding(18) 
var dt_lut_textureX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM5PWY5LUL5RGS3TENFXGO4YX: texture_3d<f32>;
@group(0) @binding(19) 
var dt_lut_samplerX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM5PWY5LUL5RGS3TENFXGO4YX: sampler;
@group(3) @binding(0) 
var<uniform> materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX;
@group(3) @binding(1) 
var base_color_textureX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: texture_2d<f32>;
@group(3) @binding(2) 
var base_color_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: sampler;
@group(3) @binding(3) 
var emissive_textureX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: texture_2d<f32>;
@group(3) @binding(4) 
var emissive_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: sampler;
@group(3) @binding(5) 
var metallic_roughness_textureX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: texture_2d<f32>;
@group(3) @binding(6) 
var metallic_roughness_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: sampler;
@group(3) @binding(7) 
var occlusion_textureX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: texture_2d<f32>;
@group(3) @binding(8) 
var occlusion_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX: sampler;
@group(0) @binding(2) 
var<uniform> previous_view_uniformsX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV6YTJNZSGS3THOMX: PreviousViewUniformsX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV6YTJNZSGS3THOMX;
@group(3) @binding(100) 
var<uniform> creature: CreatureParams;

fn standard_material_newX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX() -> StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX {
    var material: StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX;

    material.base_color = vec4<f32>(1f, 1f, 1f, 1f);
    material.emissive = vec4<f32>(0f, 0f, 0f, 1f);
    material.perceptual_roughness = 0.5f;
    material.metallic = 0f;
    material.reflectance = vec3(0.5f);
    material.diffuse_transmission = 0f;
    material.specular_transmission = 0f;
    material.thickness = 0f;
    material.ior = 1.5f;
    material.attenuation_distance = 1f;
    material.attenuation_color = vec4<f32>(1f, 1f, 1f, 1f);
    material.clearcoat = 0f;
    material.clearcoat_perceptual_roughness = 0f;
    material.flags = STANDARD_MATERIAL_FLAGS_ALPHA_MODE_OPAQUEX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX;
    material.alpha_cutoff = 0.5f;
    material.parallax_depth_scale = 0.1f;
    material.max_parallax_layer_count = 16f;
    material.max_relief_mapping_search_steps = 5u;
    material.deferred_lighting_pass_id = 1u;
    material.uv_transform = mat3x3<f32>(vec3<f32>(1f, 0f, 0f), vec3<f32>(0f, 1f, 0f), vec3<f32>(0f, 0f, 1f));
    let _e66: StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = material;
    return _e66;
}

fn pbr_input_newX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX() -> PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX {
    var pbr_input_1: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX;

    let _e2: StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = standard_material_newX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX();
    pbr_input_1.material = _e2;
    pbr_input_1.diffuse_occlusion = vec3(1f);
    pbr_input_1.specular_occlusion = 1f;
    pbr_input_1.frag_coord = vec4<f32>(0f, 0f, 0f, 1f);
    pbr_input_1.world_position = vec4<f32>(0f, 0f, 0f, 1f);
    pbr_input_1.world_normal = vec3<f32>(0f, 0f, 1f);
    pbr_input_1.is_orthographic = false;
    pbr_input_1.N = vec3<f32>(0f, 0f, 1f);
    pbr_input_1.V = vec3<f32>(1f, 0f, 0f);
    pbr_input_1.clearcoat_N = vec3(0f);
    pbr_input_1.anisotropy_T = vec3(0f);
    pbr_input_1.anisotropy_B = vec3(0f);
    pbr_input_1.lightmap_light = vec3(0f);
    pbr_input_1.flags = 0u;
    let _e51: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = pbr_input_1;
    return _e51;
}

fn copysignX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(a: f32, b: f32) -> f32 {
    return bitcast<f32>(((bitcast<u32>(a) & 2147483647u) | (bitcast<u32>(b) & 2147483648u)));
}

fn orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(z_basis: vec3<f32>) -> mat3x3<f32> {
    let _e3: f32 = copysignX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(1f, z_basis.z);
    let a_3: f32 = (-1f / (_e3 + z_basis.z));
    let b_2: f32 = ((z_basis.x * z_basis.y) * a_3);
    let x_basis_2: vec3<f32> = vec3<f32>((1f + (((_e3 * z_basis.x) * z_basis.x) * a_3)), (_e3 * b_2), (-(_e3) * z_basis.x));
    let y_basis_2: vec3<f32> = vec3<f32>(b_2, (_e3 + ((z_basis.y * z_basis.y) * a_3)), -(z_basis.y));
    return mat3x3<f32>(x_basis_2, y_basis_2, z_basis);
}

fn F_ABX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(perceptual_roughness: f32, NdotV: f32) -> vec2<f32> {
    let c0_: vec4<f32> = vec4<f32>(-1f, -0.0275f, -0.572f, 0.022f);
    let c1_: vec4<f32> = vec4<f32>(1f, 0.0425f, 1.04f, -0.04f);
    let r: vec4<f32> = ((perceptual_roughness * c0_) + c1_);
    let a004_: f32 = ((min((r.x * r.x), exp2((-9.28f * NdotV))) * r.x) + r.y);
    return max(((vec2<f32>(-1.04f, 1.04f) * a004_) + r.zw), vec2(0.00005f));
}

fn perceptualRoughnessToRoughnessX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(perceptualRoughness: f32) -> f32 {
    let clampedPerceptualRoughness: f32 = clamp(perceptualRoughness, 0.089f, 1f);
    return (clampedPerceptualRoughness * clampedPerceptualRoughness);
}

fn getRangeFalloffX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(distanceSquare: f32, inverseRangeSquared: f32) -> f32 {
    let factor: f32 = (distanceSquare * inverseRangeSquared);
    let smoothFactor: f32 = saturate((1f - (factor * factor)));
    return (smoothFactor * smoothFactor);
}

fn getDistanceAttenuationX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(distanceSquare_1: f32, inverseRangeSquared_1: f32) -> f32 {
    let _e2: f32 = getRangeFalloffX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(distanceSquare_1, inverseRangeSquared_1);
    return ((_e2 * 1f) / max(distanceSquare_1, 0.0001f));
}

fn compute_specular_layer_values_for_point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input: ptr<function, LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX>, layer: u32, V: vec3<f32>, light_to_frag: vec3<f32>, light_radius: f32, distance_: f32) -> vec4<f32> {
    var LtFdotR: f32;

    let R: vec3<f32> = (*input).layers[layer].R;
    let a_4: f32 = (*input).layers[layer].roughness;
    LtFdotR = dot(light_to_frag, R);
    let _e13: f32 = LtFdotR;
    LtFdotR = max(0.0001f, _e13);
    let _e16: f32 = LtFdotR;
    let centerToRay: vec3<f32> = ((_e16 * R) - light_to_frag);
    let closestPoint: vec3<f32> = (light_to_frag + (centerToRay * saturate((light_radius * inverseSqrt(dot(centerToRay, centerToRay))))));
    let LspecLengthInverse: f32 = inverseSqrt(dot(closestPoint, closestPoint));
    let a_prime: f32 = saturate((a_4 + (light_radius / (2f * distance_))));
    let L_1: vec3<f32> = (closestPoint * LspecLengthInverse);
    return vec4<f32>(L_1, a_prime);
}

fn derive_lighting_inputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(N: vec3<f32>, V_1: vec3<f32>, L: vec3<f32>) -> DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX {
    var input_1: DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX;
    var H: vec3<f32>;

    H = normalize((L + V_1));
    let _e7: vec3<f32> = H;
    input_1.H = _e7;
    input_1.NdotL = saturate(dot(N, L));
    let _e13: vec3<f32> = H;
    input_1.NdotH = saturate(dot(N, _e13));
    let _e17: vec3<f32> = H;
    input_1.LdotH = saturate(dot(L, _e17));
    let _e20: DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX = input_1;
    return _e20;
}

fn specular_fix_remapX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(a_1: f32) -> f32 {
    let inv_a_sq: f32 = ((1f - a_1) * (1f - a_1));
    return (1f - (inv_a_sq * inv_a_sq));
}

fn D_GGXX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(roughness: f32, NdotH: f32) -> f32 {
    let oneMinusNdotHSquared: f32 = (1f - (NdotH * NdotH));
    let a_5: f32 = (NdotH * roughness);
    let k: f32 = (roughness / (oneMinusNdotHSquared + (a_5 * a_5)));
    let d: f32 = ((k * k) * 0.31830987f);
    return d;
}

fn V_SmithGGXCorrelatedX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(roughness_1: f32, NdotV_1: f32, NdotL: f32) -> f32 {
    let a2_: f32 = (roughness_1 * roughness_1);
    let lambdaV: f32 = (NdotL * sqrt((((NdotV_1 - (a2_ * NdotV_1)) * NdotV_1) + a2_)));
    let lambdaL: f32 = (NdotV_1 * sqrt((((NdotL - (a2_ * NdotL)) * NdotL) + a2_)));
    let v_1: f32 = (0.5f / (lambdaV + lambdaL));
    return v_1;
}

fn F_Schlick_vecX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(f0_: vec3<f32>, f90_: f32, VdotH: f32) -> vec3<f32> {
    return (f0_ + ((vec3(f90_) - f0_) * pow((1f - VdotH), 5f)));
}

fn fresnelX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(f0_1: vec3<f32>, LdotH: f32) -> vec3<f32> {
    let f90_2: f32 = saturate(dot(f0_1, vec3(16.5f)));
    let _e6: vec3<f32> = F_Schlick_vecX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(f0_1, f90_2, LdotH);
    return _e6;
}

fn specular_multiscatterX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(D: f32, V_2: f32, F: vec3<f32>, F0_: vec3<f32>, F_ab: vec2<f32>, specular_intensity: f32) -> vec3<f32> {
    var Fr: vec3<f32>;

    Fr = (((specular_intensity * D) * V_2) * F);
    let _e8: vec3<f32> = Fr;
    Fr = (_e8 * (vec3(1f) + (F0_ * ((1f / (F_ab.x + F_ab.y)) - 1f))));
    let _e23: vec3<f32> = Fr;
    return _e23;
}

fn specularX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_2: ptr<function, LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX>, derived_input: ptr<function, DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX>, roughness_2: f32, specular_intensity_1: f32) -> vec3<f32> {
    let NdotV_3: f32 = (*input_2).layers[0].NdotV;
    let _e6: vec3<f32> = (*input_2).F0_dielectric;
    let _e8: vec3<f32> = (*input_2).F0_metallic;
    let _e10: f32 = (*input_2).metallic;
    let F0_2: vec3<f32> = mix(_e6, _e8, _e10);
    let NdotL_1: f32 = (*derived_input).NdotL;
    let NdotH_1: f32 = (*derived_input).NdotH;
    let LdotH_1: f32 = (*derived_input).LdotH;
    let _e20: f32 = D_GGXX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(roughness_2, NdotH_1);
    let _e21: f32 = V_SmithGGXCorrelatedX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(roughness_2, NdotV_3, NdotL_1);
    let _e22: vec3<f32> = fresnelX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(F0_2, LdotH_1);
    let _e24: vec2<f32> = (*input_2).F_ab;
    let _e26: vec3<f32> = specular_multiscatterX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(_e20, _e21, _e22, F0_2, _e24, specular_intensity_1);
    return _e26;
}

fn F_SchlickX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(f0_2: f32, f90_1: f32, VdotH_1: f32) -> f32 {
    return (f0_2 + ((f90_1 - f0_2) * pow((1f - VdotH_1), 5f)));
}

fn Fd_BurleyX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_3: ptr<function, LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX>, derived_input_1: ptr<function, DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX>) -> f32 {
    let roughness_3: f32 = (*input_3).layers[0].roughness;
    let NdotV_4: f32 = (*input_3).layers[0].NdotV;
    let NdotL_2: f32 = (*derived_input_1).NdotL;
    let LdotH_2: f32 = (*derived_input_1).LdotH;
    let f90_3: f32 = (0.5f + (((2f * roughness_3) * LdotH_2) * LdotH_2));
    let _e21: f32 = F_SchlickX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(1f, f90_3, NdotL_2);
    let _e23: f32 = F_SchlickX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(1f, f90_3, NdotV_4);
    return ((_e21 * _e23) * 0.31830987f);
}

fn point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(light_id: u32, input_4: ptr<function, LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX>, enable_diffuse: bool, enable_texture: bool) -> vec3<f32> {
    var specular_derived_input: DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX;
    var specular_light: vec3<f32>;
    var derived_input_2: DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX;
    var diffuse: vec3<f32> = vec3(0f);
    var color_times_NdotL: vec3<f32>;
    var texture_sample: f32 = 1f;

    let diffuse_color_1: vec3<f32> = (*input_4).diffuse_color;
    let P: vec3<f32> = (*input_4).P;
    let N_1: vec3<f32> = (*input_4).layers[0].N;
    let V_5: vec3<f32> = (*input_4).V;
    let light: ptr<uniform, ClusteredLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&clustered_lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[light_id]);
    let _e19: vec4<f32> = (*light).position_radius;
    let light_to_frag_1: vec3<f32> = (_e19.xyz - P);
    let L_2: vec3<f32> = normalize(light_to_frag_1);
    let distance_square: f32 = dot(light_to_frag_1, light_to_frag_1);
    let distance_1: f32 = sqrt(distance_square);
    let _e27: f32 = (*light).color_inverse_square_range.w;
    let _e28: f32 = getDistanceAttenuationX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(distance_square, _e27);
    let a_6: f32 = (*input_4).layers[0].roughness;
    let _e35: f32 = (*light).position_radius.w;
    let _e37: vec4<f32> = compute_specular_layer_values_for_point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_4, LAYER_BASEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX, V_5, light_to_frag_1, _e35, distance_1);
    let L_spec: vec3<f32> = _e37.xyz;
    let a_prime_1: f32 = _e37.w;
    let _e40: DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX = derive_lighting_inputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(N_1, V_5, L_spec);
    specular_derived_input = _e40;
    let normalizationFactor: f32 = (a_6 / a_prime_1);
    let specular_intensity_2: f32 = (normalizationFactor * normalizationFactor);
    let _e44: f32 = specular_fix_remapX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(a_6);
    let brdf_roughness: f32 = mix(a_6, a_prime_1, _e44);
    let _e46: vec3<f32> = specularX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_4, (&specular_derived_input), brdf_roughness, specular_intensity_2);
    specular_light = _e46;
    let light_radius_1: f32 = (*light).position_radius.w;
    if (light_radius_1 > 0f) {
        let solid_angle: f32 = ((light_radius_1 * light_radius_1) / (distance_1 * distance_1));
        let _e56: vec3<f32> = specular_light;
        let _e58: f32 = specular_derived_input.NdotL;
        let _e60: f32 = specular_derived_input.NdotL;
        specular_light = (_e56 * saturate((_e58 / max((_e60 + solid_angle), 0.0001f))));
    }
    let _e67: DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX = derive_lighting_inputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(N_1, V_5, L_2);
    derived_input_2 = _e67;
    if enable_diffuse {
        let _e70: f32 = Fd_BurleyX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_4, (&derived_input_2));
        diffuse = (diffuse_color_1 * _e70);
    }
    let _e73: vec3<f32> = diffuse;
    let _e75: f32 = derived_input_2.NdotL;
    let _e77: vec3<f32> = specular_light;
    let _e79: f32 = specular_derived_input.NdotL;
    color_times_NdotL = ((_e73 * _e75) + (_e77 * _e79));
    let _e84: vec3<f32> = color_times_NdotL;
    let _e86: vec4<f32> = (*light).color_inverse_square_range;
    let _e90: f32 = texture_sample;
    return (((_e84 * _e86.xyz) * _e28) * _e90);
}

fn spot_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(light_id_1: u32, input_5: ptr<function, LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX>, enable_diffuse_1: bool) -> vec3<f32> {
    var spot_dir: vec3<f32>;
    var texture_sample_1: f32 = 1f;

    let _e5: vec3<f32> = point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(light_id_1, input_5, enable_diffuse_1, false);
    let light_1: ptr<uniform, ClusteredLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&clustered_lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[light_id_1]);
    let _e11: f32 = (*light_1).light_custom_data.x;
    let _e14: f32 = (*light_1).light_custom_data.y;
    spot_dir = vec3<f32>(_e11, 0f, _e14);
    let _e20: f32 = spot_dir.x;
    let _e22: f32 = spot_dir.x;
    let _e27: f32 = spot_dir.z;
    let _e29: f32 = spot_dir.z;
    spot_dir.y = sqrt(max(0f, ((1f - (_e20 * _e22)) - (_e27 * _e29))));
    let _e36: u32 = (*light_1).flags;
    if ((_e36 & POINT_LIGHT_FLAGS_SPOT_LIGHT_Y_NEGATIVEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u) {
        let _e43: f32 = spot_dir.y;
        spot_dir.y = -(_e43);
    }
    let _e46: vec4<f32> = (*light_1).position_radius;
    let _e49: vec3<f32> = (*input_5).P;
    let light_to_frag_2: vec3<f32> = (_e46.xyz - _e49.xyz);
    let _e52: vec3<f32> = spot_dir;
    let cd: f32 = dot(-(_e52), normalize(light_to_frag_2));
    let _e58: f32 = (*light_1).light_custom_data.z;
    let _e62: f32 = (*light_1).light_custom_data.w;
    let attenuation: f32 = saturate(((cd * _e58) + _e62));
    let spot_attenuation: f32 = (attenuation * attenuation);
    let _e68: f32 = texture_sample_1;
    return ((_e5 * spot_attenuation) * _e68);
}

fn directional_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(light_id_2: u32, input_6: ptr<function, LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX>, enable_diffuse_2: bool) -> vec3<f32> {
    var derived_input_3: DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX;
    var diffuse_1: vec3<f32> = vec3(0f);
    var color: vec3<f32>;
    var texture_sample_2: f32 = 1f;

    let diffuse_color_2: vec3<f32> = (*input_6).diffuse_color;
    let NdotV_5: f32 = (*input_6).layers[0].NdotV;
    let N_2: vec3<f32> = (*input_6).layers[0].N;
    let V_6: vec3<f32> = (*input_6).V;
    let roughness_4: f32 = (*input_6).layers[0].roughness;
    let light_2: ptr<uniform, DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.directional_lights[light_id_2]);
    let _e25: vec3<f32> = (*light_2).direction_to_light;
    let L_3: vec3<f32> = _e25.xyz;
    let _e27: DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX = derive_lighting_inputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(N_2, V_6, L_3);
    derived_input_3 = _e27;
    if enable_diffuse_2 {
        let _e30: f32 = Fd_BurleyX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_6, (&derived_input_3));
        diffuse_1 = (diffuse_color_2 * _e30);
    }
    let _e34: vec3<f32> = specularX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_6, (&derived_input_3), roughness_4, 1f);
    let _e35: vec3<f32> = diffuse_1;
    let _e38: f32 = derived_input_3.NdotL;
    color = ((_e35 + _e34) * _e38);
    let _e42: vec3<f32> = color;
    let _e44: vec4<f32> = (*light_2).color;
    let _e46: f32 = texture_sample_2;
    color = (_e42 * (_e44.xyz * _e46));
    let _e49: vec3<f32> = color;
    return _e49;
}

fn view_z_to_z_sliceX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(cluster_factors: vec2<f32>, z_slices: u32, view_z: f32, is_orthographic: bool) -> u32 {
    var z_slice: u32 = 0u;

    if is_orthographic {
        z_slice = u32(floor(((view_z - cluster_factors.x) * cluster_factors.y)));
    } else {
        z_slice = u32((((log(-(view_z)) * cluster_factors.x) - cluster_factors.y) + 1f));
    }
    let _e20: u32 = z_slice;
    return min(_e20, (z_slices - 1u));
}

fn fragment_cluster_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(p: vec3<u32>, cluster_dimensions: vec4<u32>) -> u32 {
    return min(((((p.y * cluster_dimensions.x) + p.x) * cluster_dimensions.z) + p.z), (cluster_dimensions.w - 1u));
}

fn view_fragment_cluster_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(frag_coord: vec2<f32>, view_z_1: f32, is_orthographic_1: bool) -> u32 {
    let _e3: vec4<f32> = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.viewport;
    let _e8: vec4<f32> = lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.cluster_factors;
    let xy: vec2<u32> = vec2<u32>(floor(((frag_coord - _e3.xy) * _e8.xy)));
    let _e15: vec4<f32> = lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.cluster_factors;
    let _e20: u32 = lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.cluster_dimensions.z;
    let _e23: u32 = view_z_to_z_sliceX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e15.zw, _e20, view_z_1, is_orthographic_1);
    let _e27: vec4<u32> = lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.cluster_dimensions;
    let _e28: u32 = fragment_cluster_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(vec3<u32>(xy, _e23), _e27);
    return _e28;
}

fn unpack_clusterable_object_index_rangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(cluster_index: u32) -> ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX {
    let raw_offset_and_counts: u32 = cluster_offsets_and_countsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[(cluster_index >> 2u)][(cluster_index & 3u)];
    let offset_and_counts: vec3<u32> = vec3<u32>(((raw_offset_and_counts >> 18u) & 16383u), ((raw_offset_and_counts >> CLUSTER_COUNT_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX) & 511u), (raw_offset_and_counts & 511u));
    let offset_a: u32 = offset_and_counts.x;
    let offset_b: u32 = (offset_a + offset_and_counts.y);
    let offset_c: u32 = (offset_b + offset_and_counts.z);
    return ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(offset_a, offset_b, offset_c, offset_c, offset_c, offset_c);
}

fn get_clusterable_object_idX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(index: u32) -> u32 {
    let indices: u32 = clusterable_object_index_listsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[(index >> 4u)][((index >> 2u) & 3u)];
    return ((indices >> (8u * (index & 3u))) & 255u);
}

fn cluster_debug_visualizationX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(input_color: vec4<f32>, view_z_2: f32, is_orthographic_2: bool, clusterable_object_index_ranges: ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX, cluster_index_1: u32) -> vec4<f32> {
    var output_color: vec4<f32>;

    output_color = input_color;
    let _e2: vec4<f32> = output_color;
    return _e2;
}

fn interleaved_gradient_noiseX_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX(pixel_coordinates: vec2<f32>, frame: u32) -> f32 {
    let xy_1: vec2<f32> = (pixel_coordinates + vec2((5.588238f * f32((frame % 64u)))));
    return fract((52.982918f * fract(((0.06711056f * xy_1.x) + (0.00583715f * xy_1.y)))));
}

fn sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local: vec2<f32>, depth: f32, array_index: i32) -> f32 {
    let _e5: f32 = textureSampleCompareLevel(directional_shadow_texturesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX, directional_shadow_textures_comparison_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX, light_local, array_index, depth);
    return _e5;
}

fn sample_shadow_map_castano_thirteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_1: vec2<f32>, depth_1: f32, array_index_1: i32) -> f32 {
    var base_uv: vec2<f32>;
    var sum: f32 = 0f;

    let _e2: vec2<u32> = textureDimensions(directional_shadow_texturesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX);
    let shadow_map_size: vec2<f32> = vec2<f32>(_e2);
    let inv_shadow_map_size: vec2<f32> = (vec2(1f) / shadow_map_size);
    let uv_1: vec2<f32> = (light_local_1 * shadow_map_size);
    base_uv = floor((uv_1 + vec2(0.5f)));
    let _e18: f32 = base_uv.x;
    let s: f32 = ((uv_1.x + 0.5f) - _e18);
    let _e24: f32 = base_uv.y;
    let t: f32 = ((uv_1.y + 0.5f) - _e24);
    let _e26: vec2<f32> = base_uv;
    base_uv = (_e26 - vec2(0.5f));
    let _e30: vec2<f32> = base_uv;
    base_uv = (_e30 * inv_shadow_map_size);
    let uw0_: f32 = (4f - (3f * s));
    let uw2_: f32 = (1f + (3f * s));
    let u0_: f32 = (((3f - (2f * s)) / uw0_) - 2f);
    let u1_: f32 = ((3f + s) / 7f);
    let u2_: f32 = ((s / uw2_) + 2f);
    let vw0_: f32 = (4f - (3f * t));
    let vw2_: f32 = (1f + (3f * t));
    let v0_: f32 = (((3f - (2f * t)) / vw0_) - 2f);
    let v1_: f32 = ((3f + t) / 7f);
    let v2_: f32 = ((t / vw2_) + 2f);
    let _e77: f32 = sum;
    let _e79: vec2<f32> = base_uv;
    let _e85: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e79 + (vec2<f32>(u0_, v0_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e77 + ((uw0_ * vw0_) * _e85));
    let _e88: f32 = sum;
    let _e90: vec2<f32> = base_uv;
    let _e94: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e90 + (vec2<f32>(u1_, v0_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e88 + ((7f * vw0_) * _e94));
    let _e97: f32 = sum;
    let _e99: vec2<f32> = base_uv;
    let _e103: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e99 + (vec2<f32>(u2_, v0_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e97 + ((uw2_ * vw0_) * _e103));
    let _e106: f32 = sum;
    let _e108: vec2<f32> = base_uv;
    let _e112: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e108 + (vec2<f32>(u0_, v1_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e106 + ((uw0_ * 7f) * _e112));
    let _e115: f32 = sum;
    let _e117: vec2<f32> = base_uv;
    let _e121: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e117 + (vec2<f32>(u1_, v1_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e115 + ((7f * 7f) * _e121));
    let _e124: f32 = sum;
    let _e126: vec2<f32> = base_uv;
    let _e130: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e126 + (vec2<f32>(u2_, v1_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e124 + ((uw2_ * 7f) * _e130));
    let _e133: f32 = sum;
    let _e135: vec2<f32> = base_uv;
    let _e139: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e135 + (vec2<f32>(u0_, v2_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e133 + ((uw0_ * vw2_) * _e139));
    let _e142: f32 = sum;
    let _e144: vec2<f32> = base_uv;
    let _e148: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e144 + (vec2<f32>(u1_, v2_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e142 + ((7f * vw2_) * _e148));
    let _e151: f32 = sum;
    let _e153: vec2<f32> = base_uv;
    let _e157: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e153 + (vec2<f32>(u2_, v2_) * inv_shadow_map_size)), depth_1, array_index_1);
    sum = (_e151 + ((uw2_ * vw2_) * _e157));
    let _e160: f32 = sum;
    return (_e160 * 0.0069444445f);
}

fn sample_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_2: vec2<f32>, depth_2: f32, array_index_2: i32, frag_coord_xy: vec2<f32>, texel_size: f32) -> f32 {
    let _e3: f32 = sample_shadow_map_castano_thirteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_2, depth_2, array_index_2);
    return _e3;
}

fn search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_3: vec2<f32>, depth_3: f32, array_index_3: i32) -> vec2<f32> {
    return vec2(0f);
}

fn search_for_blockers_in_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_4: vec2<f32>, depth_4: f32, array_index_4: i32, texel_size_1: f32, search_size: f32) -> f32 {
    var sum_1: vec2<f32> = vec2(0f);

    let _e3: vec2<u32> = textureDimensions(directional_shadow_texturesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX);
    let shadow_map_size_1: vec2<f32> = vec2<f32>(_e3);
    let uv_offset_scale: vec2<f32> = (vec2(search_size) / (texel_size_1 * shadow_map_size_1));
    let offset0_: vec2<f32> = (vec2<f32>(0.125f, -0.375f) * uv_offset_scale);
    let offset1_: vec2<f32> = (vec2<f32>(-0.125f, 0.375f) * uv_offset_scale);
    let offset2_: vec2<f32> = (vec2<f32>(0.625f, 0.125f) * uv_offset_scale);
    let offset3_: vec2<f32> = (vec2<f32>(-0.375f, -0.625f) * uv_offset_scale);
    let offset4_: vec2<f32> = (vec2<f32>(-0.625f, 0.625f) * uv_offset_scale);
    let offset5_: vec2<f32> = (vec2<f32>(-0.875f, -0.125f) * uv_offset_scale);
    let offset6_: vec2<f32> = (vec2<f32>(0.375f, 0.875f) * uv_offset_scale);
    let offset7_: vec2<f32> = (vec2<f32>(0.875f, -0.875f) * uv_offset_scale);
    let _e44: vec2<f32> = sum_1;
    let _e48: vec2<f32> = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4 + offset0_), depth_4, array_index_4);
    sum_1 = (_e44 + _e48);
    let _e50: vec2<f32> = sum_1;
    let _e52: vec2<f32> = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4 + offset1_), depth_4, array_index_4);
    sum_1 = (_e50 + _e52);
    let _e54: vec2<f32> = sum_1;
    let _e56: vec2<f32> = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4 + offset2_), depth_4, array_index_4);
    sum_1 = (_e54 + _e56);
    let _e58: vec2<f32> = sum_1;
    let _e60: vec2<f32> = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4 + offset3_), depth_4, array_index_4);
    sum_1 = (_e58 + _e60);
    let _e62: vec2<f32> = sum_1;
    let _e64: vec2<f32> = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4 + offset4_), depth_4, array_index_4);
    sum_1 = (_e62 + _e64);
    let _e66: vec2<f32> = sum_1;
    let _e68: vec2<f32> = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4 + offset5_), depth_4, array_index_4);
    sum_1 = (_e66 + _e68);
    let _e70: vec2<f32> = sum_1;
    let _e72: vec2<f32> = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4 + offset6_), depth_4, array_index_4);
    sum_1 = (_e70 + _e72);
    let _e74: vec2<f32> = sum_1;
    let _e76: vec2<f32> = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4 + offset7_), depth_4, array_index_4);
    sum_1 = (_e74 + _e76);
    let _e79: f32 = sum_1.y;
    if (_e79 == 0f) {
        return 0f;
    }
    let _e84: f32 = sum_1.x;
    let _e86: f32 = sum_1.y;
    return (_e84 / _e86);
}

fn random_rotation_matrixX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(scale: vec2<f32>, temporal: bool) -> mat2x2<f32> {
    let _e4: u32 = globalsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.frame_count;
    let _e7: f32 = interleaved_gradient_noiseX_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX(scale, select(1u, _e4, temporal));
    let random_angle: f32 = (6.2831855f * _e7);
    let m: vec2<f32> = vec2<f32>(sin(random_angle), cos(random_angle));
    return mat2x2<f32>(vec2<f32>(m.y, -(m.x)), vec2<f32>(m.x, m.y));
}

fn mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(min1_: f32, max1_: f32, min2_: f32, max2_: f32, value: f32) -> f32 {
    return (min2_ + (((value - min1_) * (max2_ - min2_)) / (max1_ - min1_)));
}

fn calculate_uv_offset_scale_jimenez_fourteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(texel_size_2: f32, blur_size: f32) -> vec2<f32> {
    let _e1: vec2<u32> = textureDimensions(directional_shadow_texturesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX);
    let shadow_map_size_2: vec2<f32> = vec2<f32>(_e1);
    let _e8: f32 = mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(0.00390625f, 0.022949219f, 0.015f, 0.035f, texel_size_2);
    return (vec2((_e8 * blur_size)) / (texel_size_2 * shadow_map_size_2));
}

fn sample_shadow_map_jimenez_fourteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_5: vec2<f32>, depth_5: f32, array_index_5: i32, frag_coord_xy_1: vec2<f32>, texel_size_3: f32, blur_size_1: f32, temporal_1: bool) -> f32 {
    var sum_2: f32 = 0f;

    let _e3: mat2x2<f32> = random_rotation_matrixX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(frag_coord_xy_1, temporal_1);
    let _e6: vec2<f32> = calculate_uv_offset_scale_jimenez_fourteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(texel_size_3, blur_size_1);
    let sample_offset0_: vec2<f32> = ((_e3 * SPIRAL_OFFSET_0_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e6);
    let sample_offset1_: vec2<f32> = ((_e3 * SPIRAL_OFFSET_1_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e6);
    let sample_offset2_: vec2<f32> = ((_e3 * SPIRAL_OFFSET_2_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e6);
    let sample_offset3_: vec2<f32> = ((_e3 * SPIRAL_OFFSET_3_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e6);
    let sample_offset4_: vec2<f32> = ((_e3 * SPIRAL_OFFSET_4_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e6);
    let sample_offset5_: vec2<f32> = ((_e3 * SPIRAL_OFFSET_5_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e6);
    let sample_offset6_: vec2<f32> = ((_e3 * SPIRAL_OFFSET_6_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e6);
    let sample_offset7_: vec2<f32> = ((_e3 * SPIRAL_OFFSET_7_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e6);
    let _e33: f32 = sum_2;
    let _e37: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5 + sample_offset0_), depth_5, array_index_5);
    sum_2 = (_e33 + _e37);
    let _e39: f32 = sum_2;
    let _e41: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5 + sample_offset1_), depth_5, array_index_5);
    sum_2 = (_e39 + _e41);
    let _e43: f32 = sum_2;
    let _e45: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5 + sample_offset2_), depth_5, array_index_5);
    sum_2 = (_e43 + _e45);
    let _e47: f32 = sum_2;
    let _e49: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5 + sample_offset3_), depth_5, array_index_5);
    sum_2 = (_e47 + _e49);
    let _e51: f32 = sum_2;
    let _e53: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5 + sample_offset4_), depth_5, array_index_5);
    sum_2 = (_e51 + _e53);
    let _e55: f32 = sum_2;
    let _e57: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5 + sample_offset5_), depth_5, array_index_5);
    sum_2 = (_e55 + _e57);
    let _e59: f32 = sum_2;
    let _e61: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5 + sample_offset6_), depth_5, array_index_5);
    sum_2 = (_e59 + _e61);
    let _e63: f32 = sum_2;
    let _e65: f32 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5 + sample_offset7_), depth_5, array_index_5);
    sum_2 = (_e63 + _e65);
    let _e67: f32 = sum_2;
    return (_e67 / 8f);
}

fn sample_shadow_map_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_6: vec2<f32>, depth_6: f32, array_index_6: i32, frag_coord_xy_2: vec2<f32>, texel_size_4: f32, light_size: f32) -> f32 {
    let _e5: f32 = search_for_blockers_in_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_6, depth_6, array_index_6, texel_size_4, light_size);
    let blur_size_2: f32 = max((((_e5 - depth_6) * light_size) / depth_6), 0.5f);
    let _e13: f32 = sample_shadow_map_jimenez_fourteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_6, depth_6, array_index_6, frag_coord_xy_2, texel_size_4, blur_size_2, false);
    return _e13;
}

fn sample_shadow_cubemap_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_7: vec3<f32>, depth_7: f32, light_id_3: u32) -> f32 {
    let _e6: f32 = textureSampleCompareLevel(point_shadow_texturesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX, point_shadow_textures_comparison_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX, light_local_7, i32(light_id_3), depth_7);
    return _e6;
}

fn sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(position: vec2<f32>, coeff: f32, x_basis: vec3<f32>, y_basis: vec3<f32>, light_local_8: vec3<f32>, depth_8: f32, light_id_4: u32) -> f32 {
    let _e12: f32 = sample_shadow_cubemap_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(((light_local_8 + (position.x * x_basis)) + (position.y * y_basis)), depth_8, light_id_4);
    return (_e12 * coeff);
}

fn sample_shadow_cubemap_gaussianX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_9: vec3<f32>, depth_9: f32, scale_1: f32, distance_to_light: f32, light_id_5: u32) -> f32 {
    var sum_3: f32 = 0f;

    let _e3: mat3x3<f32> = orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(normalize(light_local_9));
    let basis: mat3x3<f32> = ((_e3 * scale_1) * distance_to_light);
    let _e9: f32 = sum_3;
    let _e18: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(0.125f, -0.375f), 0.157112f, basis[0], basis[1], light_local_9, depth_9, light_id_5);
    sum_3 = (_e9 + _e18);
    let _e20: f32 = sum_3;
    let _e27: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(-0.125f, 0.375f), 0.157112f, basis[0], basis[1], light_local_9, depth_9, light_id_5);
    sum_3 = (_e20 + _e27);
    let _e29: f32 = sum_3;
    let _e36: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(0.625f, 0.125f), 0.138651f, basis[0], basis[1], light_local_9, depth_9, light_id_5);
    sum_3 = (_e29 + _e36);
    let _e38: f32 = sum_3;
    let _e45: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(-0.375f, -0.625f), 0.130251f, basis[0], basis[1], light_local_9, depth_9, light_id_5);
    sum_3 = (_e38 + _e45);
    let _e47: f32 = sum_3;
    let _e54: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(-0.625f, 0.625f), 0.114946f, basis[0], basis[1], light_local_9, depth_9, light_id_5);
    sum_3 = (_e47 + _e54);
    let _e56: f32 = sum_3;
    let _e63: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(-0.875f, -0.125f), 0.114946f, basis[0], basis[1], light_local_9, depth_9, light_id_5);
    sum_3 = (_e56 + _e63);
    let _e65: f32 = sum_3;
    let _e72: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(0.375f, 0.875f), 0.107982f, basis[0], basis[1], light_local_9, depth_9, light_id_5);
    sum_3 = (_e65 + _e72);
    let _e74: f32 = sum_3;
    let _e81: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(0.875f, -0.875f), 0.079001f, basis[0], basis[1], light_local_9, depth_9, light_id_5);
    sum_3 = (_e74 + _e81);
    let _e83: f32 = sum_3;
    return _e83;
}

fn sample_shadow_cubemapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_10: vec3<f32>, distance_to_light_1: f32, depth_10: f32, light_id_6: u32, frag_coord_xy_3: vec2<f32>) -> f32 {
    let _e5: f32 = sample_shadow_cubemap_gaussianX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_10, depth_10, POINT_SHADOW_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX, distance_to_light_1, light_id_6);
    return _e5;
}

fn search_for_blockers_in_shadow_cubemap_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_11: vec3<f32>, depth_11: f32, light_id_7: u32) -> vec2<f32> {
    return vec2(0f);
}

fn search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(position_1: vec2<f32>, x_basis_1: vec3<f32>, y_basis_1: vec3<f32>, light_local_12: vec3<f32>, depth_12: f32, light_id_8: u32) -> vec2<f32> {
    let _e12: vec2<f32> = search_for_blockers_in_shadow_cubemap_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(((light_local_12 + (position_1.x * x_basis_1)) + (position_1.y * y_basis_1)), depth_12, light_id_8);
    return _e12;
}

fn search_for_blockers_in_shadow_cubemapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_13: vec3<f32>, depth_13: f32, scale_2: f32, distance_to_light_2: f32, light_id_9: u32) -> f32 {
    var sum_4: vec2<f32> = vec2(0f);

    let _e4: mat3x3<f32> = orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(normalize(light_local_13));
    let basis_1: mat3x3<f32> = ((_e4 * scale_2) * distance_to_light_2);
    let _e10: vec2<f32> = sum_4;
    let _e18: vec2<f32> = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(0.125f, -0.375f), basis_1[0], basis_1[1], light_local_13, depth_13, light_id_9);
    sum_4 = (_e10 + _e18);
    let _e20: vec2<f32> = sum_4;
    let _e26: vec2<f32> = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(-0.125f, 0.375f), basis_1[0], basis_1[1], light_local_13, depth_13, light_id_9);
    sum_4 = (_e20 + _e26);
    let _e28: vec2<f32> = sum_4;
    let _e34: vec2<f32> = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(0.625f, 0.125f), basis_1[0], basis_1[1], light_local_13, depth_13, light_id_9);
    sum_4 = (_e28 + _e34);
    let _e36: vec2<f32> = sum_4;
    let _e42: vec2<f32> = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(-0.375f, -0.625f), basis_1[0], basis_1[1], light_local_13, depth_13, light_id_9);
    sum_4 = (_e36 + _e42);
    let _e44: vec2<f32> = sum_4;
    let _e50: vec2<f32> = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(-0.625f, 0.625f), basis_1[0], basis_1[1], light_local_13, depth_13, light_id_9);
    sum_4 = (_e44 + _e50);
    let _e52: vec2<f32> = sum_4;
    let _e58: vec2<f32> = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(-0.875f, -0.125f), basis_1[0], basis_1[1], light_local_13, depth_13, light_id_9);
    sum_4 = (_e52 + _e58);
    let _e60: vec2<f32> = sum_4;
    let _e66: vec2<f32> = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(0.375f, 0.875f), basis_1[0], basis_1[1], light_local_13, depth_13, light_id_9);
    sum_4 = (_e60 + _e66);
    let _e68: vec2<f32> = sum_4;
    let _e74: vec2<f32> = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2<f32>(0.875f, -0.875f), basis_1[0], basis_1[1], light_local_13, depth_13, light_id_9);
    sum_4 = (_e68 + _e74);
    let _e77: f32 = sum_4.y;
    if (_e77 == 0f) {
        return 0f;
    }
    let _e82: f32 = sum_4.x;
    let _e84: f32 = sum_4.y;
    return (_e82 / _e84);
}

fn sample_shadow_cubemap_jitteredX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_14: vec3<f32>, depth_14: f32, frag_coord_xy_4: vec2<f32>, scale_3: f32, distance_to_light_3: f32, light_id_10: u32, temporal_2: bool) -> f32 {
    var sum_5: f32 = 0f;

    let _e3: mat2x2<f32> = random_rotation_matrixX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(frag_coord_xy_4, temporal_2);
    let sample_offset0_1: vec2<f32> = ((_e3 * SPIRAL_OFFSET_0_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    let sample_offset1_1: vec2<f32> = ((_e3 * SPIRAL_OFFSET_1_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    let sample_offset2_1: vec2<f32> = ((_e3 * SPIRAL_OFFSET_2_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    let sample_offset3_1: vec2<f32> = ((_e3 * SPIRAL_OFFSET_3_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    let sample_offset4_1: vec2<f32> = ((_e3 * SPIRAL_OFFSET_4_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    let sample_offset5_1: vec2<f32> = ((_e3 * SPIRAL_OFFSET_5_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    let sample_offset6_1: vec2<f32> = ((_e3 * SPIRAL_OFFSET_6_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    let sample_offset7_1: vec2<f32> = ((_e3 * SPIRAL_OFFSET_7_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    let _e38: mat3x3<f32> = orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(normalize(light_local_14));
    let basis_2: mat3x3<f32> = ((_e38 * scale_3) * distance_to_light_3);
    let _e44: f32 = sum_5;
    let _e50: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset0_1, 0.125f, basis_2[0], basis_2[1], light_local_14, depth_14, light_id_10);
    sum_5 = (_e44 + _e50);
    let _e52: f32 = sum_5;
    let _e56: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset1_1, 0.125f, basis_2[0], basis_2[1], light_local_14, depth_14, light_id_10);
    sum_5 = (_e52 + _e56);
    let _e58: f32 = sum_5;
    let _e62: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset2_1, 0.125f, basis_2[0], basis_2[1], light_local_14, depth_14, light_id_10);
    sum_5 = (_e58 + _e62);
    let _e64: f32 = sum_5;
    let _e68: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset3_1, 0.125f, basis_2[0], basis_2[1], light_local_14, depth_14, light_id_10);
    sum_5 = (_e64 + _e68);
    let _e70: f32 = sum_5;
    let _e74: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset4_1, 0.125f, basis_2[0], basis_2[1], light_local_14, depth_14, light_id_10);
    sum_5 = (_e70 + _e74);
    let _e76: f32 = sum_5;
    let _e80: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset5_1, 0.125f, basis_2[0], basis_2[1], light_local_14, depth_14, light_id_10);
    sum_5 = (_e76 + _e80);
    let _e82: f32 = sum_5;
    let _e86: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset6_1, 0.125f, basis_2[0], basis_2[1], light_local_14, depth_14, light_id_10);
    sum_5 = (_e82 + _e86);
    let _e88: f32 = sum_5;
    let _e92: f32 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset7_1, 0.125f, basis_2[0], basis_2[1], light_local_14, depth_14, light_id_10);
    sum_5 = (_e88 + _e92);
    let _e94: f32 = sum_5;
    return _e94;
}

fn sample_shadow_cubemap_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_15: vec3<f32>, distance_to_light_4: f32, depth_15: f32, light_id_11: u32, light_size_1: f32, frag_coord_xy_5: vec2<f32>) -> f32 {
    let _e5: f32 = search_for_blockers_in_shadow_cubemapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_15, depth_15, light_size_1, distance_to_light_4, light_id_11);
    let blur_size_3: f32 = max((((_e5 - depth_15) * light_size_1) / depth_15), 0.5f);
    let _e15: f32 = sample_shadow_cubemap_jitteredX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_15, depth_15, frag_coord_xy_5, (POINT_SHADOW_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX * blur_size_3), distance_to_light_4, light_id_11, false);
    return _e15;
}

fn hsv_to_rgbX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(hsv: vec3<f32>) -> vec3<f32> {
    let n: vec3<f32> = vec3<f32>(5f, 3f, 1f);
    let k_1: vec3<f32> = ((n + vec3((hsv.x / FRAC_PI_3X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX))) % vec3(6f));
    return (vec3(hsv.z) - ((hsv.z * hsv.y) * max(vec3(0f), min(k_1, min((vec3(4f) - k_1), vec3(1f))))));
}

fn fetch_point_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_12: u32, frag_position: vec4<f32>, surface_normal: vec3<f32>, frag_coord_xy_6: vec2<f32>) -> f32 {
    let light_3: ptr<uniform, ClusteredLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&clustered_lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[light_id_12]);
    let _e6: vec4<f32> = (*light_3).position_radius;
    let surface_to_light: vec3<f32> = (_e6.xyz - frag_position.xyz);
    let surface_to_light_abs: vec3<f32> = abs(surface_to_light);
    let distance_to_light_5: f32 = max(surface_to_light_abs.x, max(surface_to_light_abs.y, surface_to_light_abs.z));
    let _e18: f32 = (*light_3).shadow_normal_bias;
    let normal_offset: vec3<f32> = ((_e18 * distance_to_light_5) * surface_normal.xyz);
    let _e23: f32 = (*light_3).shadow_depth_bias;
    let depth_offset: vec3<f32> = (_e23 * normalize(surface_to_light.xyz));
    let offset_position_1: vec3<f32> = ((frag_position.xyz + normal_offset) + depth_offset);
    let _e32: vec4<f32> = (*light_3).position_radius;
    let frag_ls: vec3<f32> = (offset_position_1.xyz - _e32.xyz);
    let abs_position_ls: vec3<f32> = abs(frag_ls);
    let major_axis_magnitude: f32 = max(abs_position_ls.x, max(abs_position_ls.y, abs_position_ls.z));
    let _e43: vec4<f32> = (*light_3).light_custom_data;
    let _e47: vec4<f32> = (*light_3).light_custom_data;
    let zw: vec2<f32> = ((-(major_axis_magnitude) * _e43.xy) + _e47.zw);
    let depth_16: f32 = (zw.x / zw.y);
    let _e54: f32 = (*light_3).soft_shadow_size;
    if (_e54 > 0f) {
        let _e60: f32 = (*light_3).soft_shadow_size;
        let _e62: f32 = sample_shadow_cubemap_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((frag_ls * flip_zX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX), distance_to_light_5, depth_16, light_id_12, _e60, frag_coord_xy_6);
        return _e62;
    }
    let _e65: f32 = sample_shadow_cubemapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((frag_ls * flip_zX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX), distance_to_light_5, depth_16, light_id_12, frag_coord_xy_6);
    return _e65;
}

fn fetch_spot_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_13: u32, frag_position_1: vec4<f32>, surface_normal_1: vec3<f32>, near_z: f32, frag_coord_xy_7: vec2<f32>) -> f32 {
    var spot_dir_1: vec3<f32>;

    let light_4: ptr<uniform, ClusteredLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&clustered_lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[light_id_13]);
    let _e6: vec4<f32> = (*light_4).position_radius;
    let surface_to_light_1: vec3<f32> = (_e6.xyz - frag_position_1.xyz);
    let _e12: f32 = (*light_4).light_custom_data.x;
    let _e15: f32 = (*light_4).light_custom_data.y;
    spot_dir_1 = vec3<f32>(_e12, 0f, _e15);
    let _e21: f32 = spot_dir_1.x;
    let _e23: f32 = spot_dir_1.x;
    let _e28: f32 = spot_dir_1.z;
    let _e30: f32 = spot_dir_1.z;
    spot_dir_1.y = sqrt(max(0f, ((1f - (_e21 * _e23)) - (_e28 * _e30))));
    let _e37: u32 = (*light_4).flags;
    if ((_e37 & POINT_LIGHT_FLAGS_SPOT_LIGHT_Y_NEGATIVEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u) {
        let _e44: f32 = spot_dir_1.y;
        spot_dir_1.y = -(_e44);
    }
    let _e46: vec3<f32> = spot_dir_1;
    let fwd: vec3<f32> = -(_e46);
    let distance_to_light_6: f32 = dot(fwd, surface_to_light_1);
    let _e52: f32 = (*light_4).shadow_depth_bias;
    let _e58: f32 = (*light_4).shadow_normal_bias;
    let offset_position_2: vec3<f32> = ((-(surface_to_light_1) + (_e52 * normalize(surface_to_light_1))) + ((surface_normal_1.xyz * _e58) * distance_to_light_6));
    let _e62: mat3x3<f32> = orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(fwd);
    let projected_position: vec3<f32> = (offset_position_2 * _e62);
    let _e65: f32 = (*light_4).spot_light_tan_angle;
    let f_div_minus_z: f32 = (1f / (_e65 * -(projected_position.z)));
    let shadow_xy_ndc: vec2<f32> = (projected_position.xy * f_div_minus_z);
    let shadow_uv: vec2<f32> = ((shadow_xy_ndc * vec2<f32>(0.5f, -0.5f)) + vec2<f32>(0.5f, 0.5f));
    let depth_17: f32 = (near_z / -(projected_position.z));
    let _e88: i32 = lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.spot_light_shadowmap_offset;
    let array_index_7: i32 = (i32(light_id_13) + _e88);
    let _e91: f32 = (*light_4).soft_shadow_size;
    if (_e91 > 0f) {
        let _e95: f32 = (*light_4).soft_shadow_size;
        let _e98: f32 = sample_shadow_map_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(shadow_uv, depth_17, array_index_7, frag_coord_xy_7, SPOT_SHADOW_TEXEL_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX, _e95);
        return _e98;
    }
    let _e100: f32 = sample_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(shadow_uv, depth_17, array_index_7, frag_coord_xy_7, SPOT_SHADOW_TEXEL_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    return _e100;
}

fn get_cascade_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_14: u32, view_z_3: f32) -> u32 {
    var i: u32 = 0u;

    let light_5: ptr<uniform, DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.directional_lights[light_id_14]);
    loop {
        let _e6: u32 = i;
        let _e8: u32 = (*light_5).num_cascades;
        if (_e6 < _e8) {
        } else {
            break;
        }
        {
            let _e13: u32 = i;
            let _e16: f32 = (*light_5).cascades[_e13].far_bound;
            if (-(view_z_3) < _e16) {
                let _e18: u32 = i;
                return _e18;
            }
        }
        continuing {
            let _e19: u32 = i;
            i = (_e19 + 1u);
        }
    }
    let _e23: u32 = (*light_5).num_cascades;
    return _e23;
}

fn world_to_directional_light_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_15: u32, cascade_index: u32, offset_position: vec4<f32>) -> vec4<f32> {
    var local_1: bool;
    var local_2: bool;

    let light_6: ptr<uniform, DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.directional_lights[light_id_15]);
    let cascade: ptr<uniform, DirectionalCascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&(*light_6).cascades[cascade_index]);
    let _e9: mat4x4<f32> = (*cascade).clip_from_world;
    let offset_position_clip: vec4<f32> = (_e9 * offset_position);
    if (offset_position_clip.w <= 0f) {
        return vec4(0f);
    }
    let offset_position_ndc: vec3<f32> = (offset_position_clip.xyz / vec3(offset_position_clip.w));
    if !(any((offset_position_ndc.xy < vec2(-1f)))) {
        local_1 = (offset_position_ndc.z < 0f);
    } else {
        local_1 = true;
    }
    let _e32: bool = local_1;
    if !(_e32) {
        local_2 = any((offset_position_ndc > vec3(1f)));
    } else {
        local_2 = true;
    }
    let _e41: bool = local_2;
    if _e41 {
        return vec4(0f);
    }
    let flip_correction: vec2<f32> = vec2<f32>(0.5f, -0.5f);
    let light_local_16: vec2<f32> = ((offset_position_ndc.xy * flip_correction) + vec2<f32>(0.5f, 0.5f));
    let depth_18: f32 = offset_position_ndc.z;
    return vec4<f32>(light_local_16, depth_18, 1f);
}

fn sample_directional_cascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_16: u32, cascade_index_1: u32, frag_position_2: vec4<f32>, surface_normal_2: vec3<f32>, frag_coord_xy_8: vec2<f32>) -> f32 {
    let light_7: ptr<uniform, DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.directional_lights[light_id_16]);
    let cascade_1: ptr<uniform, DirectionalCascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&(*light_7).cascades[cascade_index_1]);
    let _e9: f32 = (*light_7).shadow_normal_bias;
    let _e11: f32 = (*cascade_1).texel_size;
    let normal_offset_1: vec3<f32> = ((_e9 * _e11) * surface_normal_2.xyz);
    let _e16: f32 = (*light_7).shadow_depth_bias;
    let _e18: vec3<f32> = (*light_7).direction_to_light;
    let depth_offset_1: vec3<f32> = (_e16 * _e18.xyz);
    let offset_position_3: vec4<f32> = vec4<f32>(((frag_position_2.xyz + normal_offset_1) + depth_offset_1), frag_position_2.w);
    let _e27: vec4<f32> = world_to_directional_light_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_16, cascade_index_1, offset_position_3);
    if (_e27.w == 0f) {
        return 1f;
    }
    let _e33: u32 = (*light_7).depth_texture_base_index;
    let array_index_8: i32 = i32((_e33 + cascade_index_1));
    let texel_size_5: f32 = (*cascade_1).texel_size;
    let _e39: f32 = (*light_7).soft_shadow_size;
    if (_e39 > 0f) {
        let _e45: f32 = (*light_7).soft_shadow_size;
        let _e47: f32 = sample_shadow_map_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(_e27.xy, _e27.z, array_index_8, frag_coord_xy_8, texel_size_5, _e45);
        return _e47;
    }
    let _e50: f32 = sample_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(_e27.xy, _e27.z, array_index_8, frag_coord_xy_8, texel_size_5);
    return _e50;
}

fn fetch_directional_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_17: u32, frag_position_3: vec4<f32>, surface_normal_3: vec3<f32>, view_z_4: f32, frag_coord_xy_9: vec2<f32>) -> f32 {
    var shadow: f32;

    let light_8: ptr<uniform, DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.directional_lights[light_id_17]);
    let _e5: u32 = get_cascade_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_17, view_z_4);
    let _e7: u32 = (*light_8).num_cascades;
    if (_e5 >= _e7) {
        return 1f;
    }
    let _e13: f32 = sample_directional_cascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_17, _e5, frag_position_3, surface_normal_3, frag_coord_xy_9);
    shadow = _e13;
    let next_cascade_index: u32 = (_e5 + 1u);
    let _e18: u32 = (*light_8).num_cascades;
    if (next_cascade_index < _e18) {
        let this_far_bound: f32 = (*light_8).cascades[_e5].far_bound;
        let _e25: f32 = (*light_8).cascades_overlap_proportion;
        let next_near_bound: f32 = ((1f - _e25) * this_far_bound);
        if (-(view_z_4) >= next_near_bound) {
            let _e31: f32 = sample_directional_cascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_17, next_cascade_index, frag_position_3, surface_normal_3, frag_coord_xy_9);
            let _e32: f32 = shadow;
            shadow = mix(_e32, _e31, ((-(view_z_4) - next_near_bound) / (this_far_bound - next_near_bound)));
        }
    }
    let _e38: f32 = shadow;
    return _e38;
}

fn EnvBRDFApproxX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(F0_1: vec3<f32>, F_ab_1: vec2<f32>) -> vec3<f32> {
    return ((F0_1 * F_ab_1.x) + vec3(F_ab_1.y));
}

fn ambient_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2MFWWE2LFNZ2AX(world_position: vec4<f32>, world_normal: vec3<f32>, V_3: vec3<f32>, NdotV_2: f32, diffuse_color: vec3<f32>, specular_color: vec3<f32>, perceptual_roughness_1: f32, occlusion: vec3<f32>) -> vec3<f32> {
    let _e2: vec2<f32> = F_ABX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(1f, NdotV_2);
    let _e4: vec3<f32> = EnvBRDFApproxX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(diffuse_color, _e2);
    let _e6: vec2<f32> = F_ABX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(perceptual_roughness_1, NdotV_2);
    let _e8: vec3<f32> = EnvBRDFApproxX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(specular_color, _e6);
    let specular_occlusion_1: f32 = saturate(dot(specular_color, vec3(16.5f)));
    let _e18: vec4<f32> = lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.ambient_color;
    return (((_e4 + (_e8 * specular_occlusion_1)) * _e18.xyz) * occlusion);
}

fn powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(color_1: vec3<f32>, power: f32) -> vec3<f32> {
    return (pow(abs(color_1), vec3(power)) * sign(color_1));
}

fn screen_space_ditherX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(frag_coord_1: vec2<f32>) -> vec3<f32> {
    var dither: vec3<f32>;

    dither = vec3(dot(vec2<f32>(171f, 231f), frag_coord_1)).xxx;
    let _e8: vec3<f32> = dither;
    dither = fract((_e8.xyz / vec3<f32>(103f, 71f, 97f)));
    let _e16: vec3<f32> = dither;
    return ((_e16 - vec3(0.5f)) / vec3(255f));
}

fn convertOpenDomainToNormalizedLog2_X_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(color_2: vec3<f32>, minimum_ev: f32, maximum_ev: f32) -> vec3<f32> {
    var normalized_color: vec3<f32>;

    normalized_color = max(vec3(0f), color_2);
    let _e5: vec3<f32> = normalized_color;
    let _e6: vec3<f32> = normalized_color;
    let _e10: vec3<f32> = normalized_color;
    normalized_color = select(_e5, (vec3(0.00001525878f) + _e6), (_e10 < vec3(0.00003051757f)));
    let _e18: vec3<f32> = normalized_color;
    normalized_color = clamp(log2((_e18 / vec3(0.18f))), vec3(minimum_ev), vec3(maximum_ev));
    let total_exposure: f32 = (maximum_ev - minimum_ev);
    let _e26: vec3<f32> = normalized_color;
    return ((_e26 - vec3(minimum_ev)) / vec3(total_exposure));
}

fn applyAgXLogX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(Image: vec3<f32>) -> vec3<f32> {
    var prepared_image: vec3<f32>;

    prepared_image = max(vec3(0f), Image);
    let _e5: vec3<f32> = prepared_image;
    let r_1: f32 = dot(_e5, vec3<f32>(0.84247905f, 0.0784336f, 0.07922375f));
    let _e11: vec3<f32> = prepared_image;
    let g: f32 = dot(_e11, vec3<f32>(0.04232824f, 0.87846863f, 0.07916613f));
    let _e17: vec3<f32> = prepared_image;
    let b_3: f32 = dot(_e17, vec3<f32>(0.04237565f, 0.0784336f, 0.879143f));
    prepared_image = vec3<f32>(r_1, g, b_3);
    let _e24: vec3<f32> = prepared_image;
    let _e27: vec3<f32> = convertOpenDomainToNormalizedLog2_X_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e24, -10f, 6.5f);
    prepared_image = _e27;
    let _e28: vec3<f32> = prepared_image;
    prepared_image = clamp(_e28, vec3(0f), vec3(1f));
    let _e34: vec3<f32> = prepared_image;
    return _e34;
}

fn sample_current_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(p_1: vec3<f32>) -> vec3<f32> {
    let _e4: vec4<f32> = textureSampleLevel(dt_lut_textureX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM5PWY5LUL5RGS3TENFXGO4YX, dt_lut_samplerX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM5PWY5LUL5RGS3TENFXGO4YX, p_1, 0f);
    return _e4.xyz;
}

fn applyLUT3DX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(Image_1: vec3<f32>, block_size: f32) -> vec3<f32> {
    let _e10: vec3<f32> = sample_current_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(((Image_1 * ((block_size - 1f) / block_size)) + vec3((0.5f / block_size))));
    return _e10.xyz;
}

fn tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(v: vec3<f32>) -> f32 {
    return dot(v, vec3<f32>(0.2126f, 0.7152f, 0.0722f));
}

fn saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(color_3: vec3<f32>, saturationAmount: f32) -> vec3<f32> {
    let _e1: f32 = tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(color_3);
    return mix(vec3(_e1), color_3, vec3(saturationAmount));
}

fn tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(in_1: vec4<f32>, in_color_grading: ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX) -> vec4<f32> {
    var color_4: vec3<f32>;
    var color_grading: ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX;

    color_4 = max(in_1.xyz, vec3(0f));
    color_grading = in_color_grading;
    let _e8: vec3<f32> = color_4;
    let _e12: f32 = color_grading.exposure;
    let _e13: vec3<f32> = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(vec3(2f), _e12);
    color_4 = (_e8 * _e13);
    let _e15: vec3<f32> = color_4;
    let _e16: vec3<f32> = applyAgXLogX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e15);
    color_4 = _e16;
    let _e17: vec3<f32> = color_4;
    let _e19: vec3<f32> = applyLUT3DX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e17, 32f);
    color_4 = _e19;
    let _e20: vec3<f32> = color_4;
    let _e22: f32 = color_grading.post_saturation;
    let _e23: vec3<f32> = saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e20, _e22);
    color_4 = _e23;
    let _e24: vec3<f32> = color_4;
    return vec4<f32>(_e24, in_1.w);
}

fn prepare_world_normalX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(world_normal_1: vec3<f32>, double_sided: bool, is_front_1: bool) -> vec3<f32> {
    var output: vec3<f32>;
    var local_3: bool;

    output = world_normal_1;
    if !(!(double_sided)) {
        local_3 = is_front_1;
    } else {
        local_3 = true;
    }
    let _e9: bool = local_3;
    let _e15: vec3<f32> = output;
    output = (((f32(_e9) * 2f) - 1f) * _e15);
    let _e17: vec3<f32> = output;
    return _e17;
}

fn calculate_viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(world_position_1: vec4<f32>, is_orthographic_3: bool) -> vec3<f32> {
    var V_4: vec3<f32>;

    if is_orthographic_3 {
        let _e5: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.clip_from_world[0][2];
        let _e10: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.clip_from_world[1][2];
        let _e15: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.clip_from_world[2][2];
        V_4 = normalize(vec3<f32>(_e5, _e10, _e15));
    } else {
        let _e22: vec3<f32> = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.world_position;
        V_4 = normalize((_e22.xyz - world_position_1.xyz));
    }
    let _e27: vec3<f32> = V_4;
    return _e27;
}

fn pbr_input_from_vertex_outputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOJQWO3LFNZ2AX(in_2: VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX, is_front_2: bool, double_sided_1: bool) -> PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX {
    var pbr_input_2: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX;

    let _e0: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = pbr_input_newX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX();
    pbr_input_2 = _e0;
    let _e8: u32 = meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX[in_2.instance_index].flags;
    pbr_input_2.flags = _e8;
    let _e14: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.clip_from_view[3][3];
    pbr_input_2.is_orthographic = (_e14 == 1f);
    let _e20: bool = pbr_input_2.is_orthographic;
    let _e21: vec3<f32> = calculate_viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(in_2.world_position, _e20);
    pbr_input_2.V = _e21;
    pbr_input_2.frag_coord = in_2.position;
    pbr_input_2.world_position = in_2.world_position;
    pbr_input_2.material.base_color = in_2.color;
    let _e33: vec3<f32> = prepare_world_normalX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(in_2.world_normal, double_sided_1, is_front_2);
    pbr_input_2.world_normal = _e33;
    let _e36: vec3<f32> = pbr_input_2.world_normal;
    pbr_input_2.N = normalize(_e36);
    let _e38: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = pbr_input_2;
    return _e38;
}

fn pbr_input_from_standard_materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOJQWO3LFNZ2AX(in_3: VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX, is_front_3: bool) -> PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX {
    var pbr_input_3: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX;
    var bias: SampleBiasX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX;
    var uv: vec2<f32>;
    var uv_b: vec2<f32>;
    var emissive: vec4<f32>;
    var metallic: f32;
    var perceptual_roughness_2: f32;
    var specular_transmission: f32;
    var thickness: f32;
    var diffuse_transmission: f32;
    var diffuse_occlusion: vec3<f32> = vec3(1f);
    var specular_occlusion: f32 = 1f;

    let _e7: u32 = meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX[in_3.instance_index].material_and_lightmap_bind_group_slot;
    let slot: u32 = (_e7 & 65535u);
    let flags: u32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.flags;
    let base_color_2: vec4<f32> = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.base_color;
    let deferred_lighting_pass_id: u32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.deferred_lighting_pass_id;
    let alpha_cutoff: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.alpha_cutoff;
    let double_sided_2: bool = ((flags & STANDARD_MATERIAL_FLAGS_DOUBLE_SIDED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u);
    let _e27: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = pbr_input_from_vertex_outputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOJQWO3LFNZ2AX(in_3, is_front_3, double_sided_2);
    pbr_input_3 = _e27;
    pbr_input_3.material.flags = flags;
    let _e33: vec4<f32> = pbr_input_3.material.base_color;
    pbr_input_3.material.base_color = (_e33 * base_color_2);
    pbr_input_3.material.deferred_lighting_pass_id = deferred_lighting_pass_id;
    let _e38: vec3<f32> = pbr_input_3.N;
    let _e40: vec3<f32> = pbr_input_3.V;
    let NdotV_6: f32 = max(dot(_e38, _e40), 0.0001f);
    let _e48: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.mip_bias;
    bias.mip_bias = _e48;
    let uv_transform: mat3x3<f32> = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.uv_transform;
    pbr_input_3.material.uv_transform = uv_transform;
    uv = (uv_transform * vec3<f32>(in_3.uv, 1f)).xy;
    let _e60: vec2<f32> = uv;
    uv_b = _e60;
    if ((flags & STANDARD_MATERIAL_FLAGS_BASE_COLOR_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u) {
        let _e68: vec4<f32> = pbr_input_3.material.base_color;
        let _e71: vec2<f32> = uv;
        let _e73: f32 = bias.mip_bias;
        let _e74: vec4<f32> = textureSampleBias(base_color_textureX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX, base_color_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX, _e71, _e73);
        pbr_input_3.material.base_color = (_e68 * _e74);
    }
    pbr_input_3.material.flags = flags;
    pbr_input_3.material.alpha_cutoff = alpha_cutoff;
    if ((flags & STANDARD_MATERIAL_FLAGS_UNLIT_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) == 0u) {
        let _e88: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.ior;
        pbr_input_3.material.ior = _e88;
        let _e93: vec4<f32> = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.attenuation_color;
        pbr_input_3.material.attenuation_color = _e93;
        let _e98: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.attenuation_distance;
        pbr_input_3.material.attenuation_distance = _e98;
        let _e103: vec3<f32> = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.reflectance;
        pbr_input_3.material.reflectance = _e103;
        let _e106: vec4<f32> = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.emissive;
        emissive = _e106;
        if ((flags & STANDARD_MATERIAL_FLAGS_EMISSIVE_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u) {
            let _e112: vec4<f32> = emissive;
            let _e116: vec2<f32> = uv;
            let _e118: f32 = bias.mip_bias;
            let _e119: vec4<f32> = textureSampleBias(emissive_textureX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX, emissive_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX, _e116, _e118);
            let _e123: f32 = emissive.w;
            emissive = vec4<f32>((_e112.xyz * _e119.xyz), _e123);
        }
        let _e127: vec4<f32> = emissive;
        pbr_input_3.material.emissive = _e127;
        let _e130: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.metallic;
        metallic = _e130;
        let _e134: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.perceptual_roughness;
        perceptual_roughness_2 = _e134;
        if ((flags & STANDARD_MATERIAL_FLAGS_METALLIC_ROUGHNESS_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u) {
            let _e142: vec2<f32> = uv;
            let _e144: f32 = bias.mip_bias;
            let metallic_roughness: vec4<f32> = textureSampleBias(metallic_roughness_textureX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX, metallic_roughness_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX, _e142, _e144);
            let _e146: f32 = metallic;
            metallic = (_e146 * metallic_roughness.z);
            let _e149: f32 = perceptual_roughness_2;
            perceptual_roughness_2 = (_e149 * metallic_roughness.y);
        }
        let _e154: f32 = metallic;
        pbr_input_3.material.metallic = _e154;
        let _e157: f32 = perceptual_roughness_2;
        pbr_input_3.material.perceptual_roughness = _e157;
        let _e162: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.clearcoat;
        pbr_input_3.material.clearcoat = _e162;
        let _e167: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.clearcoat_perceptual_roughness;
        pbr_input_3.material.clearcoat_perceptual_roughness = _e167;
        let _e170: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.specular_transmission;
        specular_transmission = _e170;
        let _e174: f32 = specular_transmission;
        pbr_input_3.material.specular_transmission = _e174;
        let _e177: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.thickness;
        thickness = _e177;
        let _e179: f32 = thickness;
        let _e184: mat3x4<f32> = meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX[in_3.instance_index].world_from_local;
        let _e187: vec3<f32> = pbr_input_3.N;
        thickness = (_e179 * length((transpose(_e184) * vec4<f32>(_e187, 0f)).xyz));
        let _e196: f32 = thickness;
        pbr_input_3.material.thickness = _e196;
        let _e199: f32 = materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX.diffuse_transmission;
        diffuse_transmission = _e199;
        let _e203: f32 = diffuse_transmission;
        pbr_input_3.material.diffuse_transmission = _e203;
        if ((flags & STANDARD_MATERIAL_FLAGS_OCCLUSION_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u) {
            let _e209: vec3<f32> = diffuse_occlusion;
            let _e212: vec2<f32> = uv;
            let _e214: f32 = bias.mip_bias;
            let _e215: vec4<f32> = textureSampleBias(occlusion_textureX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX, occlusion_samplerX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3CNFXGI2LOM5ZQX, _e212, _e214);
            diffuse_occlusion = (_e209 * _e215.x);
        }
        let _e219: vec3<f32> = diffuse_occlusion;
        pbr_input_3.diffuse_occlusion = _e219;
        let _e222: f32 = specular_occlusion;
        pbr_input_3.specular_occlusion = _e222;
        let _e225: vec3<f32> = pbr_input_3.world_normal;
        pbr_input_3.N = normalize(_e225);
        let _e229: vec3<f32> = pbr_input_3.N;
        pbr_input_3.clearcoat_N = _e229;
    }
    let _e230: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = pbr_input_3;
    return _e230;
}

fn affine3_to_squareX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(affine: mat3x4<f32>) -> mat4x4<f32> {
    return transpose(mat4x4<f32>(affine[0], affine[1], affine[2], vec4<f32>(0f, 0f, 0f, 1f)));
}

fn mat2x4_f32_to_mat3x3_unpackX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(a_2: mat2x4<f32>, b_1: f32) -> mat3x3<f32> {
    return mat3x3<f32>(a_2[0].xyz, vec3<f32>(a_2[0].w, a_2[1].xy), vec3<f32>(a_2[1].zw, b_1));
}

fn position_world_to_clipX_naga_oil_mod_XMJSXM6K7OBRHEOR2OZUWK527ORZGC3TTMZXXE3LBORUW63TTX(world_pos: vec3<f32>) -> vec4<f32> {
    let _e2: mat4x4<f32> = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.clip_from_world;
    let clip_pos: vec4<f32> = (_e2 * vec4<f32>(world_pos, 1f));
    return clip_pos;
}

fn get_world_from_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(instance_index: u32) -> mat4x4<f32> {
    let _e4: mat3x4<f32> = meshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MJUW4ZDJNZTXGX[instance_index].world_from_local;
    let _e5: mat4x4<f32> = affine3_to_squareX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e4);
    return _e5;
}

fn calculate_diffuse_colorX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(base_color: vec3<f32>, metallic_1: f32, specular_transmission_1: f32, diffuse_transmission_1: f32) -> vec3<f32> {
    return (((base_color * (1f - metallic_1)) * (1f - specular_transmission_1)) * (1f - diffuse_transmission_1));
}

fn calculate_F0_dielectricX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(reflectance: vec3<f32>) -> vec3<f32> {
    return ((0.16f * reflectance) * reflectance);
}

fn calculate_F0X_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(base_color_1: vec3<f32>, metallic_2: f32, reflectance_1: vec3<f32>) -> vec3<f32> {
    let _e1: vec3<f32> = calculate_F0_dielectricX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(reflectance_1);
    return mix(_e1, base_color_1, metallic_2);
}

fn apply_pbr_lightingX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(in_4: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) -> vec4<f32> {
    var output_color_1: vec4<f32>;
    var direct_light: vec3<f32> = vec3(0f);
    var transmitted_light: vec3<f32> = vec3(0f);
    var lighting_input: LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX;
    var clusterable_object_index_ranges_1: ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX;
    var i_1: u32;
    var shadow_1: f32;
    var local_4: bool;
    var i_2: u32;
    var shadow_2: f32;
    var local_5: bool;
    var i_3: u32 = 0u;
    var shadow_3: f32;
    var local_6: bool;
    var light_contrib: vec3<f32>;
    var indirect_light: vec3<f32> = vec3(0f);
    var found_diffuse_indirect: bool = false;
    var specular_transmitted_environment_light: vec3<f32> = vec3(0f);
    var emissive_light: vec3<f32>;

    output_color_1 = in_4.material.base_color;
    let emissive_1: vec4<f32> = in_4.material.emissive;
    let metallic_3: f32 = in_4.material.metallic;
    let perceptual_roughness_3: f32 = in_4.material.perceptual_roughness;
    let _e14: f32 = perceptualRoughnessToRoughnessX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(perceptual_roughness_3);
    let ior: f32 = in_4.material.ior;
    let thickness_1: f32 = in_4.material.thickness;
    let reflectance_2: vec3<f32> = in_4.material.reflectance;
    let diffuse_transmission_2: f32 = in_4.material.diffuse_transmission;
    let specular_transmission_2: f32 = in_4.material.specular_transmission;
    let specular_transmissive_color: vec3<f32> = (specular_transmission_2 * in_4.material.base_color.xyz);
    let diffuse_occlusion_1: vec3<f32> = in_4.diffuse_occlusion;
    let specular_occlusion_2: f32 = in_4.specular_occlusion;
    let NdotV_7: f32 = max(dot(in_4.N, in_4.V), 0.0001f);
    let R_1: vec3<f32> = reflect(-(in_4.V), in_4.N);
    let _e40: vec4<f32> = output_color_1;
    let _e42: vec3<f32> = calculate_diffuse_colorX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(_e40.xyz, metallic_3, specular_transmission_2, diffuse_transmission_2);
    let _e43: vec4<f32> = output_color_1;
    let diffuse_transmissive_color: vec3<f32> = (((_e43.xyz * (1f - metallic_3)) * (1f - specular_transmission_2)) * diffuse_transmission_2);
    let diffuse_transmissive_lobe_world_position: vec4<f32> = (in_4.world_position - (vec4<f32>(in_4.world_normal, 0f) * thickness_1));
    let _e58: vec4<f32> = output_color_1;
    let _e60: vec3<f32> = calculate_F0X_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(_e58.xyz, metallic_3, reflectance_2);
    let _e61: vec2<f32> = F_ABX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(perceptual_roughness_3, NdotV_7);
    lighting_input.layers[0].NdotV = NdotV_7;
    lighting_input.layers[0].N = in_4.N;
    lighting_input.layers[0].R = R_1;
    lighting_input.layers[0].perceptual_roughness = perceptual_roughness_3;
    lighting_input.layers[0].roughness = _e14;
    lighting_input.P = in_4.world_position.xyz;
    lighting_input.V = in_4.V;
    lighting_input.diffuse_color = _e42;
    lighting_input.metallic = metallic_3;
    let _e87: vec3<f32> = calculate_F0_dielectricX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(reflectance_2);
    lighting_input.F0_dielectric = _e87;
    let _e89: vec4<f32> = output_color_1;
    lighting_input.F0_metallic = _e89.xyz;
    lighting_input.F_ab = _e61;
    let _e96: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.view_from_world[0][2];
    let _e101: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.view_from_world[1][2];
    let _e106: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.view_from_world[2][2];
    let _e111: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.view_from_world[3][2];
    let view_z_5: f32 = dot(vec4<f32>(_e96, _e101, _e106, _e111), in_4.world_position);
    let _e118: u32 = view_fragment_cluster_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(in_4.frag_coord.xy, view_z_5, in_4.is_orthographic);
    let _e119: ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX = unpack_clusterable_object_index_rangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e118);
    clusterable_object_index_ranges_1 = _e119;
    let _e122: u32 = clusterable_object_index_ranges_1.first_point_light_index_offset;
    i_1 = _e122;
    loop {
        let _e124: u32 = i_1;
        let _e126: u32 = clusterable_object_index_ranges_1.first_spot_light_index_offset;
        if (_e124 < _e126) {
        } else {
            break;
        }
        {
            let _e128: u32 = i_1;
            let _e129: u32 = get_clusterable_object_idX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e128);
            shadow_1 = 1f;
            if ((in_4.flags & MESH_FLAGS_SHADOW_RECEIVER_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX) != 0u) {
                let _e141: u32 = clustered_lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[_e129].flags;
                local_4 = ((_e141 & POINT_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u);
            } else {
                local_4 = false;
            }
            let _e149: bool = local_4;
            if _e149 {
                let _e154: f32 = fetch_point_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(_e129, in_4.world_position, in_4.world_normal, in_4.frag_coord.xy);
                shadow_1 = _e154;
            }
            let _e157: vec3<f32> = point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(_e129, (&lighting_input), true, true);
            let _e159: vec3<f32> = direct_light;
            let _e160: f32 = shadow_1;
            direct_light = (_e159 + (_e157 * _e160));
        }
        continuing {
            let _e163: u32 = i_1;
            i_1 = (_e163 + 1u);
        }
    }
    let _e167: u32 = clusterable_object_index_ranges_1.first_spot_light_index_offset;
    i_2 = _e167;
    loop {
        let _e169: u32 = i_2;
        let _e171: u32 = clusterable_object_index_ranges_1.first_reflection_probe_index_offset;
        if (_e169 < _e171) {
        } else {
            break;
        }
        {
            let _e173: u32 = i_2;
            let _e174: u32 = get_clusterable_object_idX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e173);
            shadow_2 = 1f;
            if ((in_4.flags & MESH_FLAGS_SHADOW_RECEIVER_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX) != 0u) {
                let _e186: u32 = clustered_lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[_e174].flags;
                local_5 = ((_e186 & POINT_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u);
            } else {
                local_5 = false;
            }
            let _e194: bool = local_5;
            if _e194 {
                let _e201: f32 = clustered_lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.data[_e174].shadow_map_near_z;
                let _e204: f32 = fetch_spot_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(_e174, in_4.world_position, in_4.world_normal, _e201, in_4.frag_coord.xy);
                shadow_2 = _e204;
            }
            let _e206: vec3<f32> = spot_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(_e174, (&lighting_input), true);
            let _e207: vec3<f32> = direct_light;
            let _e208: f32 = shadow_2;
            direct_light = (_e207 + (_e206 * _e208));
        }
        continuing {
            let _e211: u32 = i_2;
            i_2 = (_e211 + 1u);
        }
    }
    let n_directional_lights: u32 = lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.n_directional_lights;
    loop {
        let _e218: u32 = i_3;
        if (_e218 < n_directional_lights) {
        } else {
            break;
        }
        {
            let _e222: u32 = i_3;
            let light_9: ptr<uniform, DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX> = (&lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.directional_lights[_e222]);
            shadow_3 = 1f;
            if ((in_4.flags & MESH_FLAGS_SHADOW_RECEIVER_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX) != 0u) {
                let _e233: u32 = i_3;
                let _e236: u32 = lightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.directional_lights[_e233].flags;
                local_6 = ((_e236 & DIRECTIONAL_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u);
            } else {
                local_6 = false;
            }
            let _e244: bool = local_6;
            if _e244 {
                let _e245: u32 = i_3;
                let _e250: f32 = fetch_directional_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(_e245, in_4.world_position, in_4.world_normal, view_z_5, in_4.frag_coord.xy);
                shadow_3 = _e250;
            }
            let _e251: u32 = i_3;
            let _e253: vec3<f32> = directional_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(_e251, (&lighting_input), true);
            light_contrib = _e253;
            let _e255: vec3<f32> = direct_light;
            let _e256: vec3<f32> = light_contrib;
            let _e257: f32 = shadow_3;
            direct_light = (_e255 + (_e256 * _e257));
        }
        continuing {
            let _e260: u32 = i_3;
            i_3 = (_e260 + 1u);
        }
    }
    if true {
        let _e265: vec3<f32> = indirect_light;
        let _e269: vec3<f32> = ambient_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2MFWWE2LFNZ2AX(in_4.world_position, in_4.N, in_4.V, NdotV_7, _e42, _e60, perceptual_roughness_3, diffuse_occlusion_1);
        indirect_light = (_e265 + _e269);
    }
    let _e273: f32 = output_color_1.w;
    emissive_light = (emissive_1.xyz * _e273);
    let _e276: vec3<f32> = emissive_light;
    let _e279: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.exposure;
    emissive_light = (_e276 * mix(1f, _e279, emissive_1.w));
    let _e287: f32 = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.exposure;
    let _e288: vec3<f32> = transmitted_light;
    let _e289: vec3<f32> = direct_light;
    let _e291: vec3<f32> = indirect_light;
    let _e294: vec3<f32> = emissive_light;
    let _e297: f32 = output_color_1.w;
    output_color_1 = vec4<f32>(((_e287 * ((_e288 + _e289) + _e291)) + _e294), _e297);
    let _e299: vec4<f32> = output_color_1;
    let _e301: ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX = clusterable_object_index_ranges_1;
    let _e302: vec4<f32> = cluster_debug_visualizationX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e299, view_z_5, in_4.is_orthographic, _e301, _e118);
    output_color_1 = _e302;
    let _e303: vec4<f32> = output_color_1;
    return _e303;
}

fn main_pass_post_lighting_processingX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(pbr_input_4: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX, input_color_1: vec4<f32>) -> vec4<f32> {
    var output_color_2: vec4<f32>;
    var output_rgb: vec3<f32>;

    output_color_2 = input_color_1;
    let _e2: vec4<f32> = output_color_2;
    let _e5: ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX = viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527MJUW4ZDJNZTXGX.color_grading;
    let _e6: vec4<f32> = tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e2, _e5);
    output_color_2 = _e6;
    let _e7: vec4<f32> = output_color_2;
    output_rgb = _e7.xyz;
    let _e10: vec3<f32> = output_rgb;
    let _e12: vec3<f32> = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e10, 0.45454547f);
    output_rgb = _e12;
    let _e14: vec3<f32> = output_rgb;
    let _e17: vec3<f32> = screen_space_ditherX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(pbr_input_4.frag_coord.xy);
    output_rgb = (_e14 + _e17);
    let _e19: vec3<f32> = output_rgb;
    let _e21: vec3<f32> = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e19, 2.2f);
    output_rgb = _e21;
    let _e22: vec3<f32> = output_rgb;
    let _e24: f32 = output_color_2.w;
    output_color_2 = vec4<f32>(_e22, _e24);
    let _e26: vec4<f32> = output_color_2;
    return _e26;
}

fn hash3_(p_2: vec3<f32>) -> f32 {
    let q: vec3<f32> = fract(((p_2 * 0.3183099f) + vec3<f32>(0.1f, 0.2f, 0.3f)));
    let r_2: vec3<f32> = (q + vec3(dot(q, (q.yzx + vec3(19.19f)))));
    return fract(((r_2.x + r_2.y) * r_2.z));
}

fn vnoise(p_3: vec3<f32>) -> f32 {
    let i_4: vec3<f32> = floor(p_3);
    let f: vec3<f32> = fract(p_3);
    let u: vec3<f32> = ((f * f) * (vec3(3f) - (2f * f)));
    let _e15: f32 = hash3_((i_4 + vec3<f32>(0f, 0f, 0f)));
    let _e21: f32 = hash3_((i_4 + vec3<f32>(1f, 0f, 0f)));
    let _e27: f32 = hash3_((i_4 + vec3<f32>(0f, 1f, 0f)));
    let _e33: f32 = hash3_((i_4 + vec3<f32>(1f, 1f, 0f)));
    let _e39: f32 = hash3_((i_4 + vec3<f32>(0f, 0f, 1f)));
    let _e45: f32 = hash3_((i_4 + vec3<f32>(1f, 0f, 1f)));
    let _e51: f32 = hash3_((i_4 + vec3<f32>(0f, 1f, 1f)));
    let _e57: f32 = hash3_((i_4 + vec3<f32>(1f, 1f, 1f)));
    let x00_: f32 = mix(_e15, _e21, u.x);
    let x10_: f32 = mix(_e27, _e33, u.x);
    let x01_: f32 = mix(_e39, _e45, u.x);
    let x11_: f32 = mix(_e51, _e57, u.x);
    return mix(mix(x00_, x10_, u.y), mix(x01_, x11_, u.y), u.z);
}

@fragment 
fn fragment(in: VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX, @builtin(front_facing) is_front: bool) -> FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    var pbr_input: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX;
    var lum: f32 = 1f;
    var rough_adj: f32 = 0f;
    var rgb: vec3<f32>;
    var local: bool;
    var out: FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX;

    let _e4: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = pbr_input_from_standard_materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOJQWO3LFNZ2AX(in, is_front);
    pbr_input = _e4;
    let _e7: mat4x4<f32> = get_world_from_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(in.instance_index);
    let m_1: mat3x3<f32> = mat3x3<f32>(_e7[0].xyz, _e7[1].xyz, _e7[2].xyz);
    let origin: vec3<f32> = _e7[3].xyz;
    let lp: vec3<f32> = (transpose(m_1) * (in.world_position.xyz - origin));
    let obj: vec3<f32> = vec3<f32>((lp.x / max(dot(m_1[0], m_1[0]), 0.00001f)), (lp.y / max(dot(m_1[1], m_1[1]), 0.00001f)), (lp.z / max(dot(m_1[2], m_1[2]), 0.00001f)));
    let surf: f32 = in.color.w;
    let strength: f32 = creature.params.x;
    let relief: f32 = creature.params.y;
    let spec_lift: f32 = creature.params.z;
    let _e60: vec4<f32> = pbr_input.material.base_color;
    rgb = _e60.xyz;
    if !((surf < 0.14f)) {
        local = (surf > 0.965f);
    } else {
        local = true;
    }
    let _e71: bool = local;
    if _e71 {
        let _e74: f32 = vnoise((obj * 9f));
        let n_1: f32 = (_e74 - 0.5f);
        let _e79: f32 = vnoise((obj * 38f));
        let pore: f32 = ((_e79 - 0.5f) * 0.4f);
        lum = (1f + ((n_1 + pore) * strength));
        rough_adj = 0.05f;
    } else {
        if (surf < 0.28f) {
            let p_4: vec3<f32> = (obj * vec3<f32>(26f, 7f, 26f));
            let _e98: f32 = vnoise(p_4);
            let _e103: f32 = vnoise((p_4 * 2.3f));
            let f_1: f32 = ((_e98 - 0.5f) + ((_e103 - 0.5f) * 0.5f));
            lum = (1f + ((f_1 * strength) * 1.4f));
            rough_adj = 0.12f;
        } else {
            if (surf < 0.43f) {
                let cell: vec3<f32> = floor((obj * 16f));
                let _e120: f32 = hash3_(cell);
                let edge: f32 = (fract((obj.x * 16f)) * fract((obj.y * 16f)));
                lum = ((1f + (((_e120 - 0.5f) * strength) * 1.2f)) - ((1f - smoothstep(0.05f, 0.2f, edge)) * strength));
                rough_adj = -0.05f;
            } else {
                if (surf < 0.57f) {
                    let _e149: f32 = vnoise((obj * 8f));
                    let _e154: f32 = vnoise((obj * 22f));
                    let n_2: f32 = ((_e149 - 0.5f) + ((_e154 - 0.5f) * 0.5f));
                    let _e162: f32 = vnoise((obj * 40f));
                    let spk: f32 = step(0.92f, _e162);
                    lum = ((1f + ((n_2 * strength) * 1.3f)) + ((spk * strength) * 2f));
                    rough_adj = 0.18f;
                } else {
                    if (surf < 0.71f) {
                        let _e179: f32 = vnoise((obj * 30f));
                        let n_3: f32 = (_e179 - 0.5f);
                        lum = (1f + ((n_3 * strength) * 0.55f));
                        rough_adj = -0.18f;
                        pbr_input.material.metallic = clamp(spec_lift, 0f, 1f);
                    } else {
                        if (surf < 0.86f) {
                            let weave: f32 = ((sin((obj.x * 120f)) * sin((obj.y * 120f))) * 0.5f);
                            lum = (1f + ((weave * strength) * 0.6f));
                            rough_adj = 0.1f;
                        } else {
                            let _e214: f32 = vnoise((obj * 24f));
                            let n_4: f32 = (_e214 - 0.5f);
                            lum = (1f + ((n_4 * strength) * 0.7f));
                            rough_adj = -0.05f;
                        }
                    }
                }
            }
        }
    }
    let _e223: vec3<f32> = rgb;
    let _e224: f32 = lum;
    rgb = (_e223 * _e224);
    let _e228: vec3<f32> = rgb;
    pbr_input.material.base_color = vec4<f32>(max(_e228, vec3(0f)), 1f);
    let _e238: f32 = pbr_input.material.perceptual_roughness;
    let _e239: f32 = rough_adj;
    pbr_input.material.perceptual_roughness = clamp((_e238 + _e239), 0.05f, 1f);
    if (relief > 0f) {
        let _e253: f32 = vnoise(((obj * 18f) + vec3<f32>(0.02f, 0f, 0f)));
        let _e260: f32 = vnoise(((obj * 18f) - vec3<f32>(0.02f, 0f, 0f)));
        let dx: f32 = (_e253 - _e260);
        let _e268: f32 = vnoise(((obj * 18f) + vec3<f32>(0f, 0f, 0.02f)));
        let _e275: f32 = vnoise(((obj * 18f) - vec3<f32>(0f, 0f, 0.02f)));
        let dz: f32 = (_e268 - _e275);
        let _e279: vec3<f32> = pbr_input.N;
        pbr_input.N = normalize((_e279 + (((m_1 * vec3<f32>(dx, 0f, dz)) * relief) * 0.5f)));
    }
    let _e290: u32 = pbr_input.material.flags;
    if ((_e290 & STANDARD_MATERIAL_FLAGS_UNLIT_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) == 0u) {
        let _e297: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = pbr_input;
        let _e298: vec4<f32> = apply_pbr_lightingX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(_e297);
        out.color = _e298;
    } else {
        let _e302: vec4<f32> = pbr_input.material.base_color;
        out.color = _e302;
    }
    let _e304: PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = pbr_input;
    let _e306: vec4<f32> = out.color;
    let _e307: vec4<f32> = main_pass_post_lighting_processingX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(_e304, _e306);
    out.color = _e307;
    let _e308: FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX = out;
    return _e308;
}
