#version 460 core
struct FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX {
    vec4 position;
    vec2 uv;
};
struct FragmentOutput {
    float frag_depth;
};
layout(binding = 0) uniform usampler2D _group_0_binding_0_fs;

layout(location = 0) smooth in vec2 _vs2fs_location0;

void main() {
    FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX in_ = FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX(gl_FragCoord, _vs2fs_location0);
    FragmentOutput out_ = FragmentOutput(0.0);
    uvec4 _e8_ = texelFetch(_group_0_binding_0_fs, ivec2(in_.position.xy), 0);
    out_.frag_depth = (float(_e8_.x) / 255.0);
    FragmentOutput _e13_ = out_;
    gl_FragDepth = _e13_.frag_depth;
    return;
}
