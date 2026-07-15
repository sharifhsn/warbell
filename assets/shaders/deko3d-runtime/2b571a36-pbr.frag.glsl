#version 460 core
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
struct FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX {
    vec4 position;
    vec2 uv;
};
layout(binding = 1) uniform sampler3D _group_0_binding_3_fs;

layout(std140, binding = 0) uniform ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX_block_0Fragment { ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _group_0_binding_0_fs; };

layout(binding = 0) uniform sampler2D _group_0_binding_1_fs;

layout(location = 0) smooth in vec2 _vs2fs_location0;
layout(location = 0) out vec4 _fs2p_location0;

vec3 powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(vec3 color, float power) {
    return (pow(abs(color), vec3(power)) * sign(color));
}

vec3 screen_space_ditherX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec2 frag_coord) {
    vec3 dither = vec3(0.0);
    dither = vec3(dot(vec2(171.0, 231.0), frag_coord)).xxx;
    vec3 _e8_ = dither;
    dither = fract((_e8_.xyz / vec3(103.0, 71.0, 97.0)));
    vec3 _e16_ = dither;
    return ((_e16_ - vec3(0.5)) / vec3(255.0));
}

vec3 sample_current_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 p) {
    vec4 _e4_ = textureLod(_group_0_binding_3_fs, vec3(p), 0.0);
    return _e4_.xyz;
}

vec3 sample_tony_mc_mapface_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 stimulus) {
    vec3 uv = vec3(0.0);
    uv = (((stimulus / (stimulus + vec3(1.0))) * 0.9791667) + vec3(0.010416667));
    vec3 _e11_ = uv;
    vec3 _e13 = sample_current_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(clamp(_e11_, vec3(0.0), vec3(1.0)));
    return _e13.xyz;
}

float tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 v) {
    return dot(v, vec3(0.2126, 0.7152, 0.0722));
}

vec3 saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 color_1_, float saturationAmount) {
    float _e2 = tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(color_1_);
    return mix(vec3(_e2), color_1_, vec3(saturationAmount));
}

vec4 tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec4 in_1_, ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX in_color_grading) {
    vec3 color_2_ = vec3(0.0);
    ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX color_grading = ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX(mat3x3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec2(0.0), 0.0, 0.0, 0.0);
    color_2_ = max(in_1_.xyz, vec3(0.0));
    color_grading = in_color_grading;
    vec3 _e8_1 = color_2_;
    float _e12_ = color_grading.exposure;
    vec3 _e13 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(vec3(2.0), _e12_);
    color_2_ = (_e8_1 * _e13);
    vec3 _e15_ = color_2_;
    vec3 _e16 = sample_tony_mc_mapface_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e15_);
    color_2_ = _e16;
    vec3 _e17_ = color_2_;
    float _e19_ = color_grading.post_saturation;
    vec3 _e20 = saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e17_, _e19_);
    color_2_ = _e20;
    vec3 _e21_ = color_2_;
    return vec4(_e21_, in_1_.w);
}

void main() {
    FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX in_ = FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX(gl_FragCoord, _vs2fs_location0);
    vec3 output_rgb = vec3(0.0);
    vec4 hdr_color = texture(_group_0_binding_1_fs, vec2(in_.uv));
    ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _e7_ = _group_0_binding_0_fs.color_grading;
    vec4 _e9 = tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(hdr_color, _e7_);
    output_rgb = _e9.xyz;
    vec3 _e11_1 = output_rgb;
    vec3 _e14 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e11_1.xyz, 0.45454547);
    output_rgb = _e14;
    vec3 _e15_1 = output_rgb;
    vec3 _e18 = screen_space_ditherX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(in_.position.xy);
    output_rgb = (_e15_1 + _e18);
    vec3 _e20_ = output_rgb;
    vec3 _e23 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e20_.xyz, 2.2);
    output_rgb = _e23;
    vec3 _e24_ = output_rgb;
    _fs2p_location0 = vec4(_e24_, hdr_color.w);
    return;
}
