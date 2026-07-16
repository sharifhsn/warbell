#version 460 core
struct VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV62LPX {
    vec4 position;
    vec2 uv;
    vec4 world_position;
    float unclipped_depth;
    uint instance_index;
    vec4 color;
};
struct FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV62LPX {
    float frag_depth;
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
layout(std140, binding = 0) uniform StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX_block_0Fragment { StandardMaterialX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3UPFYGK4YX _group_3_binding_0_fs; };

layout(location = 0) smooth in vec2 _vs2fs_location0;
layout(location = 4) smooth in vec4 _vs2fs_location4;
layout(location = 6) smooth in float _vs2fs_location6;
layout(location = 7) flat in uint _vs2fs_location7;
layout(location = 8) smooth in vec4 _vs2fs_location8;

void prepass_alpha_discardX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3QOJSXAYLTONPWM5LOMN2GS33OOMX(VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV62LPX in_1_) {
    return;
}

void main() {
    VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV62LPX in_ = VertexOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV62LPX(gl_FragCoord, _vs2fs_location0, _vs2fs_location4, _vs2fs_location6, _vs2fs_location7, _vs2fs_location8);
    bool is_front = gl_FrontFacing;
    FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV62LPX out_ = FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV62LPX(0.0);
    uint flags = _group_3_binding_0_fs.flags;
    mat3x3 uv_transform = _group_3_binding_0_fs.uv_transform;
    prepass_alpha_discardX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBRHEX3QOJSXAYLTONPWM5LOMN2GS33OOMX(in_);
    out_.frag_depth = in_.unclipped_depth;
    FragmentOutputX_naga_oil_mod_XMJSXM6K7OBRHEOR2OBZGK4DBONZV62LPX _e10_ = out_;
    gl_FragDepth = _e10_.frag_depth;
    return;
}
