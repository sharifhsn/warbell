#version 460 core
struct VertexOutput {
    vec4 position;
    vec4 world_position;
    vec3 world_normal;
    vec2 uv;
    uint instance_index;
};
struct DirectionalCascade {
    mat4x4 clip_from_world;
    float texel_size;
    float far_bound;
};
struct DirectionalLight {
    DirectionalCascade cascades[4];
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
struct RectLight {
    vec4 color;
    vec3 position;
    float width;
    vec3 right;
    float height;
    vec3 up;
    float range;
};
struct Lights {
    DirectionalLight directional_lights[10];
    vec4 ambient_color;
    uvec4 cluster_dimensions;
    vec4 cluster_factors;
    uint n_directional_lights;
    int spot_light_shadowmap_offset;
    uint ambient_light_affects_lightmapped_meshes;
    uint n_rect_lights;
    RectLight rect_lights[8];
};
struct Material {
    vec4 base_color;
};
layout(std140, binding = 0) uniform Lights_block_0Fragment { Lights _group_0_binding_1_fs; };

layout(std140, binding = 1) uniform Material_block_1Fragment { Material _group_3_binding_0_fs; };

layout(binding = 0) uniform sampler2D _group_3_binding_1_fs;

layout(location = 0) smooth in vec4 _vs2fs_location0;
layout(location = 1) smooth in vec3 _vs2fs_location1;
layout(location = 2) smooth in vec2 _vs2fs_location2;
layout(location = 6) flat in uint _vs2fs_location6;
layout(location = 0) out vec4 _fs2p_location0;

void main() {
    VertexOutput in_ = VertexOutput(gl_FragCoord, _vs2fs_location0, _vs2fs_location1, _vs2fs_location2, _vs2fs_location6);
    vec3 lighting = vec3(0.18);
    vec4 _e3 = _group_3_binding_0_fs.base_color;
    vec4 _e8 = texture(_group_3_binding_1_fs, vec2(in_.uv), 0.0);
    vec4 base = (_e3 * _e8);
    vec3 normal = normalize(in_.world_normal);
    uint _e17 = _group_0_binding_1_fs.n_directional_lights;
    if ((_e17 > 0u)) {
        DirectionalLight light = _group_0_binding_1_fs.directional_lights[0];
        float light_color_max = max(max(light.color.x, light.color.y), light.color.z);
        vec3 light_tint = (light.color.xyz / vec3(max(light_color_max, 0.0001)));
        float diffuse = max(dot(normal, normalize(light.direction_to_light)), 0.0);
        vec3 _e43 = lighting;
        lighting = (_e43 + ((light_tint * diffuse) * 0.82));
    }
    vec3 _e49 = lighting;
    _fs2p_location0 = vec4((base.xyz * _e49), base.w);
    return;
}
