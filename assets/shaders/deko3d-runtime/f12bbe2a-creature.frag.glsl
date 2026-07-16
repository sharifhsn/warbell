#version 460 core
struct VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    vec4 position;
    vec4 world_position;
    vec3 world_normal;
    vec2 uv;
    vec4 color;
    uint instance_index;
};
struct FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    vec4 color;
};
struct StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX {
    vec4 base_color;
    vec4 emissive;
    vec4 attenuation_color;
    mat3x3 uv_transform;
    vec3 reflectance;
    float perceptual_roughness;
    float metallic;
    float diffuse_transmission;
    float specular_transmission;
    float thickness;
    float ior;
    float attenuation_distance;
    float clearcoat;
    float clearcoat_perceptual_roughness;
    float anisotropy_strength;
    vec2 anisotropy_rotation;
    uint flags;
    float alpha_cutoff;
    float parallax_depth_scale;
    float max_parallax_layer_count;
    float lightmap_exposure;
    uint max_relief_mapping_search_steps;
    uint deferred_lighting_pass_id;
};
struct PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX {
    StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX material;
    vec3 diffuse_occlusion;
    float specular_occlusion;
    vec4 frag_coord;
    vec4 world_position;
    vec3 world_normal;
    vec3 N;
    vec3 V;
    vec3 lightmap_light;
    vec3 clearcoat_N;
    float anisotropy_strength;
    vec3 anisotropy_T;
    vec3 anisotropy_B;
    bool is_orthographic;
    uint flags;
};
struct MeshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX {
    mat3x4 world_from_local;
    mat3x4 previous_world_from_local;
    mat2x4 local_from_world_transpose_a;
    float local_from_world_transpose_b;
    uint flags;
    uvec2 lightmap_uv_rect;
    uint first_vertex_index;
    uint current_skin_index;
    uint material_and_lightmap_bind_group_slot;
    uint tag;
    uint morph_descriptor_index;
};
struct ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX {
    mat3x3 balance;
    vec3 saturation;
    vec3 contrast;
    vec3 gamma;
    vec3 gain;
    vec3 lift;
    vec2 midtone_range;
    float exposure;
    float hue;
    float post_saturation;
};
struct ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX {
    mat4x4 clip_from_world;
    mat4x4 unjittered_clip_from_world;
    mat4x4 world_from_clip;
    mat4x4 world_from_view;
    mat4x4 view_from_world;
    mat4x4 clip_from_view;
    mat4x4 view_from_clip;
    vec3 world_position;
    float exposure;
    vec4 viewport;
    vec4 main_pass_viewport;
    vec4 frustum[6];
    vec3 lod_view_world_position;
    ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX color_grading;
    float mip_bias;
    uint frame_count;
};
struct DirectionalCascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    mat4x4 clip_from_world;
    float texel_size;
    float far_bound;
};
struct DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    DirectionalCascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX cascades[4];
    vec4 color;
    vec3 direction_to_light;
    uint flags;
    float soft_shadow_size;
    float shadow_depth_bias;
    float shadow_normal_bias;
    uint num_cascades;
    float cascades_overlap_proportion;
    uint depth_texture_base_index;
    uint decal_index;
    float sun_disk_angular_size;
    float sun_disk_intensity;
};
struct RectLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    vec4 color;
    vec3 position;
    float width;
    vec3 right;
    float height;
    vec3 up;
    float range;
};
struct LightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    DirectionalLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX directional_lights[10];
    vec4 ambient_color;
    uvec4 cluster_dimensions;
    vec4 cluster_factors;
    uint n_directional_lights;
    int spot_light_shadowmap_offset;
    uint ambient_light_affects_lightmapped_meshes;
    uint n_rect_lights;
    RectLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX rect_lights[8];
};
struct ClusteredLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    vec4 light_custom_data;
    vec4 color_inverse_square_range;
    vec4 position_radius;
    uint flags;
    float shadow_depth_bias;
    float shadow_normal_bias;
    float spot_light_tan_angle;
    float soft_shadow_size;
    float shadow_map_near_z;
    uint decal_index;
    float range;
};
struct ClusteredLightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    ClusteredLightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX data[204];
};
struct ClusterableObjectIndexListsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    uvec4 data[1024];
};
struct ClusterOffsetsAndCountsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    uvec4 data[1024];
};
struct LightProbeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    mat3x4 light_from_world_transposed;
    vec3 falloff;
    float bounding_sphere_radius;
    vec3 parallax_correction_bounds;
    float intensity;
    vec3 world_position;
    int cubemap_index;
    uint flags;
};
struct LightProbesX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX {
    LightProbeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX reflection_probes[8];
    LightProbeX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX irradiance_volumes[8];
    int reflection_probe_count;
    int irradiance_volume_count;
    int view_cubemap_index;
    uint smallest_specular_mip_level_for_view;
    vec4 view_rotation;
    float intensity_for_view;
    uint view_environment_map_affects_lightmapped_mesh_diffuse;
};
struct GlobalsX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUZ3MN5RGC3DTX {
    float time;
    float delta_time;
    uint frame_count;
};
struct LayerLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX {
    vec3 N;
    vec3 R;
    float NdotV;
    float perceptual_roughness;
    float roughness;
};
struct LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX {
    LayerLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX layers[1];
    vec3 P;
    vec3 V;
    vec3 diffuse_color;
    float metallic;
    vec3 F0_dielectric;
    vec3 F0_metallic;
    vec2 F_ab;
};
struct DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX {
    vec3 H;
    float NdotL;
    float NdotH;
    float LdotH;
};
struct ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX {
    uint first_point_light_index_offset;
    uint first_spot_light_index_offset;
    uint first_reflection_probe_index_offset;
    uint first_irradiance_volume_index_offset;
    uint first_decal_offset;
    uint last_clusterable_object_index_offset;
};
struct SampleBiasX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX {
    float mip_bias;
};
struct PreviousViewUniformsX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV6YTJNZSGS3THOMX {
    mat4x4 view_from_world;
    mat4x4 clip_from_world;
    mat4x4 clip_from_view;
    mat4x4 world_from_clip;
    mat4x4 view_from_clip;
};
struct CreatureParams {
    vec4 params;
};
const uint STANDARD_MATERIAL_FLAGS_BASE_COLOR_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 1u;
const uint STANDARD_MATERIAL_FLAGS_EMISSIVE_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 2u;
const uint STANDARD_MATERIAL_FLAGS_METALLIC_ROUGHNESS_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 4u;
const uint STANDARD_MATERIAL_FLAGS_OCCLUSION_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 8u;
const uint STANDARD_MATERIAL_FLAGS_DOUBLE_SIDED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 16u;
const uint STANDARD_MATERIAL_FLAGS_UNLIT_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 32u;
const uint STANDARD_MATERIAL_FLAGS_ALPHA_MODE_OPAQUEX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 0u;
const uint STANDARD_MATERIAL_FLAGS_TWO_COMPONENT_NORMAL_MAPX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 64u;
const uint STANDARD_MATERIAL_FLAGS_FLIP_NORMAL_MAP_YX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 128u;
const uint STANDARD_MATERIAL_FLAGS_ALPHA_MODE_RESERVED_BITSX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX = 3758096384u;
const float PIX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX = 3.1415927;
const uint POINT_LIGHT_FLAGS_SPOT_LIGHT_Y_NEGATIVEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX = 2u;
const uint LAYER_BASEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX = 0u;
const uint CLUSTER_COUNT_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX = 9u;
const uint MESH_FLAGS_SHADOW_RECEIVER_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX = 536870912u;
const uint POINT_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX = 1u;
const uint DIRECTIONAL_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX = 1u;
const float PI_2X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX = 6.2831855;
const vec2 SPIRAL_OFFSET_0_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX = vec2(-0.7071, 0.7071);
const vec2 SPIRAL_OFFSET_1_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX = vec2(-0.0, -0.875);
const vec2 SPIRAL_OFFSET_2_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX = vec2(0.5303, 0.5303);
const vec2 SPIRAL_OFFSET_3_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX = vec2(-0.625, -0.0);
const vec2 SPIRAL_OFFSET_4_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX = vec2(0.3536, -0.3536);
const vec2 SPIRAL_OFFSET_5_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX = vec2(-0.0, 0.375);
const vec2 SPIRAL_OFFSET_6_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX = vec2(-0.1768, -0.1768);
const vec2 SPIRAL_OFFSET_7_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX = vec2(0.125, -0.0);
const float SPOT_SHADOW_TEXEL_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX = 0.013427734;
const float POINT_SHADOW_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX = 0.003;
const float POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX = 0.5;
const float FRAC_PI_3X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX = 1.0471976;
const vec3 flip_zX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX = vec3(1.0, 1.0, -1.0);
const uint MESH_FLAGS_SIGN_DETERMINANT_MODEL_3X3_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX = 2147483648u;

layout(std140, binding = 6) uniform type_21_block_0Fragment { MeshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX _group_2_binding_0_fs[93]; };

layout(std140, binding = 0) uniform ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX_block_1Fragment { ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _group_0_binding_0_fs; };

layout(std140, binding = 1) uniform LightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX_block_2Fragment { LightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX _group_0_binding_1_fs; };

layout(std140, binding = 2) uniform ClusteredLightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX_block_3Fragment { ClusteredLightsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX _group_0_binding_8_fs; };

layout(std140, binding = 3) uniform ClusterableObjectIndexListsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX_block_4Fragment { ClusterableObjectIndexListsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX _group_0_binding_9_fs; };

layout(std140, binding = 4) uniform ClusterOffsetsAndCountsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX_block_5Fragment { ClusterOffsetsAndCountsX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX _group_0_binding_10_fs; };

layout(binding = 0) uniform samplerCubeArrayShadow _group_0_binding_2_fs;

layout(binding = 1) uniform sampler2DArrayShadow _group_0_binding_5_fs;

layout(std140, binding = 5) uniform GlobalsX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUZ3MN5RGC3DTX_block_6Fragment { GlobalsX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUZ3MN5RGC3DTX _group_0_binding_11_fs; };

layout(binding = 2) uniform sampler3D _group_0_binding_18_fs;

layout(std140, binding = 7) uniform StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX_block_7Fragment { StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _group_3_binding_0_fs; };

layout(binding = 3) uniform sampler2D _group_3_binding_1_fs;

layout(binding = 4) uniform sampler2D _group_3_binding_3_fs;

layout(binding = 5) uniform sampler2D _group_3_binding_5_fs;

layout(binding = 6) uniform sampler2D _group_3_binding_7_fs;

layout(std140, binding = 8) uniform CreatureParams_block_8Fragment { CreatureParams _group_3_binding_100_fs; };

layout(location = 0) smooth in vec4 _vs2fs_location0;
layout(location = 1) smooth in vec3 _vs2fs_location1;
layout(location = 2) smooth in vec2 _vs2fs_location2;
layout(location = 5) smooth in vec4 _vs2fs_location5;
layout(location = 6) flat in uint _vs2fs_location6;
layout(location = 0) out vec4 _fs2p_location0;

StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX standard_material_newX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX() {
    StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX material = StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(vec4(0.0), vec4(0.0), vec4(0.0), mat3x3(0.0), vec3(0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vec2(0.0), 0u, 0.0, 0.0, 0.0, 0.0, 0u, 0u);
    material.base_color = vec4(1.0, 1.0, 1.0, 1.0);
    material.emissive = vec4(0.0, 0.0, 0.0, 1.0);
    material.perceptual_roughness = 0.5;
    material.metallic = 0.0;
    material.reflectance = vec3(0.5);
    material.diffuse_transmission = 0.0;
    material.specular_transmission = 0.0;
    material.thickness = 0.0;
    material.ior = 1.5;
    material.attenuation_distance = 1.0;
    material.attenuation_color = vec4(1.0, 1.0, 1.0, 1.0);
    material.clearcoat = 0.0;
    material.clearcoat_perceptual_roughness = 0.0;
    material.flags = STANDARD_MATERIAL_FLAGS_ALPHA_MODE_OPAQUEX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX;
    material.alpha_cutoff = 0.5;
    material.parallax_depth_scale = 0.1;
    material.max_parallax_layer_count = 16.0;
    material.max_relief_mapping_search_steps = 5u;
    material.deferred_lighting_pass_id = 1u;
    material.uv_transform = mat3x3(vec3(1.0, 0.0, 0.0), vec3(0.0, 1.0, 0.0), vec3(0.0, 0.0, 1.0));
    StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e66_ = material;
    return _e66_;
}

PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX pbr_input_newX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX() {
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX pbr_input_1_ = PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(vec4(0.0), vec4(0.0), vec4(0.0), mat3x3(0.0), vec3(0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vec2(0.0), 0u, 0.0, 0.0, 0.0, 0.0, 0u, 0u), vec3(0.0), 0.0, vec4(0.0), vec4(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), 0.0, vec3(0.0), vec3(0.0), false, 0u);
    StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e1 = standard_material_newX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX();
    pbr_input_1_.material = _e1;
    pbr_input_1_.diffuse_occlusion = vec3(1.0);
    pbr_input_1_.specular_occlusion = 1.0;
    pbr_input_1_.frag_coord = vec4(0.0, 0.0, 0.0, 1.0);
    pbr_input_1_.world_position = vec4(0.0, 0.0, 0.0, 1.0);
    pbr_input_1_.world_normal = vec3(0.0, 0.0, 1.0);
    pbr_input_1_.is_orthographic = false;
    pbr_input_1_.N = vec3(0.0, 0.0, 1.0);
    pbr_input_1_.V = vec3(1.0, 0.0, 0.0);
    pbr_input_1_.clearcoat_N = vec3(0.0);
    pbr_input_1_.anisotropy_T = vec3(0.0);
    pbr_input_1_.anisotropy_B = vec3(0.0);
    pbr_input_1_.lightmap_light = vec3(0.0);
    pbr_input_1_.flags = 0u;
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e51_ = pbr_input_1_;
    return _e51_;
}

float copysignX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(float a, float b) {
    return uintBitsToFloat(((floatBitsToUint(a) & 2147483647u) | (floatBitsToUint(b) & 2147483648u)));
}

mat3x3 orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(vec3 z_basis) {
    float _e3 = copysignX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(1.0, z_basis.z);
    float a_3_ = (-1.0 / (_e3 + z_basis.z));
    float b_2_ = ((z_basis.x * z_basis.y) * a_3_);
    vec3 x_basis_2_ = vec3((1.0 + (((_e3 * z_basis.x) * z_basis.x) * a_3_)), (_e3 * b_2_), (-(_e3) * z_basis.x));
    vec3 y_basis_2_ = vec3(b_2_, (_e3 + ((z_basis.y * z_basis.y) * a_3_)), -(z_basis.y));
    return mat3x3(x_basis_2_, y_basis_2_, z_basis);
}

vec2 F_ABX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float perceptual_roughness, float NdotV) {
    vec4 c0_ = vec4(-1.0, -0.0275, -0.572, 0.022);
    vec4 c1_ = vec4(1.0, 0.0425, 1.04, -0.04);
    vec4 r = ((perceptual_roughness * c0_) + c1_);
    float a004_ = ((min((r.x * r.x), exp2((-9.28 * NdotV))) * r.x) + r.y);
    return max(((vec2(-1.04, 1.04) * a004_) + r.zw), vec2(5e-5));
}

float perceptualRoughnessToRoughnessX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float perceptualRoughness) {
    float clampedPerceptualRoughness = clamp(perceptualRoughness, 0.089, 1.0);
    return (clampedPerceptualRoughness * clampedPerceptualRoughness);
}

float getRangeFalloffX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float distanceSquare, float inverseRangeSquared) {
    float factor = (distanceSquare * inverseRangeSquared);
    float smoothFactor = clamp((1.0 - (factor * factor)), 0.0, 1.0);
    return (smoothFactor * smoothFactor);
}

float getDistanceAttenuationX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float distanceSquare_1_, float inverseRangeSquared_1_) {
    float _e2 = getRangeFalloffX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(distanceSquare_1_, inverseRangeSquared_1_);
    return ((_e2 * 1.0) / max(distanceSquare_1_, 0.0001));
}

vec4 compute_specular_layer_values_for_point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(inout LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX input_, uint layer, vec3 V, vec3 light_to_frag, float light_radius, float distance_) {
    float LtFdotR = 0.0;
    vec3 R = input_.layers[layer].R;
    float a_4_ = input_.layers[layer].roughness;
    LtFdotR = dot(light_to_frag, R);
    float _e13_ = LtFdotR;
    LtFdotR = max(0.0001, _e13_);
    float _e16_ = LtFdotR;
    vec3 centerToRay = ((_e16_ * R) - light_to_frag);
    vec3 closestPoint = (light_to_frag + (centerToRay * clamp((light_radius * inversesqrt(dot(centerToRay, centerToRay))), 0.0, 1.0)));
    float LspecLengthInverse = inversesqrt(dot(closestPoint, closestPoint));
    float a_prime = clamp((a_4_ + (light_radius / (2.0 * distance_))), 0.0, 1.0);
    vec3 L_1_ = (closestPoint * LspecLengthInverse);
    return vec4(L_1_, a_prime);
}

DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX derive_lighting_inputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3 N, vec3 V_1_, vec3 L) {
    DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX input_1_ = DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3(0.0), 0.0, 0.0, 0.0);
    vec3 H = vec3(0.0);
    H = normalize((L + V_1_));
    vec3 _e7_ = H;
    input_1_.H = _e7_;
    input_1_.NdotL = clamp(dot(N, L), 0.0, 1.0);
    vec3 _e13_1 = H;
    input_1_.NdotH = clamp(dot(N, _e13_1), 0.0, 1.0);
    vec3 _e17_ = H;
    input_1_.LdotH = clamp(dot(L, _e17_), 0.0, 1.0);
    DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX _e20_ = input_1_;
    return _e20_;
}

float specular_fix_remapX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float a_1_) {
    float inv_a_sq = ((1.0 - a_1_) * (1.0 - a_1_));
    return (1.0 - (inv_a_sq * inv_a_sq));
}

float D_GGXX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float roughness, float NdotH) {
    float oneMinusNdotHSquared = (1.0 - (NdotH * NdotH));
    float a_5_ = (NdotH * roughness);
    float k = (roughness / (oneMinusNdotHSquared + (a_5_ * a_5_)));
    float d = ((k * k) * 0.31830987);
    return d;
}

float V_SmithGGXCorrelatedX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float roughness_1_, float NdotV_1_, float NdotL) {
    float a2_ = (roughness_1_ * roughness_1_);
    float lambdaV = (NdotL * sqrt((((NdotV_1_ - (a2_ * NdotV_1_)) * NdotV_1_) + a2_)));
    float lambdaL = (NdotV_1_ * sqrt((((NdotL - (a2_ * NdotL)) * NdotL) + a2_)));
    float v_1_ = (0.5 / (lambdaV + lambdaL));
    return v_1_;
}

vec3 F_Schlick_vecX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3 f0_, float f90_, float VdotH) {
    return (f0_ + ((vec3(f90_) - f0_) * pow((1.0 - VdotH), 5.0)));
}

vec3 fresnelX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3 f0_1_, float LdotH) {
    float f90_2_ = clamp(dot(f0_1_, vec3(16.5)), 0.0, 1.0);
    vec3 _e6 = F_Schlick_vecX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(f0_1_, f90_2_, LdotH);
    return _e6;
}

vec3 specular_multiscatterX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float D, float V_2_, vec3 F, vec3 F0_, vec2 F_ab, float specular_intensity) {
    vec3 Fr = vec3(0.0);
    Fr = (((specular_intensity * D) * V_2_) * F);
    vec3 _e8_ = Fr;
    Fr = (_e8_ * (vec3(1.0) + (F0_ * ((1.0 / (F_ab.x + F_ab.y)) - 1.0))));
    vec3 _e23_ = Fr;
    return _e23_;
}

vec3 specularX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(inout LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX input_2_, inout DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX derived_input, float roughness_2_, float specular_intensity_1_) {
    float NdotV_3_ = input_2_.layers[0].NdotV;
    vec3 _e6_ = input_2_.F0_dielectric;
    vec3 _e8_1 = input_2_.F0_metallic;
    float _e10_ = input_2_.metallic;
    vec3 F0_2_ = mix(_e6_, _e8_1, _e10_);
    float NdotL_1_ = derived_input.NdotL;
    float NdotH_1_ = derived_input.NdotH;
    float LdotH_1_ = derived_input.LdotH;
    float _e21 = D_GGXX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(roughness_2_, NdotH_1_);
    float _e22 = V_SmithGGXCorrelatedX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(roughness_2_, NdotV_3_, NdotL_1_);
    vec3 _e23 = fresnelX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(F0_2_, LdotH_1_);
    vec2 _e24_ = input_2_.F_ab;
    vec3 _e26 = specular_multiscatterX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(_e21, _e22, _e23, F0_2_, _e24_, specular_intensity_1_);
    return _e26;
}

float F_SchlickX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(float f0_2_, float f90_1_, float VdotH_1_) {
    return (f0_2_ + ((f90_1_ - f0_2_) * pow((1.0 - VdotH_1_), 5.0)));
}

float Fd_BurleyX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(inout LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX input_3_, inout DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX derived_input_1_) {
    float roughness_3_ = input_3_.layers[0].roughness;
    float NdotV_4_ = input_3_.layers[0].NdotV;
    float NdotL_2_ = derived_input_1_.NdotL;
    float LdotH_2_ = derived_input_1_.LdotH;
    float f90_3_ = (0.5 + (((2.0 * roughness_3_) * LdotH_2_) * LdotH_2_));
    float _e21 = F_SchlickX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(1.0, f90_3_, NdotL_2_);
    float _e23 = F_SchlickX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(1.0, f90_3_, NdotV_4_);
    return ((_e21 * _e23) * 0.31830987);
}

vec3 point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(uint light_id, inout LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX input_4_, bool enable_diffuse, bool enable_texture) {
    DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX specular_derived_input = DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3(0.0), 0.0, 0.0, 0.0);
    vec3 specular_light = vec3(0.0);
    DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX derived_input_2_ = DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3(0.0), 0.0, 0.0, 0.0);
    vec3 diffuse = vec3(0.0);
    vec3 color_times_NdotL = vec3(0.0);
    float texture_sample = 1.0;
    vec3 diffuse_color_1_ = input_4_.diffuse_color;
    vec3 P = input_4_.P;
    vec3 N_1_ = input_4_.layers[0].N;
    vec3 V_5_ = input_4_.V;
    vec4 _e19_ = _group_0_binding_8_fs.data[light_id].position_radius;
    vec3 light_to_frag_1_ = (_e19_.xyz - P);
    vec3 L_2_ = normalize(light_to_frag_1_);
    float distance_square = dot(light_to_frag_1_, light_to_frag_1_);
    float distance_1_ = sqrt(distance_square);
    float _e27_ = _group_0_binding_8_fs.data[light_id].color_inverse_square_range.w;
    float _e36 = getDistanceAttenuationX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(distance_square, _e27_);
    float a_6_ = input_4_.layers[0].roughness;
    float _e35_ = _group_0_binding_8_fs.data[light_id].position_radius.w;
    vec4 _e45 = compute_specular_layer_values_for_point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_4_, LAYER_BASEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX, V_5_, light_to_frag_1_, _e35_, distance_1_);
    vec3 L_spec = _e45.xyz;
    float a_prime_1_ = _e45.w;
    DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX _e48 = derive_lighting_inputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(N_1_, V_5_, L_spec);
    specular_derived_input = _e48;
    float normalizationFactor = (a_6_ / a_prime_1_);
    float specular_intensity_2_ = (normalizationFactor * normalizationFactor);
    float _e51 = specular_fix_remapX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(a_6_);
    float brdf_roughness = mix(a_6_, a_prime_1_, _e51);
    vec3 _e53 = specularX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_4_, specular_derived_input, brdf_roughness, specular_intensity_2_);
    specular_light = _e53;
    float light_radius_1_ = _group_0_binding_8_fs.data[light_id].position_radius.w;
    if ((light_radius_1_ > 0.0)) {
        float solid_angle = ((light_radius_1_ * light_radius_1_) / (distance_1_ * distance_1_));
        vec3 _e56_ = specular_light;
        float _e58_ = specular_derived_input.NdotL;
        float _e60_ = specular_derived_input.NdotL;
        specular_light = (_e56_ * clamp((_e58_ / max((_e60_ + solid_angle), 0.0001)), 0.0, 1.0));
    }
    DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX _e73 = derive_lighting_inputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(N_1_, V_5_, L_2_);
    derived_input_2_ = _e73;
    if (enable_diffuse) {
        float _e74 = Fd_BurleyX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_4_, derived_input_2_);
        diffuse = (diffuse_color_1_ * _e74);
    }
    vec3 _e73_ = diffuse;
    float _e75_ = derived_input_2_.NdotL;
    vec3 _e77_ = specular_light;
    float _e79_ = specular_derived_input.NdotL;
    color_times_NdotL = ((_e73_ * _e75_) + (_e77_ * _e79_));
    vec3 _e84_ = color_times_NdotL;
    vec4 _e86_ = _group_0_binding_8_fs.data[light_id].color_inverse_square_range;
    float _e90_ = texture_sample;
    return (((_e84_ * _e86_.xyz) * _e36) * _e90_);
}

vec3 spot_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(uint light_id_1_, inout LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX input_5_, bool enable_diffuse_1_) {
    vec3 spot_dir = vec3(0.0);
    float texture_sample_1_ = 1.0;
    vec3 _e7 = point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(light_id_1_, input_5_, enable_diffuse_1_, false);
    float _e11_ = _group_0_binding_8_fs.data[light_id_1_].light_custom_data.x;
    float _e14_ = _group_0_binding_8_fs.data[light_id_1_].light_custom_data.y;
    spot_dir = vec3(_e11_, 0.0, _e14_);
    float _e20_1 = spot_dir.x;
    float _e22_ = spot_dir.x;
    float _e27_1 = spot_dir.z;
    float _e29_ = spot_dir.z;
    spot_dir.y = sqrt(max(0.0, ((1.0 - (_e20_1 * _e22_)) - (_e27_1 * _e29_))));
    uint _e36_ = _group_0_binding_8_fs.data[light_id_1_].flags;
    if (((_e36_ & POINT_LIGHT_FLAGS_SPOT_LIGHT_Y_NEGATIVEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u)) {
        float _e43_ = spot_dir.y;
        spot_dir.y = -(_e43_);
    }
    vec4 _e46_ = _group_0_binding_8_fs.data[light_id_1_].position_radius;
    vec3 _e49_ = input_5_.P;
    vec3 light_to_frag_2_ = (_e46_.xyz - _e49_.xyz);
    vec3 _e52_ = spot_dir;
    float cd = dot(-(_e52_), normalize(light_to_frag_2_));
    float _e58_1 = _group_0_binding_8_fs.data[light_id_1_].light_custom_data.z;
    float _e62_ = _group_0_binding_8_fs.data[light_id_1_].light_custom_data.w;
    float attenuation = clamp(((cd * _e58_1) + _e62_), 0.0, 1.0);
    float spot_attenuation = (attenuation * attenuation);
    float _e68_ = texture_sample_1_;
    return ((_e7 * spot_attenuation) * _e68_);
}

vec3 directional_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(uint light_id_2_, inout LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX input_6_, bool enable_diffuse_2_) {
    DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX derived_input_3_ = DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3(0.0), 0.0, 0.0, 0.0);
    vec3 diffuse_1_ = vec3(0.0);
    vec3 color = vec3(0.0);
    float texture_sample_2_ = 1.0;
    vec3 diffuse_color_2_ = input_6_.diffuse_color;
    float NdotV_5_ = input_6_.layers[0].NdotV;
    vec3 N_2_ = input_6_.layers[0].N;
    vec3 V_6_ = input_6_.V;
    float roughness_4_ = input_6_.layers[0].roughness;
    vec3 _e25_ = _group_0_binding_1_fs.directional_lights[light_id_2_].direction_to_light;
    vec3 L_3_ = _e25_.xyz;
    DerivedLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX _e32 = derive_lighting_inputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(N_2_, V_6_, L_3_);
    derived_input_3_ = _e32;
    if (enable_diffuse_2_) {
        float _e33 = Fd_BurleyX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_6_, derived_input_3_);
        diffuse_1_ = (diffuse_color_2_ * _e33);
    }
    vec3 _e36 = specularX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(input_6_, derived_input_3_, roughness_4_, 1.0);
    vec3 _e35_1 = diffuse_1_;
    float _e38_ = derived_input_3_.NdotL;
    color = ((_e35_1 + _e36) * _e38_);
    vec3 _e42_ = color;
    vec4 _e44_ = _group_0_binding_1_fs.directional_lights[light_id_2_].color;
    float _e46_1 = texture_sample_2_;
    color = (_e42_ * (_e44_.xyz * _e46_1));
    vec3 _e49_1 = color;
    return _e49_1;
}

uint view_z_to_z_sliceX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(vec2 cluster_factors, uint z_slices, float view_z, bool is_orthographic) {
    uint z_slice = 0u;
    if (is_orthographic) {
        z_slice = uint(floor(((view_z - cluster_factors.x) * cluster_factors.y)));
    } else {
        z_slice = uint((((log(-(view_z)) * cluster_factors.x) - cluster_factors.y) + 1.0));
    }
    uint _e20_2 = z_slice;
    return min(_e20_2, (z_slices - 1u));
}

uint fragment_cluster_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(uvec3 p, uvec4 cluster_dimensions) {
    return min(((((p.y * cluster_dimensions.x) + p.x) * cluster_dimensions.z) + p.z), (cluster_dimensions.w - 1u));
}

uint view_fragment_cluster_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(vec2 frag_coord, float view_z_1_, bool is_orthographic_1_) {
    vec4 _e3_ = _group_0_binding_0_fs.viewport;
    vec4 _e8_2 = _group_0_binding_1_fs.cluster_factors;
    uvec2 xy = uvec2(floor(((frag_coord - _e3_.xy) * _e8_2.xy)));
    vec4 _e15_ = _group_0_binding_1_fs.cluster_factors;
    uint _e20_3 = _group_0_binding_1_fs.cluster_dimensions.z;
    uint _e23 = view_z_to_z_sliceX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e15_.zw, _e20_3, view_z_1_, is_orthographic_1_);
    uvec4 _e27_2 = _group_0_binding_1_fs.cluster_dimensions;
    uint _e28 = fragment_cluster_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(uvec3(xy, _e23), _e27_2);
    return _e28;
}

ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX unpack_clusterable_object_index_rangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(uint cluster_index) {
    uint raw_offset_and_counts = _group_0_binding_10_fs.data[(cluster_index >> 2u)][(cluster_index & 3u)];
    uvec3 offset_and_counts = uvec3(((raw_offset_and_counts >> 18u) & 16383u), ((raw_offset_and_counts >> CLUSTER_COUNT_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX) & 511u), (raw_offset_and_counts & 511u));
    uint offset_a = offset_and_counts.x;
    uint offset_b = (offset_a + offset_and_counts.y);
    uint offset_c = (offset_b + offset_and_counts.z);
    return ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(offset_a, offset_b, offset_c, offset_c, offset_c, offset_c);
}

uint get_clusterable_object_idX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(uint index) {
    uint indices = _group_0_binding_9_fs.data[(index >> 4u)][((index >> 2u) & 3u)];
    return ((indices >> (8u * (index & 3u))) & 255u);
}

vec4 cluster_debug_visualizationX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(vec4 input_color, float view_z_2_, bool is_orthographic_2_, ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX clusterable_object_index_ranges, uint cluster_index_1_) {
    vec4 output_color = vec4(0.0);
    output_color = input_color;
    vec4 _e2_ = output_color;
    return _e2_;
}

float interleaved_gradient_noiseX_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX(vec2 pixel_coordinates, uint frame) {
    vec2 xy_1_ = (pixel_coordinates + vec2((5.588238 * float((frame % 64u)))));
    return fract((52.982918 * fract(((0.06711056 * xy_1_.x) + (0.00583715 * xy_1_.y)))));
}

float sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 light_local, float depth, int array_index) {
    float _e5_ = texture(_group_0_binding_5_fs, vec4(light_local, array_index, depth));
    return _e5_;
}

float sample_shadow_map_castano_thirteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 light_local_1_, float depth_1_, int array_index_1_) {
    vec2 base_uv = vec2(0.0);
    float sum = 0.0;
    uvec2 _e2_1 = uvec2(textureSize(_group_0_binding_5_fs, 0).xy);
    vec2 shadow_map_size = vec2(_e2_1);
    vec2 inv_shadow_map_size = (vec2(1.0) / shadow_map_size);
    vec2 uv_1_ = (light_local_1_ * shadow_map_size);
    base_uv = floor((uv_1_ + vec2(0.5)));
    float _e18_ = base_uv.x;
    float s = ((uv_1_.x + 0.5) - _e18_);
    float _e24_1 = base_uv.y;
    float t = ((uv_1_.y + 0.5) - _e24_1);
    vec2 _e26_ = base_uv;
    base_uv = (_e26_ - vec2(0.5));
    vec2 _e30_ = base_uv;
    base_uv = (_e30_ * inv_shadow_map_size);
    float uw0_ = (4.0 - (3.0 * s));
    float uw2_ = (1.0 + (3.0 * s));
    float u0_ = (((3.0 - (2.0 * s)) / uw0_) - 2.0);
    float u1_ = ((3.0 + s) / 7.0);
    float u2_ = ((s / uw2_) + 2.0);
    float vw0_ = (4.0 - (3.0 * t));
    float vw2_ = (1.0 + (3.0 * t));
    float v0_ = (((3.0 - (2.0 * t)) / vw0_) - 2.0);
    float v1_ = ((3.0 + t) / 7.0);
    float v2_ = ((t / vw2_) + 2.0);
    float _e77_1 = sum;
    vec2 _e79_1 = base_uv;
    float _e84 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e79_1 + (vec2(u0_, v0_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e77_1 + ((uw0_ * vw0_) * _e84));
    float _e88_ = sum;
    vec2 _e90_1 = base_uv;
    float _e93 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e90_1 + (vec2(u1_, v0_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e88_ + ((7.0 * vw0_) * _e93));
    float _e97_ = sum;
    vec2 _e99_ = base_uv;
    float _e103 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e99_ + (vec2(u2_, v0_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e97_ + ((uw2_ * vw0_) * _e103));
    float _e106_ = sum;
    vec2 _e108_ = base_uv;
    float _e112 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e108_ + (vec2(u0_, v1_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e106_ + ((uw0_ * 7.0) * _e112));
    float _e115_ = sum;
    vec2 _e117_ = base_uv;
    float _e122 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e117_ + (vec2(u1_, v1_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e115_ + (49.0 * _e122));
    float _e124_ = sum;
    vec2 _e126_ = base_uv;
    float _e131 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e126_ + (vec2(u2_, v1_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e124_ + ((uw2_ * 7.0) * _e131));
    float _e133_ = sum;
    vec2 _e135_ = base_uv;
    float _e141 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e135_ + (vec2(u0_, v2_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e133_ + ((uw0_ * vw2_) * _e141));
    float _e142_ = sum;
    vec2 _e144_ = base_uv;
    float _e150 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e144_ + (vec2(u1_, v2_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e142_ + ((7.0 * vw2_) * _e150));
    float _e151_ = sum;
    vec2 _e153_ = base_uv;
    float _e160 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((_e153_ + (vec2(u2_, v2_) * inv_shadow_map_size)), depth_1_, array_index_1_);
    sum = (_e151_ + ((uw2_ * vw2_) * _e160));
    float _e160_ = sum;
    return (_e160_ * 0.0069444445);
}

float sample_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 light_local_2_, float depth_2_, int array_index_2_, vec2 frag_coord_xy, float texel_size) {
    float _e5 = sample_shadow_map_castano_thirteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_2_, depth_2_, array_index_2_);
    return _e5;
}

vec2 search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 light_local_3_, float depth_3_, int array_index_3_) {
    return vec2(0.0);
}

float search_for_blockers_in_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 light_local_4_, float depth_4_, int array_index_4_, float texel_size_1_, float search_size) {
    vec2 sum_1_ = vec2(0.0);
    uvec2 _e3_1 = uvec2(textureSize(_group_0_binding_5_fs, 0).xy);
    vec2 shadow_map_size_1_ = vec2(_e3_1);
    vec2 uv_offset_scale = (vec2(search_size) / (texel_size_1_ * shadow_map_size_1_));
    vec2 offset0_ = (vec2(0.125, -0.375) * uv_offset_scale);
    vec2 offset1_ = (vec2(-0.125, 0.375) * uv_offset_scale);
    vec2 offset2_ = (vec2(0.625, 0.125) * uv_offset_scale);
    vec2 offset3_ = (vec2(-0.375, -0.625) * uv_offset_scale);
    vec2 offset4_ = (vec2(-0.625, 0.625) * uv_offset_scale);
    vec2 offset5_ = (vec2(-0.875, -0.125) * uv_offset_scale);
    vec2 offset6_ = (vec2(0.375, 0.875) * uv_offset_scale);
    vec2 offset7_ = (vec2(0.875, -0.875) * uv_offset_scale);
    vec2 _e44_1 = sum_1_;
    vec2 _e48 = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4_ + offset0_), depth_4_, array_index_4_);
    sum_1_ = (_e44_1 + _e48);
    vec2 _e50_ = sum_1_;
    vec2 _e52 = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4_ + offset1_), depth_4_, array_index_4_);
    sum_1_ = (_e50_ + _e52);
    vec2 _e54_ = sum_1_;
    vec2 _e56 = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4_ + offset2_), depth_4_, array_index_4_);
    sum_1_ = (_e54_ + _e56);
    vec2 _e58_2 = sum_1_;
    vec2 _e60 = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4_ + offset3_), depth_4_, array_index_4_);
    sum_1_ = (_e58_2 + _e60);
    vec2 _e62_1 = sum_1_;
    vec2 _e64 = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4_ + offset4_), depth_4_, array_index_4_);
    sum_1_ = (_e62_1 + _e64);
    vec2 _e66_1 = sum_1_;
    vec2 _e68 = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4_ + offset5_), depth_4_, array_index_4_);
    sum_1_ = (_e66_1 + _e68);
    vec2 _e70_ = sum_1_;
    vec2 _e72 = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4_ + offset6_), depth_4_, array_index_4_);
    sum_1_ = (_e70_ + _e72);
    vec2 _e74_ = sum_1_;
    vec2 _e76 = search_for_blockers_in_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_4_ + offset7_), depth_4_, array_index_4_);
    sum_1_ = (_e74_ + _e76);
    float _e79_2 = sum_1_.y;
    if ((_e79_2 == 0.0)) {
        return 0.0;
    }
    float _e84_1 = sum_1_.x;
    float _e86_1 = sum_1_.y;
    return (_e84_1 / _e86_1);
}

mat2x2 random_rotation_matrixX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 scale, bool temporal) {
    uint _e4_ = _group_0_binding_11_fs.frame_count;
    float _e7 = interleaved_gradient_noiseX_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX(scale, (temporal ? _e4_ : 1u));
    float random_angle = (6.2831855 * _e7);
    vec2 m = vec2(sin(random_angle), cos(random_angle));
    return mat2x2(vec2(m.y, -(m.x)), vec2(m.x, m.y));
}

float mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(float min1_, float max1_, float min2_, float max2_, float value) {
    return (min2_ + (((value - min1_) * (max2_ - min2_)) / (max1_ - min1_)));
}

vec2 calculate_uv_offset_scale_jimenez_fourteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(float texel_size_2_, float blur_size) {
    uvec2 _e1_ = uvec2(textureSize(_group_0_binding_5_fs, 0).xy);
    vec2 shadow_map_size_2_ = vec2(_e1_);
    float _e9 = mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(0.00390625, 0.022949219, 0.015, 0.035, texel_size_2_);
    return (vec2((_e9 * blur_size)) / (texel_size_2_ * shadow_map_size_2_));
}

float sample_shadow_map_jimenez_fourteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 light_local_5_, float depth_5_, int array_index_5_, vec2 frag_coord_xy_1_, float texel_size_3_, float blur_size_1_, bool temporal_1_) {
    float sum_2_ = 0.0;
    mat2x2 _e9 = random_rotation_matrixX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(frag_coord_xy_1_, temporal_1_);
    vec2 _e10 = calculate_uv_offset_scale_jimenez_fourteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(texel_size_3_, blur_size_1_);
    vec2 sample_offset0_ = ((_e9 * SPIRAL_OFFSET_0_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e10);
    vec2 sample_offset1_ = ((_e9 * SPIRAL_OFFSET_1_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e10);
    vec2 sample_offset2_ = ((_e9 * SPIRAL_OFFSET_2_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e10);
    vec2 sample_offset3_ = ((_e9 * SPIRAL_OFFSET_3_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e10);
    vec2 sample_offset4_ = ((_e9 * SPIRAL_OFFSET_4_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e10);
    vec2 sample_offset5_ = ((_e9 * SPIRAL_OFFSET_5_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e10);
    vec2 sample_offset6_ = ((_e9 * SPIRAL_OFFSET_6_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e10);
    vec2 sample_offset7_ = ((_e9 * SPIRAL_OFFSET_7_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * _e10);
    float _e33_ = sum_2_;
    float _e37 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5_ + sample_offset0_), depth_5_, array_index_5_);
    sum_2_ = (_e33_ + _e37);
    float _e39_ = sum_2_;
    float _e41 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5_ + sample_offset1_), depth_5_, array_index_5_);
    sum_2_ = (_e39_ + _e41);
    float _e43_1 = sum_2_;
    float _e45 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5_ + sample_offset2_), depth_5_, array_index_5_);
    sum_2_ = (_e43_1 + _e45);
    float _e47_ = sum_2_;
    float _e49 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5_ + sample_offset3_), depth_5_, array_index_5_);
    sum_2_ = (_e47_ + _e49);
    float _e51_1 = sum_2_;
    float _e53 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5_ + sample_offset4_), depth_5_, array_index_5_);
    sum_2_ = (_e51_1 + _e53);
    float _e55_ = sum_2_;
    float _e57 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5_ + sample_offset5_), depth_5_, array_index_5_);
    sum_2_ = (_e55_ + _e57);
    float _e59_ = sum_2_;
    float _e61 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5_ + sample_offset6_), depth_5_, array_index_5_);
    sum_2_ = (_e59_ + _e61);
    float _e63_ = sum_2_;
    float _e65 = sample_shadow_map_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((light_local_5_ + sample_offset7_), depth_5_, array_index_5_);
    sum_2_ = (_e63_ + _e65);
    float _e67_ = sum_2_;
    return (_e67_ / 8.0);
}

float sample_shadow_map_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 light_local_6_, float depth_6_, int array_index_6_, vec2 frag_coord_xy_2_, float texel_size_4_, float light_size) {
    float _e6 = search_for_blockers_in_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_6_, depth_6_, array_index_6_, texel_size_4_, light_size);
    float blur_size_2_ = max((((_e6 - depth_6_) * light_size) / depth_6_), 0.5);
    float _e13 = sample_shadow_map_jimenez_fourteenX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_6_, depth_6_, array_index_6_, frag_coord_xy_2_, texel_size_4_, blur_size_2_, false);
    return _e13;
}

float sample_shadow_cubemap_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec3 light_local_7_, float depth_7_, uint light_id_3_) {
    float _e6_1 = texture(_group_0_binding_2_fs, vec4(light_local_7_, int(light_id_3_)), depth_7_);
    return _e6_1;
}

float sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 position, float coeff, vec3 x_basis, vec3 y_basis, vec3 light_local_8_, float depth_8_, uint light_id_4_) {
    float _e13 = sample_shadow_cubemap_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(((light_local_8_ + (position.x * x_basis)) + (position.y * y_basis)), depth_8_, light_id_4_);
    return (_e13 * coeff);
}

float sample_shadow_cubemap_gaussianX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec3 light_local_9_, float depth_9_, float scale_1_, float distance_to_light, uint light_id_5_) {
    float sum_3_ = 0.0;
    mat3x3 _e8 = orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(normalize(light_local_9_));
    mat3x3 basis = ((_e8 * scale_1_) * distance_to_light);
    float _e9_ = sum_3_;
    float _e18 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(0.125, -0.375), 0.157112, basis[0], basis[1], light_local_9_, depth_9_, light_id_5_);
    sum_3_ = (_e9_ + _e18);
    float _e20_4 = sum_3_;
    float _e27 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(-0.125, 0.375), 0.157112, basis[0], basis[1], light_local_9_, depth_9_, light_id_5_);
    sum_3_ = (_e20_4 + _e27);
    float _e29_1 = sum_3_;
    float _e36 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(0.625, 0.125), 0.138651, basis[0], basis[1], light_local_9_, depth_9_, light_id_5_);
    sum_3_ = (_e29_1 + _e36);
    float _e38_1 = sum_3_;
    float _e45 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(-0.375, -0.625), 0.130251, basis[0], basis[1], light_local_9_, depth_9_, light_id_5_);
    sum_3_ = (_e38_1 + _e45);
    float _e47_1 = sum_3_;
    float _e54 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(-0.625, 0.625), 0.114946, basis[0], basis[1], light_local_9_, depth_9_, light_id_5_);
    sum_3_ = (_e47_1 + _e54);
    float _e56_1 = sum_3_;
    float _e63 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(-0.875, -0.125), 0.114946, basis[0], basis[1], light_local_9_, depth_9_, light_id_5_);
    sum_3_ = (_e56_1 + _e63);
    float _e65_ = sum_3_;
    float _e72 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(0.375, 0.875), 0.107982, basis[0], basis[1], light_local_9_, depth_9_, light_id_5_);
    sum_3_ = (_e65_ + _e72);
    float _e74_1 = sum_3_;
    float _e81 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(0.875, -0.875), 0.079001, basis[0], basis[1], light_local_9_, depth_9_, light_id_5_);
    sum_3_ = (_e74_1 + _e81);
    float _e83_ = sum_3_;
    return _e83_;
}

float sample_shadow_cubemapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec3 light_local_10_, float distance_to_light_1_, float depth_10_, uint light_id_6_, vec2 frag_coord_xy_3_) {
    float _e6 = sample_shadow_cubemap_gaussianX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_10_, depth_10_, POINT_SHADOW_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX, distance_to_light_1_, light_id_6_);
    return _e6;
}

vec2 search_for_blockers_in_shadow_cubemap_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec3 light_local_11_, float depth_11_, uint light_id_7_) {
    return vec2(0.0);
}

vec2 search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2 position_1_, vec3 x_basis_1_, vec3 y_basis_1_, vec3 light_local_12_, float depth_12_, uint light_id_8_) {
    vec2 _e12 = search_for_blockers_in_shadow_cubemap_hardwareX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(((light_local_12_ + (position_1_.x * x_basis_1_)) + (position_1_.y * y_basis_1_)), depth_12_, light_id_8_);
    return _e12;
}

float search_for_blockers_in_shadow_cubemapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec3 light_local_13_, float depth_13_, float scale_2_, float distance_to_light_2_, uint light_id_9_) {
    vec2 sum_4_ = vec2(0.0);
    mat3x3 _e9 = orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(normalize(light_local_13_));
    mat3x3 basis_1_ = ((_e9 * scale_2_) * distance_to_light_2_);
    vec2 _e10_1 = sum_4_;
    vec2 _e18 = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(0.125, -0.375), basis_1_[0], basis_1_[1], light_local_13_, depth_13_, light_id_9_);
    sum_4_ = (_e10_1 + _e18);
    vec2 _e20_5 = sum_4_;
    vec2 _e26 = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(-0.125, 0.375), basis_1_[0], basis_1_[1], light_local_13_, depth_13_, light_id_9_);
    sum_4_ = (_e20_5 + _e26);
    vec2 _e28_ = sum_4_;
    vec2 _e34 = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(0.625, 0.125), basis_1_[0], basis_1_[1], light_local_13_, depth_13_, light_id_9_);
    sum_4_ = (_e28_ + _e34);
    vec2 _e36_1 = sum_4_;
    vec2 _e42 = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(-0.375, -0.625), basis_1_[0], basis_1_[1], light_local_13_, depth_13_, light_id_9_);
    sum_4_ = (_e36_1 + _e42);
    vec2 _e44_2 = sum_4_;
    vec2 _e50 = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(-0.625, 0.625), basis_1_[0], basis_1_[1], light_local_13_, depth_13_, light_id_9_);
    sum_4_ = (_e44_2 + _e50);
    vec2 _e52_1 = sum_4_;
    vec2 _e58 = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(-0.875, -0.125), basis_1_[0], basis_1_[1], light_local_13_, depth_13_, light_id_9_);
    sum_4_ = (_e52_1 + _e58);
    vec2 _e60_1 = sum_4_;
    vec2 _e66 = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(0.375, 0.875), basis_1_[0], basis_1_[1], light_local_13_, depth_13_, light_id_9_);
    sum_4_ = (_e60_1 + _e66);
    vec2 _e68_1 = sum_4_;
    vec2 _e74 = search_for_blockers_in_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec2(0.875, -0.875), basis_1_[0], basis_1_[1], light_local_13_, depth_13_, light_id_9_);
    sum_4_ = (_e68_1 + _e74);
    float _e77_2 = sum_4_.y;
    if ((_e77_2 == 0.0)) {
        return 0.0;
    }
    float _e82_ = sum_4_.x;
    float _e84_2 = sum_4_.y;
    return (_e82_ / _e84_2);
}

float sample_shadow_cubemap_jitteredX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec3 light_local_14_, float depth_14_, vec2 frag_coord_xy_4_, float scale_3_, float distance_to_light_3_, uint light_id_10_, bool temporal_2_) {
    float sum_5_ = 0.0;
    mat2x2 _e9 = random_rotation_matrixX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(frag_coord_xy_4_, temporal_2_);
    vec2 sample_offset0_1_ = ((_e9 * SPIRAL_OFFSET_0_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    vec2 sample_offset1_1_ = ((_e9 * SPIRAL_OFFSET_1_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    vec2 sample_offset2_1_ = ((_e9 * SPIRAL_OFFSET_2_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    vec2 sample_offset3_1_ = ((_e9 * SPIRAL_OFFSET_3_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    vec2 sample_offset4_1_ = ((_e9 * SPIRAL_OFFSET_4_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    vec2 sample_offset5_1_ = ((_e9 * SPIRAL_OFFSET_5_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    vec2 sample_offset6_1_ = ((_e9 * SPIRAL_OFFSET_6_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    vec2 sample_offset7_1_ = ((_e9 * SPIRAL_OFFSET_7_X_naga_oil_mod_XMJSXM6K7OBRHEOR2OV2GS3DTX) * POINT_SHADOW_TEMPORAL_OFFSET_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    mat3x3 _e43 = orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(normalize(light_local_14_));
    mat3x3 basis_2_ = ((_e43 * scale_3_) * distance_to_light_3_);
    float _e44_3 = sum_5_;
    float _e50 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset0_1_, 0.125, basis_2_[0], basis_2_[1], light_local_14_, depth_14_, light_id_10_);
    sum_5_ = (_e44_3 + _e50);
    float _e52_2 = sum_5_;
    float _e56 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset1_1_, 0.125, basis_2_[0], basis_2_[1], light_local_14_, depth_14_, light_id_10_);
    sum_5_ = (_e52_2 + _e56);
    float _e58_3 = sum_5_;
    float _e62 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset2_1_, 0.125, basis_2_[0], basis_2_[1], light_local_14_, depth_14_, light_id_10_);
    sum_5_ = (_e58_3 + _e62);
    float _e64_ = sum_5_;
    float _e68 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset3_1_, 0.125, basis_2_[0], basis_2_[1], light_local_14_, depth_14_, light_id_10_);
    sum_5_ = (_e64_ + _e68);
    float _e70_1 = sum_5_;
    float _e74 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset4_1_, 0.125, basis_2_[0], basis_2_[1], light_local_14_, depth_14_, light_id_10_);
    sum_5_ = (_e70_1 + _e74);
    float _e76_ = sum_5_;
    float _e80 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset5_1_, 0.125, basis_2_[0], basis_2_[1], light_local_14_, depth_14_, light_id_10_);
    sum_5_ = (_e76_ + _e80);
    float _e82_1 = sum_5_;
    float _e86 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset6_1_, 0.125, basis_2_[0], basis_2_[1], light_local_14_, depth_14_, light_id_10_);
    sum_5_ = (_e82_1 + _e86);
    float _e88_1 = sum_5_;
    float _e92 = sample_shadow_cubemap_at_offsetX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(sample_offset7_1_, 0.125, basis_2_[0], basis_2_[1], light_local_14_, depth_14_, light_id_10_);
    sum_5_ = (_e88_1 + _e92);
    float _e94_ = sum_5_;
    return _e94_;
}

float sample_shadow_cubemap_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(vec3 light_local_15_, float distance_to_light_4_, float depth_15_, uint light_id_11_, float light_size_1_, vec2 frag_coord_xy_5_) {
    float _e6 = search_for_blockers_in_shadow_cubemapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_15_, depth_15_, light_size_1_, distance_to_light_4_, light_id_11_);
    float blur_size_3_ = max((((_e6 - depth_15_) * light_size_1_) / depth_15_), 0.5);
    float _e15 = sample_shadow_cubemap_jitteredX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(light_local_15_, depth_15_, frag_coord_xy_5_, (POINT_SHADOW_SCALEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX * blur_size_3_), distance_to_light_4_, light_id_11_, false);
    return _e15;
}

vec3 hsv_to_rgbX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(vec3 hsv) {
    vec3 n = vec3(5.0, 3.0, 1.0);
    vec3 k_1_ = ((n + vec3((hsv.x / FRAC_PI_3X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX))) - vec3(6.0) * trunc((n + vec3((hsv.x / FRAC_PI_3X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX))) / vec3(6.0)));
    return (vec3(hsv.z) - ((hsv.z * hsv.y) * max(vec3(0.0), min(k_1_, min((vec3(4.0) - k_1_), vec3(1.0))))));
}

float fetch_point_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(uint light_id_12_, vec4 frag_position, vec3 surface_normal, vec2 frag_coord_xy_6_) {
    vec4 _e6_2 = _group_0_binding_8_fs.data[light_id_12_].position_radius;
    vec3 surface_to_light = (_e6_2.xyz - frag_position.xyz);
    vec3 surface_to_light_abs = abs(surface_to_light);
    float distance_to_light_5_ = max(surface_to_light_abs.x, max(surface_to_light_abs.y, surface_to_light_abs.z));
    float _e18_1 = _group_0_binding_8_fs.data[light_id_12_].shadow_normal_bias;
    vec3 normal_offset = ((_e18_1 * distance_to_light_5_) * surface_normal.xyz);
    float _e23_1 = _group_0_binding_8_fs.data[light_id_12_].shadow_depth_bias;
    vec3 depth_offset = (_e23_1 * normalize(surface_to_light.xyz));
    vec3 offset_position_1_ = ((frag_position.xyz + normal_offset) + depth_offset);
    vec4 _e32_ = _group_0_binding_8_fs.data[light_id_12_].position_radius;
    vec3 frag_ls = (offset_position_1_.xyz - _e32_.xyz);
    vec3 abs_position_ls = abs(frag_ls);
    float major_axis_magnitude = max(abs_position_ls.x, max(abs_position_ls.y, abs_position_ls.z));
    vec4 _e43_2 = _group_0_binding_8_fs.data[light_id_12_].light_custom_data;
    vec4 _e47_2 = _group_0_binding_8_fs.data[light_id_12_].light_custom_data;
    vec2 zw = ((-(major_axis_magnitude) * _e43_2.xy) + _e47_2.zw);
    float depth_16_ = (zw.x / zw.y);
    float _e54_1 = _group_0_binding_8_fs.data[light_id_12_].soft_shadow_size;
    if ((_e54_1 > 0.0)) {
        float _e60_2 = _group_0_binding_8_fs.data[light_id_12_].soft_shadow_size;
        float _e62 = sample_shadow_cubemap_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((frag_ls * flip_zX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX), distance_to_light_5_, depth_16_, light_id_12_, _e60_2, frag_coord_xy_6_);
        return _e62;
    }
    float _e65 = sample_shadow_cubemapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX((frag_ls * flip_zX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX), distance_to_light_5_, depth_16_, light_id_12_, frag_coord_xy_6_);
    return _e65;
}

float fetch_spot_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(uint light_id_13_, vec4 frag_position_1_, vec3 surface_normal_1_, float near_z, vec2 frag_coord_xy_7_) {
    vec3 spot_dir_1_ = vec3(0.0);
    vec4 _e6_3 = _group_0_binding_8_fs.data[light_id_13_].position_radius;
    vec3 surface_to_light_1_ = (_e6_3.xyz - frag_position_1_.xyz);
    float _e12_ = _group_0_binding_8_fs.data[light_id_13_].light_custom_data.x;
    float _e15_1 = _group_0_binding_8_fs.data[light_id_13_].light_custom_data.y;
    spot_dir_1_ = vec3(_e12_, 0.0, _e15_1);
    float _e21_ = spot_dir_1_.x;
    float _e23_2 = spot_dir_1_.x;
    float _e28_1 = spot_dir_1_.z;
    float _e30_1 = spot_dir_1_.z;
    spot_dir_1_.y = sqrt(max(0.0, ((1.0 - (_e21_ * _e23_2)) - (_e28_1 * _e30_1))));
    uint _e37_ = _group_0_binding_8_fs.data[light_id_13_].flags;
    if (((_e37_ & POINT_LIGHT_FLAGS_SPOT_LIGHT_Y_NEGATIVEX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u)) {
        float _e44_4 = spot_dir_1_.y;
        spot_dir_1_.y = -(_e44_4);
    }
    vec3 _e46_2 = spot_dir_1_;
    vec3 fwd = -(_e46_2);
    float distance_to_light_6_ = dot(fwd, surface_to_light_1_);
    float _e52_3 = _group_0_binding_8_fs.data[light_id_13_].shadow_depth_bias;
    float _e58_4 = _group_0_binding_8_fs.data[light_id_13_].shadow_normal_bias;
    vec3 offset_position_2_ = ((-(surface_to_light_1_) + (_e52_3 * normalize(surface_to_light_1_))) + ((surface_normal_1_.xyz * _e58_4) * distance_to_light_6_));
    mat3x3 _e64 = orthonormalizeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(fwd);
    vec3 projected_position = (offset_position_2_ * _e64);
    float _e65_1 = _group_0_binding_8_fs.data[light_id_13_].spot_light_tan_angle;
    float f_div_minus_z = (1.0 / (_e65_1 * -(projected_position.z)));
    vec2 shadow_xy_ndc = (projected_position.xy * f_div_minus_z);
    vec2 shadow_uv = ((shadow_xy_ndc * vec2(0.5, -0.5)) + vec2(0.5, 0.5));
    float depth_17_ = (near_z / -(projected_position.z));
    int _e88_2 = _group_0_binding_1_fs.spot_light_shadowmap_offset;
    int array_index_7_ = (int(light_id_13_) + _e88_2);
    float _e91_ = _group_0_binding_8_fs.data[light_id_13_].soft_shadow_size;
    if ((_e91_ > 0.0)) {
        float _e95_ = _group_0_binding_8_fs.data[light_id_13_].soft_shadow_size;
        float _e98 = sample_shadow_map_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(shadow_uv, depth_17_, array_index_7_, frag_coord_xy_7_, SPOT_SHADOW_TEXEL_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX, _e95_);
        return _e98;
    }
    float _e100 = sample_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(shadow_uv, depth_17_, array_index_7_, frag_coord_xy_7_, SPOT_SHADOW_TEXEL_SIZEX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX);
    return _e100;
}

uint get_cascade_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(uint light_id_14_, float view_z_3_) {
    uint i = 0u;
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            uint _e19_1 = i;
            i = (_e19_1 + 1u);
        }
        loop_init = false;
        uint _e6_4 = i;
        uint _e8_3 = _group_0_binding_1_fs.directional_lights[light_id_14_].num_cascades;
        if ((_e6_4 < _e8_3)) {
        } else {
            break;
        }
        {
            uint _e13_2 = i;
            float _e16_1 = _group_0_binding_1_fs.directional_lights[light_id_14_].cascades[_e13_2].far_bound;
            if ((-(view_z_3_) < _e16_1)) {
                uint _e18_2 = i;
                return _e18_2;
            }
        }
    }
    uint _e23_3 = _group_0_binding_1_fs.directional_lights[light_id_14_].num_cascades;
    return _e23_3;
}

vec4 world_to_directional_light_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(uint light_id_15_, uint cascade_index, vec4 offset_position) {
    bool local_1_ = false;
    bool local_2_ = false;
    mat4x4 _e9_1 = _group_0_binding_1_fs.directional_lights[light_id_15_].cascades[cascade_index].clip_from_world;
    vec4 offset_position_clip = (_e9_1 * offset_position);
    if ((offset_position_clip.w <= 0.0)) {
        return vec4(0.0);
    }
    vec3 offset_position_ndc = (offset_position_clip.xyz / vec3(offset_position_clip.w));
    if (!(any(lessThan(offset_position_ndc.xy, vec2(-1.0))))) {
        local_1_ = (offset_position_ndc.z < 0.0);
    } else {
        local_1_ = true;
    }
    bool _e32_1 = local_1_;
    if (!(_e32_1)) {
        local_2_ = any(greaterThan(offset_position_ndc, vec3(1.0)));
    } else {
        local_2_ = true;
    }
    bool _e41_ = local_2_;
    if (_e41_) {
        return vec4(0.0);
    }
    vec2 flip_correction = vec2(0.5, -0.5);
    vec2 light_local_16_ = ((offset_position_ndc.xy * flip_correction) + vec2(0.5, 0.5));
    float depth_18_ = offset_position_ndc.z;
    return vec4(light_local_16_, depth_18_, 1.0);
}

float sample_directional_cascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(uint light_id_16_, uint cascade_index_1_, vec4 frag_position_2_, vec3 surface_normal_2_, vec2 frag_coord_xy_8_) {
    float _e9_2 = _group_0_binding_1_fs.directional_lights[light_id_16_].shadow_normal_bias;
    float _e11_1 = _group_0_binding_1_fs.directional_lights[light_id_16_].cascades[cascade_index_1_].texel_size;
    vec3 normal_offset_1_ = ((_e9_2 * _e11_1) * surface_normal_2_.xyz);
    float _e16_2 = _group_0_binding_1_fs.directional_lights[light_id_16_].shadow_depth_bias;
    vec3 _e18_3 = _group_0_binding_1_fs.directional_lights[light_id_16_].direction_to_light;
    vec3 depth_offset_1_ = (_e16_2 * _e18_3.xyz);
    vec4 offset_position_3_ = vec4(((frag_position_2_.xyz + normal_offset_1_) + depth_offset_1_), frag_position_2_.w);
    vec4 _e28 = world_to_directional_light_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_16_, cascade_index_1_, offset_position_3_);
    if ((_e28.w == 0.0)) {
        return 1.0;
    }
    uint _e33_1 = _group_0_binding_1_fs.directional_lights[light_id_16_].depth_texture_base_index;
    int array_index_8_ = int((_e33_1 + cascade_index_1_));
    float texel_size_5_ = _group_0_binding_1_fs.directional_lights[light_id_16_].cascades[cascade_index_1_].texel_size;
    float _e39_1 = _group_0_binding_1_fs.directional_lights[light_id_16_].soft_shadow_size;
    if ((_e39_1 > 0.0)) {
        float _e45_ = _group_0_binding_1_fs.directional_lights[light_id_16_].soft_shadow_size;
        float _e47 = sample_shadow_map_pcssX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(_e28.xy, _e28.z, array_index_8_, frag_coord_xy_8_, texel_size_5_, _e45_);
        return _e47;
    }
    float _e50 = sample_shadow_mapX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5PXGYLNOBWGS3THX(_e28.xy, _e28.z, array_index_8_, frag_coord_xy_8_, texel_size_5_);
    return _e50;
}

float fetch_directional_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(uint light_id_17_, vec4 frag_position_3_, vec3 surface_normal_3_, float view_z_4_, vec2 frag_coord_xy_9_) {
    float shadow = 0.0;
    uint _e9 = get_cascade_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_17_, view_z_4_);
    uint _e7_1 = _group_0_binding_1_fs.directional_lights[light_id_17_].num_cascades;
    if ((_e9 >= _e7_1)) {
        return 1.0;
    }
    float _e14 = sample_directional_cascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_17_, _e9, frag_position_3_, surface_normal_3_, frag_coord_xy_9_);
    shadow = _e14;
    uint next_cascade_index = (_e9 + 1u);
    uint _e18_4 = _group_0_binding_1_fs.directional_lights[light_id_17_].num_cascades;
    if ((next_cascade_index < _e18_4)) {
        float this_far_bound = _group_0_binding_1_fs.directional_lights[light_id_17_].cascades[_e9].far_bound;
        float _e25_1 = _group_0_binding_1_fs.directional_lights[light_id_17_].cascades_overlap_proportion;
        float next_near_bound = ((1.0 - _e25_1) * this_far_bound);
        if ((-(view_z_4_) >= next_near_bound)) {
            float _e31 = sample_directional_cascadeX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(light_id_17_, next_cascade_index, frag_position_3_, surface_normal_3_, frag_coord_xy_9_);
            float _e32_2 = shadow;
            shadow = mix(_e32_2, _e31, ((-(view_z_4_) - next_near_bound) / (this_far_bound - next_near_bound)));
        }
    }
    float _e38_2 = shadow;
    return _e38_2;
}

vec3 EnvBRDFApproxX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3 F0_1_, vec2 F_ab_1_) {
    return ((F0_1_ * F_ab_1_.x) + vec3(F_ab_1_.y));
}

vec3 ambient_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2MFWWE2LFNZ2AX(vec4 world_position, vec3 world_normal, vec3 V_3_, float NdotV_2_, vec3 diffuse_color, vec3 specular_color, float perceptual_roughness_1_, vec3 occlusion) {
    vec2 _e9 = F_ABX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(1.0, NdotV_2_);
    vec3 _e10 = EnvBRDFApproxX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(diffuse_color, _e9);
    vec2 _e11 = F_ABX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(perceptual_roughness_1_, NdotV_2_);
    vec3 _e12 = EnvBRDFApproxX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(specular_color, _e11);
    float specular_occlusion_1_ = clamp(dot(specular_color, vec3(16.5)), 0.0, 1.0);
    vec4 _e18_5 = _group_0_binding_1_fs.ambient_color;
    return (((_e10 + (_e12 * specular_occlusion_1_)) * _e18_5.xyz) * occlusion);
}

vec3 powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(vec3 color_1_, float power) {
    return (pow(abs(color_1_), vec3(power)) * sign(color_1_));
}

vec3 screen_space_ditherX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec2 frag_coord_1_) {
    vec3 dither = vec3(0.0);
    dither = vec3(dot(vec2(171.0, 231.0), frag_coord_1_)).xxx;
    vec3 _e8_4 = dither;
    dither = fract((_e8_4.xyz / vec3(103.0, 71.0, 97.0)));
    vec3 _e16_3 = dither;
    return ((_e16_3 - vec3(0.5)) / vec3(255.0));
}

vec3 convertOpenDomainToNormalizedLog2_X_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 color_2_, float minimum_ev, float maximum_ev) {
    vec3 normalized_color = vec3(0.0);
    normalized_color = max(vec3(0.0), color_2_);
    vec3 _e5_1 = normalized_color;
    vec3 _e6_5 = normalized_color;
    vec3 _e10_2 = normalized_color;
    normalized_color = mix(_e5_1, (vec3(1.525878e-5) + _e6_5), lessThan(_e10_2, vec3(3.051757e-5)));
    vec3 _e18_6 = normalized_color;
    normalized_color = clamp(log2((_e18_6 / vec3(0.18))), vec3(minimum_ev), vec3(maximum_ev));
    float total_exposure = (maximum_ev - minimum_ev);
    vec3 _e26_1 = normalized_color;
    return ((_e26_1 - vec3(minimum_ev)) / vec3(total_exposure));
}

vec3 applyAgXLogX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 Image) {
    vec3 prepared_image = vec3(0.0);
    prepared_image = max(vec3(0.0), Image);
    vec3 _e5_2 = prepared_image;
    float r_1_ = dot(_e5_2, vec3(0.84247905, 0.0784336, 0.07922375));
    vec3 _e11_2 = prepared_image;
    float g = dot(_e11_2, vec3(0.04232824, 0.87846863, 0.07916613));
    vec3 _e17_1 = prepared_image;
    float b_3_ = dot(_e17_1, vec3(0.04237565, 0.0784336, 0.879143));
    prepared_image = vec3(r_1_, g, b_3_);
    vec3 _e24_2 = prepared_image;
    vec3 _e27 = convertOpenDomainToNormalizedLog2_X_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e24_2, -10.0, 6.5);
    prepared_image = _e27;
    vec3 _e28_2 = prepared_image;
    prepared_image = clamp(_e28_2, vec3(0.0), vec3(1.0));
    vec3 _e34_ = prepared_image;
    return _e34_;
}

vec3 sample_current_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 p_1_) {
    vec4 _e4_1 = textureLod(_group_0_binding_18_fs, vec3(p_1_), 0.0);
    return _e4_1.xyz;
}

vec3 applyLUT3DX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 Image_1_, float block_size) {
    vec3 _e10 = sample_current_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(((Image_1_ * ((block_size - 1.0) / block_size)) + vec3((0.5 / block_size))));
    return _e10.xyz;
}

float tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 v) {
    return dot(v, vec3(0.2126, 0.7152, 0.0722));
}

vec3 saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 color_3_, float saturationAmount) {
    float _e2 = tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(color_3_);
    return mix(vec3(_e2), color_3_, vec3(saturationAmount));
}

vec4 tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec4 in_1_, ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX in_color_grading) {
    vec3 color_4_ = vec3(0.0);
    ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX color_grading = ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX(mat3x3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec2(0.0), 0.0, 0.0, 0.0);
    color_4_ = max(in_1_.xyz, vec3(0.0));
    color_grading = in_color_grading;
    vec3 _e8_5 = color_4_;
    float _e12_1 = color_grading.exposure;
    vec3 _e13 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(vec3(2.0), _e12_1);
    color_4_ = (_e8_5 * _e13);
    vec3 _e15_2 = color_4_;
    vec3 _e16 = applyAgXLogX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e15_2);
    color_4_ = _e16;
    vec3 _e17_2 = color_4_;
    vec3 _e19 = applyLUT3DX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e17_2, 32.0);
    color_4_ = _e19;
    vec3 _e20_6 = color_4_;
    float _e22_1 = color_grading.post_saturation;
    vec3 _e23 = saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e20_6, _e22_1);
    color_4_ = _e23;
    vec3 _e24_3 = color_4_;
    return vec4(_e24_3, in_1_.w);
}

vec3 prepare_world_normalX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(vec3 world_normal_1_, bool double_sided, bool is_front_1_) {
    vec3 output_ = vec3(0.0);
    bool local_3_ = false;
    output_ = world_normal_1_;
    if (!(!(double_sided))) {
        local_3_ = is_front_1_;
    } else {
        local_3_ = true;
    }
    bool _e9_3 = local_3_;
    vec3 _e15_3 = output_;
    output_ = (((float(_e9_3) * 2.0) - 1.0) * _e15_3);
    vec3 _e17_3 = output_;
    return _e17_3;
}

vec3 calculate_viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(vec4 world_position_1_, bool is_orthographic_3_) {
    vec3 V_4_ = vec3(0.0);
    if (is_orthographic_3_) {
        float _e5_3 = _group_0_binding_0_fs.clip_from_world[0][2];
        float _e10_3 = _group_0_binding_0_fs.clip_from_world[1][2];
        float _e15_4 = _group_0_binding_0_fs.clip_from_world[2][2];
        V_4_ = normalize(vec3(_e5_3, _e10_3, _e15_4));
    } else {
        vec3 _e22_2 = _group_0_binding_0_fs.world_position;
        V_4_ = normalize((_e22_2.xyz - world_position_1_.xyz));
    }
    vec3 _e27_3 = V_4_;
    return _e27_3;
}

PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX pbr_input_from_vertex_outputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOJQWO3LFNZ2AX(VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX in_2_, bool is_front_2_, bool double_sided_1_) {
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX pbr_input_2_ = PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(vec4(0.0), vec4(0.0), vec4(0.0), mat3x3(0.0), vec3(0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vec2(0.0), 0u, 0.0, 0.0, 0.0, 0.0, 0u, 0u), vec3(0.0), 0.0, vec4(0.0), vec4(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), 0.0, vec3(0.0), vec3(0.0), false, 0u);
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e4 = pbr_input_newX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX();
    pbr_input_2_ = _e4;
    uint _e8_6 = _group_2_binding_0_fs[in_2_.instance_index].flags;
    pbr_input_2_.flags = _e8_6;
    float _e14_1 = _group_0_binding_0_fs.clip_from_view[3][3];
    pbr_input_2_.is_orthographic = (_e14_1 == 1.0);
    bool _e20_7 = pbr_input_2_.is_orthographic;
    vec3 _e22 = calculate_viewX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(in_2_.world_position, _e20_7);
    pbr_input_2_.V = _e22;
    pbr_input_2_.frag_coord = in_2_.position;
    pbr_input_2_.world_position = in_2_.world_position;
    pbr_input_2_.material.base_color = in_2_.color;
    vec3 _e32 = prepare_world_normalX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(in_2_.world_normal, double_sided_1_, is_front_2_);
    pbr_input_2_.world_normal = _e32;
    vec3 _e36_2 = pbr_input_2_.world_normal;
    pbr_input_2_.N = normalize(_e36_2);
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e38_3 = pbr_input_2_;
    return _e38_3;
}

PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX pbr_input_from_standard_materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOJQWO3LFNZ2AX(VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX in_3_, bool is_front_3_) {
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX pbr_input_3_ = PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(vec4(0.0), vec4(0.0), vec4(0.0), mat3x3(0.0), vec3(0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vec2(0.0), 0u, 0.0, 0.0, 0.0, 0.0, 0u, 0u), vec3(0.0), 0.0, vec4(0.0), vec4(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), 0.0, vec3(0.0), vec3(0.0), false, 0u);
    SampleBiasX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX bias = SampleBiasX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(0.0);
    vec2 uv = vec2(0.0);
    vec2 uv_b = vec2(0.0);
    vec4 emissive = vec4(0.0);
    float metallic = 0.0;
    float perceptual_roughness_2_ = 0.0;
    float specular_transmission = 0.0;
    float thickness = 0.0;
    float diffuse_transmission = 0.0;
    vec3 diffuse_occlusion = vec3(1.0);
    float specular_occlusion = 1.0;
    uint _e7_2 = _group_2_binding_0_fs[in_3_.instance_index].material_and_lightmap_bind_group_slot;
    uint slot = (_e7_2 & 65535u);
    uint flags = _group_3_binding_0_fs.flags;
    vec4 base_color_2_ = _group_3_binding_0_fs.base_color;
    uint deferred_lighting_pass_id = _group_3_binding_0_fs.deferred_lighting_pass_id;
    float alpha_cutoff = _group_3_binding_0_fs.alpha_cutoff;
    bool double_sided_2_ = ((flags & STANDARD_MATERIAL_FLAGS_DOUBLE_SIDED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u);
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e40 = pbr_input_from_vertex_outputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOJQWO3LFNZ2AX(in_3_, is_front_3_, double_sided_2_);
    pbr_input_3_ = _e40;
    pbr_input_3_.material.flags = flags;
    vec4 _e33_2 = pbr_input_3_.material.base_color;
    pbr_input_3_.material.base_color = (_e33_2 * base_color_2_);
    pbr_input_3_.material.deferred_lighting_pass_id = deferred_lighting_pass_id;
    vec3 _e38_4 = pbr_input_3_.N;
    vec3 _e40_ = pbr_input_3_.V;
    float NdotV_6_ = max(dot(_e38_4, _e40_), 0.0001);
    float _e48_ = _group_0_binding_0_fs.mip_bias;
    bias.mip_bias = _e48_;
    mat3x3 uv_transform = _group_3_binding_0_fs.uv_transform;
    pbr_input_3_.material.uv_transform = uv_transform;
    uv = (uv_transform * vec3(in_3_.uv, 1.0)).xy;
    vec2 _e60_3 = uv;
    uv_b = _e60_3;
    if (((flags & STANDARD_MATERIAL_FLAGS_BASE_COLOR_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u)) {
        vec4 _e68_2 = pbr_input_3_.material.base_color;
        vec2 _e71_ = uv;
        float _e73_1 = bias.mip_bias;
        vec4 _e74_2 = texture(_group_3_binding_1_fs, vec2(_e71_), _e73_1);
        pbr_input_3_.material.base_color = (_e68_2 * _e74_2);
    }
    pbr_input_3_.material.flags = flags;
    pbr_input_3_.material.alpha_cutoff = alpha_cutoff;
    if (((flags & STANDARD_MATERIAL_FLAGS_UNLIT_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) == 0u)) {
        float _e88_3 = _group_3_binding_0_fs.ior;
        pbr_input_3_.material.ior = _e88_3;
        vec4 _e93_ = _group_3_binding_0_fs.attenuation_color;
        pbr_input_3_.material.attenuation_color = _e93_;
        float _e98_ = _group_3_binding_0_fs.attenuation_distance;
        pbr_input_3_.material.attenuation_distance = _e98_;
        vec3 _e103_ = _group_3_binding_0_fs.reflectance;
        pbr_input_3_.material.reflectance = _e103_;
        vec4 _e106_1 = _group_3_binding_0_fs.emissive;
        emissive = _e106_1;
        if (((flags & STANDARD_MATERIAL_FLAGS_EMISSIVE_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u)) {
            vec4 _e112_ = emissive;
            vec2 _e116_ = uv;
            float _e118_ = bias.mip_bias;
            vec4 _e119_ = texture(_group_3_binding_3_fs, vec2(_e116_), _e118_);
            float _e123_ = emissive.w;
            emissive = vec4((_e112_.xyz * _e119_.xyz), _e123_);
        }
        vec4 _e127_ = emissive;
        pbr_input_3_.material.emissive = _e127_;
        float _e130_ = _group_3_binding_0_fs.metallic;
        metallic = _e130_;
        float _e134_ = _group_3_binding_0_fs.perceptual_roughness;
        perceptual_roughness_2_ = _e134_;
        if (((flags & STANDARD_MATERIAL_FLAGS_METALLIC_ROUGHNESS_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u)) {
            vec2 _e142_1 = uv;
            float _e144_1 = bias.mip_bias;
            vec4 metallic_roughness = texture(_group_3_binding_5_fs, vec2(_e142_1), _e144_1);
            float _e146_ = metallic;
            metallic = (_e146_ * metallic_roughness.z);
            float _e149_ = perceptual_roughness_2_;
            perceptual_roughness_2_ = (_e149_ * metallic_roughness.y);
        }
        float _e154_ = metallic;
        pbr_input_3_.material.metallic = _e154_;
        float _e157_ = perceptual_roughness_2_;
        pbr_input_3_.material.perceptual_roughness = _e157_;
        float _e162_ = _group_3_binding_0_fs.clearcoat;
        pbr_input_3_.material.clearcoat = _e162_;
        float _e167_ = _group_3_binding_0_fs.clearcoat_perceptual_roughness;
        pbr_input_3_.material.clearcoat_perceptual_roughness = _e167_;
        float _e170_ = _group_3_binding_0_fs.specular_transmission;
        specular_transmission = _e170_;
        float _e174_ = specular_transmission;
        pbr_input_3_.material.specular_transmission = _e174_;
        float _e177_ = _group_3_binding_0_fs.thickness;
        thickness = _e177_;
        float _e179_ = thickness;
        mat3x4 _e184_ = _group_2_binding_0_fs[in_3_.instance_index].world_from_local;
        vec3 _e187_ = pbr_input_3_.N;
        thickness = (_e179_ * length((transpose(_e184_) * vec4(_e187_, 0.0)).xyz));
        float _e196_ = thickness;
        pbr_input_3_.material.thickness = _e196_;
        float _e199_ = _group_3_binding_0_fs.diffuse_transmission;
        diffuse_transmission = _e199_;
        float _e203_ = diffuse_transmission;
        pbr_input_3_.material.diffuse_transmission = _e203_;
        if (((flags & STANDARD_MATERIAL_FLAGS_OCCLUSION_TEXTURE_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) != 0u)) {
            vec3 _e209_ = diffuse_occlusion;
            vec2 _e212_ = uv;
            float _e214_ = bias.mip_bias;
            vec4 _e215_ = texture(_group_3_binding_7_fs, vec2(_e212_), _e214_);
            diffuse_occlusion = (_e209_ * _e215_.x);
        }
        vec3 _e219_ = diffuse_occlusion;
        pbr_input_3_.diffuse_occlusion = _e219_;
        float _e222_ = specular_occlusion;
        pbr_input_3_.specular_occlusion = _e222_;
        vec3 _e225_ = pbr_input_3_.world_normal;
        pbr_input_3_.N = normalize(_e225_);
        vec3 _e229_ = pbr_input_3_.N;
        pbr_input_3_.clearcoat_N = _e229_;
    }
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e230_ = pbr_input_3_;
    return _e230_;
}

mat4x4 affine3_to_squareX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(mat3x4 affine) {
    return transpose(mat4x4(affine[0], affine[1], affine[2], vec4(0.0, 0.0, 0.0, 1.0)));
}

mat3x3 mat2x4_f32_to_mat3x3_unpackX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(mat2x4 a_2_, float b_1_) {
    return mat3x3(a_2_[0].xyz, vec3(a_2_[0].w, a_2_[1].xy), vec3(a_2_[1].zw, b_1_));
}

vec4 position_world_to_clipX_naga_oil_mod_XMJSXM6K7OBRHEOR2OZUWK527ORZGC3TTMZXXE3LBORUW63TTX(vec3 world_pos) {
    mat4x4 _e2_2 = _group_0_binding_0_fs.clip_from_world;
    vec4 clip_pos = (_e2_2 * vec4(world_pos, 1.0));
    return clip_pos;
}

mat4x4 get_world_from_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(uint instance_index) {
    mat3x4 _e4_2 = _group_2_binding_0_fs[instance_index].world_from_local;
    mat4x4 _e5 = affine3_to_squareX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e4_2);
    return _e5;
}

vec3 calculate_diffuse_colorX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(vec3 base_color, float metallic_1_, float specular_transmission_1_, float diffuse_transmission_1_) {
    return (((base_color * (1.0 - metallic_1_)) * (1.0 - specular_transmission_1_)) * (1.0 - diffuse_transmission_1_));
}

vec3 calculate_F0_dielectricX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(vec3 reflectance) {
    return ((0.16 * reflectance) * reflectance);
}

vec3 calculate_F0X_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(vec3 base_color_1_, float metallic_2_, vec3 reflectance_1_) {
    vec3 _e3 = calculate_F0_dielectricX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(reflectance_1_);
    return mix(_e3, base_color_1_, metallic_2_);
}

vec4 apply_pbr_lightingX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX in_4_) {
    vec4 output_color_1_ = vec4(0.0);
    vec3 direct_light = vec3(0.0);
    vec3 transmitted_light = vec3(0.0);
    LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX lighting_input = LightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(LayerLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX[1](LayerLightingInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(vec3(0.0), vec3(0.0), 0.0, 0.0, 0.0)), vec3(0.0), vec3(0.0), vec3(0.0), 0.0, vec3(0.0), vec3(0.0), vec2(0.0));
    ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX clusterable_object_index_ranges_1_ = ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(0u, 0u, 0u, 0u, 0u, 0u);
    uint i_1_ = 0u;
    float shadow_1_ = 0.0;
    bool local_4_ = false;
    uint i_2_ = 0u;
    float shadow_2_ = 0.0;
    bool local_5_ = false;
    uint i_3_ = 0u;
    float shadow_3_ = 0.0;
    bool local_6_ = false;
    vec3 light_contrib = vec3(0.0);
    vec3 indirect_light = vec3(0.0);
    bool found_diffuse_indirect = false;
    vec3 specular_transmitted_environment_light = vec3(0.0);
    vec3 emissive_light = vec3(0.0);
    output_color_1_ = in_4_.material.base_color;
    vec4 emissive_1_ = in_4_.material.emissive;
    float metallic_3_ = in_4_.material.metallic;
    float perceptual_roughness_3_ = in_4_.material.perceptual_roughness;
    float _e36 = perceptualRoughnessToRoughnessX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(perceptual_roughness_3_);
    float ior = in_4_.material.ior;
    float thickness_1_ = in_4_.material.thickness;
    vec3 reflectance_2_ = in_4_.material.reflectance;
    float diffuse_transmission_2_ = in_4_.material.diffuse_transmission;
    float specular_transmission_2_ = in_4_.material.specular_transmission;
    vec3 specular_transmissive_color = (specular_transmission_2_ * in_4_.material.base_color.xyz);
    vec3 diffuse_occlusion_1_ = in_4_.diffuse_occlusion;
    float specular_occlusion_2_ = in_4_.specular_occlusion;
    float NdotV_7_ = max(dot(in_4_.N, in_4_.V), 0.0001);
    vec3 R_1_ = reflect(-(in_4_.V), in_4_.N);
    vec4 _e40_1 = output_color_1_;
    vec3 _e64 = calculate_diffuse_colorX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(_e40_1.xyz, metallic_3_, specular_transmission_2_, diffuse_transmission_2_);
    vec4 _e43_3 = output_color_1_;
    vec3 diffuse_transmissive_color = (((_e43_3.xyz * (1.0 - metallic_3_)) * (1.0 - specular_transmission_2_)) * diffuse_transmission_2_);
    vec4 diffuse_transmissive_lobe_world_position = (in_4_.world_position - (vec4(in_4_.world_normal, 0.0) * thickness_1_));
    vec4 _e58_5 = output_color_1_;
    vec3 _e82 = calculate_F0X_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(_e58_5.xyz, metallic_3_, reflectance_2_);
    vec2 _e83 = F_ABX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(perceptual_roughness_3_, NdotV_7_);
    lighting_input.layers[0].NdotV = NdotV_7_;
    lighting_input.layers[0].N = in_4_.N;
    lighting_input.layers[0].R = R_1_;
    lighting_input.layers[0].perceptual_roughness = perceptual_roughness_3_;
    lighting_input.layers[0].roughness = _e36;
    lighting_input.P = in_4_.world_position.xyz;
    lighting_input.V = in_4_.V;
    lighting_input.diffuse_color = _e64;
    lighting_input.metallic = metallic_3_;
    vec3 _e107 = calculate_F0_dielectricX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(reflectance_2_);
    lighting_input.F0_dielectric = _e107;
    vec4 _e89_ = output_color_1_;
    lighting_input.F0_metallic = _e89_.xyz;
    lighting_input.F_ab = _e83;
    float _e96_ = _group_0_binding_0_fs.view_from_world[0][2];
    float _e101_ = _group_0_binding_0_fs.view_from_world[1][2];
    float _e106_2 = _group_0_binding_0_fs.view_from_world[2][2];
    float _e111_ = _group_0_binding_0_fs.view_from_world[3][2];
    float view_z_5_ = dot(vec4(_e96_, _e101_, _e106_2, _e111_), in_4_.world_position);
    uint _e139 = view_fragment_cluster_indexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(in_4_.frag_coord.xy, view_z_5_, in_4_.is_orthographic);
    ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX _e140 = unpack_clusterable_object_index_rangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e139);
    clusterable_object_index_ranges_1_ = _e140;
    uint _e122_ = clusterable_object_index_ranges_1_.first_point_light_index_offset;
    i_1_ = _e122_;
    bool loop_init_1 = true;
    while(true) {
        if (!loop_init_1) {
            uint _e163_ = i_1_;
            i_1_ = (_e163_ + 1u);
        }
        loop_init_1 = false;
        uint _e124_1 = i_1_;
        uint _e126_1 = clusterable_object_index_ranges_1_.first_spot_light_index_offset;
        if ((_e124_1 < _e126_1)) {
        } else {
            break;
        }
        {
            uint _e128_ = i_1_;
            uint _e148 = get_clusterable_object_idX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e128_);
            shadow_1_ = 1.0;
            if (((in_4_.flags & MESH_FLAGS_SHADOW_RECEIVER_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX) != 0u)) {
                uint _e141_ = _group_0_binding_8_fs.data[_e148].flags;
                local_4_ = ((_e141_ & POINT_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u);
            } else {
                local_4_ = false;
            }
            bool _e149_1 = local_4_;
            if (_e149_1) {
                float _e170 = fetch_point_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(_e148, in_4_.world_position, in_4_.world_normal, in_4_.frag_coord.xy);
                shadow_1_ = _e170;
            }
            vec3 _e173 = point_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(_e148, lighting_input, true, true);
            vec3 _e159_ = direct_light;
            float _e160_1 = shadow_1_;
            direct_light = (_e159_ + (_e173 * _e160_1));
        }
    }
    uint _e167_1 = clusterable_object_index_ranges_1_.first_spot_light_index_offset;
    i_2_ = _e167_1;
    bool loop_init_2 = true;
    while(true) {
        if (!loop_init_2) {
            uint _e211_ = i_2_;
            i_2_ = (_e211_ + 1u);
        }
        loop_init_2 = false;
        uint _e169_ = i_2_;
        uint _e171_ = clusterable_object_index_ranges_1_.first_reflection_probe_index_offset;
        if ((_e169_ < _e171_)) {
        } else {
            break;
        }
        {
            uint _e173_ = i_2_;
            uint _e188 = get_clusterable_object_idX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e173_);
            shadow_2_ = 1.0;
            if (((in_4_.flags & MESH_FLAGS_SHADOW_RECEIVER_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX) != 0u)) {
                uint _e186_ = _group_0_binding_8_fs.data[_e188].flags;
                local_5_ = ((_e186_ & POINT_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u);
            } else {
                local_5_ = false;
            }
            bool _e194_ = local_5_;
            if (_e194_) {
                float _e201_ = _group_0_binding_8_fs.data[_e188].shadow_map_near_z;
                float _e215 = fetch_spot_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(_e188, in_4_.world_position, in_4_.world_normal, _e201_, in_4_.frag_coord.xy);
                shadow_2_ = _e215;
            }
            vec3 _e217 = spot_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(_e188, lighting_input, true);
            vec3 _e207_ = direct_light;
            float _e208_ = shadow_2_;
            direct_light = (_e207_ + (_e217 * _e208_));
        }
    }
    uint n_directional_lights = _group_0_binding_1_fs.n_directional_lights;
    bool loop_init_3 = true;
    while(true) {
        if (!loop_init_3) {
            uint _e260_ = i_3_;
            i_3_ = (_e260_ + 1u);
        }
        loop_init_3 = false;
        uint _e218_ = i_3_;
        if ((_e218_ < n_directional_lights)) {
        } else {
            break;
        }
        {
            uint _e222_1 = i_3_;
            shadow_3_ = 1.0;
            if (((in_4_.flags & MESH_FLAGS_SHADOW_RECEIVER_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX) != 0u)) {
                uint _e233_ = i_3_;
                uint _e236_ = _group_0_binding_1_fs.directional_lights[_e233_].flags;
                local_6_ = ((_e236_ & DIRECTIONAL_LIGHT_FLAGS_SHADOWS_ENABLED_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OZUWK527OR4XAZLTX) != 0u);
            } else {
                local_6_ = false;
            }
            bool _e244_ = local_6_;
            if (_e244_) {
                uint _e245_ = i_3_;
                float _e257 = fetch_directional_shadowX_naga_oil_mod_XMJSXM6K7OBRHEOR2ONUGCZDPO5ZQX(_e245_, in_4_.world_position, in_4_.world_normal, view_z_5_, in_4_.frag_coord.xy);
                shadow_3_ = _e257;
            }
            uint _e251_ = i_3_;
            vec3 _e260 = directional_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2NRUWO2DUNFXGOX(_e251_, lighting_input, true);
            light_contrib = _e260;
            vec3 _e255_ = direct_light;
            vec3 _e256_ = light_contrib;
            float _e257_ = shadow_3_;
            direct_light = (_e255_ + (_e256_ * _e257_));
        }
    }
    if (true) {
        vec3 _e265_ = indirect_light;
        vec3 _e274 = ambient_lightX_naga_oil_mod_XMJSXM6K7OBRHEOR2MFWWE2LFNZ2AX(in_4_.world_position, in_4_.N, in_4_.V, NdotV_7_, _e64, _e82, perceptual_roughness_3_, diffuse_occlusion_1_);
        indirect_light = (_e265_ + _e274);
    }
    float _e273_ = output_color_1_.w;
    emissive_light = (emissive_1_.xyz * _e273_);
    vec3 _e276_ = emissive_light;
    float _e279_ = _group_0_binding_0_fs.exposure;
    emissive_light = (_e276_ * mix(1.0, _e279_, emissive_1_.w));
    float _e287_ = _group_0_binding_0_fs.exposure;
    vec3 _e288_ = transmitted_light;
    vec3 _e289_ = direct_light;
    vec3 _e291_ = indirect_light;
    vec3 _e294_ = emissive_light;
    float _e297_ = output_color_1_.w;
    output_color_1_ = vec4(((_e287_ * ((_e288_ + _e289_) + _e291_)) + _e294_), _e297_);
    vec4 _e299_ = output_color_1_;
    ClusterableObjectIndexRangesX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX _e301_ = clusterable_object_index_ranges_1_;
    vec4 _e305 = cluster_debug_visualizationX_naga_oil_mod_XMJSXM6K7OBRHEOR2MNWHK43UMVZGKZC7MZXXE53BOJSAX(_e299_, view_z_5_, in_4_.is_orthographic, _e301_, _e139);
    output_color_1_ = _e305;
    vec4 _e303_ = output_color_1_;
    return _e303_;
}

vec4 main_pass_post_lighting_processingX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX pbr_input_4_, vec4 input_color_1_) {
    vec4 output_color_2_ = vec4(0.0);
    vec3 output_rgb = vec3(0.0);
    output_color_2_ = input_color_1_;
    vec4 _e2_3 = output_color_2_;
    ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _e5_4 = _group_0_binding_0_fs.color_grading;
    vec4 _e8 = tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e2_3, _e5_4);
    output_color_2_ = _e8;
    vec4 _e7_3 = output_color_2_;
    output_rgb = _e7_3.xyz;
    vec3 _e10_4 = output_rgb;
    vec3 _e13 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e10_4, 0.45454547);
    output_rgb = _e13;
    vec3 _e14_2 = output_rgb;
    vec3 _e17 = screen_space_ditherX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(pbr_input_4_.frag_coord.xy);
    output_rgb = (_e14_2 + _e17);
    vec3 _e19_2 = output_rgb;
    vec3 _e21 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e19_2, 2.2);
    output_rgb = _e21;
    vec3 _e22_3 = output_rgb;
    float _e24_4 = output_color_2_.w;
    output_color_2_ = vec4(_e22_3, _e24_4);
    vec4 _e26_2 = output_color_2_;
    return _e26_2;
}

float hash3_(vec3 p_2_) {
    vec3 q = fract(((p_2_ * 0.3183099) + vec3(0.1, 0.2, 0.3)));
    vec3 r_2_ = (q + vec3(dot(q, (q.yzx + vec3(19.19)))));
    return fract(((r_2_.x + r_2_.y) * r_2_.z));
}

float vnoise(vec3 p_3_) {
    vec3 i_4_ = floor(p_3_);
    vec3 f = fract(p_3_);
    vec3 u = ((f * f) * (vec3(3.0) - (2.0 * f)));
    float _e15 = hash3_((i_4_ + vec3(0.0, 0.0, 0.0)));
    float _e21 = hash3_((i_4_ + vec3(1.0, 0.0, 0.0)));
    float _e27 = hash3_((i_4_ + vec3(0.0, 1.0, 0.0)));
    float _e33 = hash3_((i_4_ + vec3(1.0, 1.0, 0.0)));
    float _e39 = hash3_((i_4_ + vec3(0.0, 0.0, 1.0)));
    float _e45 = hash3_((i_4_ + vec3(1.0, 0.0, 1.0)));
    float _e51 = hash3_((i_4_ + vec3(0.0, 1.0, 1.0)));
    float _e57 = hash3_((i_4_ + vec3(1.0, 1.0, 1.0)));
    float x00_ = mix(_e15, _e21, u.x);
    float x10_ = mix(_e27, _e33, u.x);
    float x01_ = mix(_e39, _e45, u.x);
    float x11_ = mix(_e51, _e57, u.x);
    return mix(mix(x00_, x10_, u.y), mix(x01_, x11_, u.y), u.z);
}

void main() {
    VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX in_ = VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX(gl_FragCoord, _vs2fs_location0, _vs2fs_location1, _vs2fs_location2, _vs2fs_location5, _vs2fs_location6);
    bool is_front = gl_FrontFacing;
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX pbr_input = PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX(vec4(0.0), vec4(0.0), vec4(0.0), mat3x3(0.0), vec3(0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, vec2(0.0), 0u, 0.0, 0.0, 0.0, 0.0, 0u, 0u), vec3(0.0), 0.0, vec4(0.0), vec4(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), 0.0, vec3(0.0), vec3(0.0), false, 0u);
    float lum = 1.0;
    float rough_adj = 0.0;
    vec3 rgb = vec3(0.0);
    bool local = false;
    FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX out_ = FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX(vec4(0.0));
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e10 = pbr_input_from_standard_materialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOJQWO3LFNZ2AX(in_, is_front);
    pbr_input = _e10;
    mat4x4 _e12 = get_world_from_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(in_.instance_index);
    mat3x3 m_1_ = mat3x3(_e12[0].xyz, _e12[1].xyz, _e12[2].xyz);
    vec3 origin = _e12[3].xyz;
    vec3 lp = (transpose(m_1_) * (in_.world_position.xyz - origin));
    vec3 obj = vec3((lp.x / max(dot(m_1_[0], m_1_[0]), 1e-5)), (lp.y / max(dot(m_1_[1], m_1_[1]), 1e-5)), (lp.z / max(dot(m_1_[2], m_1_[2]), 1e-5)));
    float surf = in_.color.w;
    float strength = _group_3_binding_100_fs.params.x;
    float relief = _group_3_binding_100_fs.params.y;
    float spec_lift = _group_3_binding_100_fs.params.z;
    vec4 _e60_4 = pbr_input.material.base_color;
    rgb = _e60_4.xyz;
    if (!((surf < 0.14))) {
        local = (surf > 0.965);
    } else {
        local = true;
    }
    bool _e71_1 = local;
    if (_e71_1) {
        float _e76 = vnoise((obj * 9.0));
        float n_1_ = (_e76 - 0.5);
        float _e81 = vnoise((obj * 38.0));
        float pore = ((_e81 - 0.5) * 0.4);
        lum = (1.0 + ((n_1_ + pore) * strength));
        rough_adj = 0.05;
    } else {
        if ((surf < 0.28)) {
            vec3 p_4_ = (obj * vec3(26.0, 7.0, 26.0));
            float _e98 = vnoise(p_4_);
            float _e101 = vnoise((p_4_ * 2.3));
            float f_1_ = ((_e98 - 0.5) + ((_e101 - 0.5) * 0.5));
            lum = (1.0 + ((f_1_ * strength) * 1.4));
            rough_adj = 0.12;
        } else {
            if ((surf < 0.43)) {
                vec3 cell = floor((obj * 16.0));
                float _e120 = hash3_(cell);
                float edge = (fract((obj.x * 16.0)) * fract((obj.y * 16.0)));
                lum = ((1.0 + (((_e120 - 0.5) * strength) * 1.2)) - ((1.0 - smoothstep(0.05, 0.2, edge)) * strength));
                rough_adj = -0.05;
            } else {
                if ((surf < 0.57)) {
                    float _e149 = vnoise((obj * 8.0));
                    float _e152 = vnoise((obj * 22.0));
                    float n_2_ = ((_e149 - 0.5) + ((_e152 - 0.5) * 0.5));
                    float _e162 = vnoise((obj * 40.0));
                    float spk = step(0.92, _e162);
                    lum = ((1.0 + ((n_2_ * strength) * 1.3)) + ((spk * strength) * 2.0));
                    rough_adj = 0.18;
                } else {
                    if ((surf < 0.71)) {
                        float _e179 = vnoise((obj * 30.0));
                        float n_3_ = (_e179 - 0.5);
                        lum = (1.0 + ((n_3_ * strength) * 0.55));
                        rough_adj = -0.18;
                        pbr_input.material.metallic = clamp(spec_lift, 0.0, 1.0);
                    } else {
                        if ((surf < 0.86)) {
                            float weave = ((sin((obj.x * 120.0)) * sin((obj.y * 120.0))) * 0.5);
                            lum = (1.0 + ((weave * strength) * 0.6));
                            rough_adj = 0.1;
                        } else {
                            float _e214 = vnoise((obj * 24.0));
                            float n_4_ = (_e214 - 0.5);
                            lum = (1.0 + ((n_4_ * strength) * 0.7));
                            rough_adj = -0.05;
                        }
                    }
                }
            }
        }
    }
    vec3 _e223_ = rgb;
    float _e224_ = lum;
    rgb = (_e223_ * _e224_);
    vec3 _e228_ = rgb;
    pbr_input.material.base_color = vec4(max(_e228_, vec3(0.0)), 1.0);
    float _e238_ = pbr_input.material.perceptual_roughness;
    float _e239_ = rough_adj;
    pbr_input.material.perceptual_roughness = clamp((_e238_ + _e239_), 0.05, 1.0);
    if ((relief > 0.0)) {
        float _e253 = vnoise(((obj * 18.0) + vec3(0.02, 0.0, 0.0)));
        float _e261 = vnoise(((obj * 18.0) - vec3(0.02, 0.0, 0.0)));
        float dx = (_e253 - _e261);
        float _e270 = vnoise(((obj * 18.0) + vec3(0.0, 0.0, 0.02)));
        float _e278 = vnoise(((obj * 18.0) - vec3(0.0, 0.0, 0.02)));
        float dz = (_e270 - _e278);
        vec3 _e279_1 = pbr_input.N;
        pbr_input.N = normalize((_e279_1 + (((m_1_ * vec3(dx, 0.0, dz)) * relief) * 0.5)));
    }
    uint _e290_ = pbr_input.material.flags;
    if (((_e290_ & STANDARD_MATERIAL_FLAGS_UNLIT_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX) == 0u)) {
        PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e297_1 = pbr_input;
        vec4 _e299 = apply_pbr_lightingX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(_e297_1);
        out_.color = _e299;
    } else {
        vec4 _e302_ = pbr_input.material.base_color;
        out_.color = _e302_;
    }
    PbrInputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _e304_ = pbr_input;
    vec4 _e306_ = out_.color;
    vec4 _e308 = main_pass_post_lighting_processingX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3GOVXGG5DJN5XHGX(_e304_, _e306_);
    out_.color = _e308;
    FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX _e308_ = out_;
    _fs2p_location0 = _e308_.color;
    return;
}
