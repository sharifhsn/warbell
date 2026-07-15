#version 460 core
#extension GL_ARB_shader_draw_parameters : require
struct VertexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    uint instance_index;
    vec3 position;
    vec3 normal;
    vec2 uv;
};
struct VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX {
    vec4 position;
    vec4 world_position;
    vec3 world_normal;
    vec2 uv;
    uint instance_index;
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
struct PreviousViewUniformsX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV6YTJNZSGS3THOMX {
    mat4x4 view_from_world;
    mat4x4 clip_from_world;
    mat4x4 clip_from_view;
    mat4x4 world_from_clip;
    mat4x4 view_from_clip;
};
const uint MESH_FLAGS_SIGN_DETERMINANT_MODEL_3X3_BITX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX = 2147483648u;

layout(std140, binding = 2) uniform type_19_block_0Vertex { MeshX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7OR4XAZLTX _group_2_binding_0_vs[93]; };

layout(std140, binding = 0) uniform ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX_block_1Vertex { ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _group_0_binding_0_vs; };

layout(location = 0) in vec3 _p2vs_location0;
layout(location = 1) in vec3 _p2vs_location1;
layout(location = 2) in vec2 _p2vs_location2;
layout(location = 0) smooth out vec4 _vs2fs_location0;
layout(location = 1) smooth out vec3 _vs2fs_location1;
layout(location = 2) smooth out vec2 _vs2fs_location2;
layout(location = 6) flat out uint _vs2fs_location6;

mat4x4 affine3_to_squareX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(mat3x4 affine) {
    return transpose(mat4x4(affine[0], affine[1], affine[2], vec4(0.0, 0.0, 0.0, 1.0)));
}

mat3x3 mat2x4_f32_to_mat3x3_unpackX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(mat2x4 a, float b) {
    return mat3x3(a[0].xyz, vec3(a[0].w, a[1].xy), vec3(a[1].zw, b));
}

vec4 position_world_to_clipX_naga_oil_mod_XMJSXM6K7OBRHEOR2OZUWK527ORZGC3TTMZXXE3LBORUW63TTX(vec3 world_pos) {
    mat4x4 _e2_ = _group_0_binding_0_vs.clip_from_world;
    vec4 clip_pos = (_e2_ * vec4(world_pos, 1.0));
    return clip_pos;
}

mat4x4 get_world_from_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(uint instance_index) {
    mat3x4 _e4_ = _group_2_binding_0_vs[instance_index].world_from_local;
    mat4x4 _e5 = affine3_to_squareX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e4_);
    return _e5;
}

vec4 mesh_position_local_to_worldX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(mat4x4 world_from_local_1_, vec4 vertex_position) {
    return (world_from_local_1_ * vertex_position);
}

vec3 mesh_normal_local_to_worldX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(vec3 vertex_normal, uint instance_index_1_) {
    if (any(notEqual(vertex_normal, vec3(0.0)))) {
        mat2x4 _e9_ = _group_2_binding_0_vs[instance_index_1_].local_from_world_transpose_a;
        float _e13_ = _group_2_binding_0_vs[instance_index_1_].local_from_world_transpose_b;
        mat3x3 _e14 = mat2x4_f32_to_mat3x3_unpackX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e9_, _e13_);
        return normalize((_e14 * vertex_normal));
    } else {
        return vertex_normal;
    }
}

void main() {
    VertexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX vertex_no_morph = VertexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX((uint(gl_InstanceID) + uint(gl_BaseInstanceARB)), _p2vs_location0, _p2vs_location1, _p2vs_location2);
    VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX out_ = VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX(vec4(0.0), vec4(0.0), vec3(0.0), vec2(0.0), 0u);
    VertexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX vertex_1_ = VertexX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX(0u, vec3(0.0), vec3(0.0), vec2(0.0));
    mat4x4 world_from_local = mat4x4(0.0);
    vertex_1_ = vertex_no_morph;
    mat4x4 _e5 = get_world_from_localX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(vertex_no_morph.instance_index);
    world_from_local = _e5;
    vec3 _e8_ = vertex_1_.normal;
    vec3 _e9 = mesh_normal_local_to_worldX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(_e8_, vertex_no_morph.instance_index);
    out_.world_normal = _e9;
    mat4x4 _e12_ = world_from_local;
    vec3 _e14_ = vertex_1_.position;
    vec4 _e16 = mesh_position_local_to_worldX_naga_oil_mod_XMJSXM6K7OBRHEOR2NVSXG2C7MZ2W4Y3UNFXW44YX(_e12_, vec4(_e14_, 1.0));
    out_.world_position = _e16;
    vec4 _e20_ = out_.world_position;
    vec4 _e21 = position_world_to_clipX_naga_oil_mod_XMJSXM6K7OBRHEOR2OZUWK527ORZGC3TTMZXXE3LBORUW63TTX(_e20_.xyz);
    out_.position = _e21;
    vec2 _e25_ = vertex_1_.uv;
    out_.uv = _e25_;
    out_.instance_index = vertex_no_morph.instance_index;
    VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2MZXXE53BOJSF62LPX _e28_ = out_;
    gl_Position = _e28_.position;
    _vs2fs_location0 = _e28_.world_position;
    _vs2fs_location1 = _e28_.world_normal;
    _vs2fs_location2 = _e28_.uv;
    _vs2fs_location6 = _e28_.instance_index;
    return;
}
