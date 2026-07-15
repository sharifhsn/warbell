#version 460 core
struct FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX {
    vec4 position;
    vec2 uv;
};
layout(binding = 0) uniform sampler2D _group_0_binding_0_fs;

layout(location = 0) smooth in vec2 _vs2fs_location0;
layout(location = 0) out vec4 _fs2p_location0;

void main() {
    FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX in_ = FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX(gl_FragCoord, _vs2fs_location0);
    vec4 color = vec4(0.0);
    vec4 _e4_ = texture(_group_0_binding_0_fs, vec2(in_.uv));
    color = _e4_;
    vec4 _e6_ = color;
    _fs2p_location0 = _e6_;
    return;
}
