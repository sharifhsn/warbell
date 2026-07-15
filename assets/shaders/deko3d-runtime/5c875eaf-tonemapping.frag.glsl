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

vec3 convertOpenDomainToNormalizedLog2_X_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 color_1_, float minimum_ev, float maximum_ev) {
    vec3 normalized_color = vec3(0.0);
    normalized_color = max(vec3(0.0), color_1_);
    vec3 _e5_ = normalized_color;
    vec3 _e6_ = normalized_color;
    vec3 _e10_ = normalized_color;
    normalized_color = mix(_e5_, (vec3(1.525878e-5) + _e6_), lessThan(_e10_, vec3(3.051757e-5)));
    vec3 _e18_ = normalized_color;
    normalized_color = clamp(log2((_e18_ / vec3(0.18))), vec3(minimum_ev), vec3(maximum_ev));
    float total_exposure = (maximum_ev - minimum_ev);
    vec3 _e26_ = normalized_color;
    return ((_e26_ - vec3(minimum_ev)) / vec3(total_exposure));
}

vec3 applyAgXLogX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 Image) {
    vec3 prepared_image = vec3(0.0);
    prepared_image = max(vec3(0.0), Image);
    vec3 _e5_1 = prepared_image;
    float r = dot(_e5_1, vec3(0.84247905, 0.0784336, 0.07922375));
    vec3 _e11_ = prepared_image;
    float g = dot(_e11_, vec3(0.04232824, 0.87846863, 0.07916613));
    vec3 _e17_ = prepared_image;
    float b = dot(_e17_, vec3(0.04237565, 0.0784336, 0.879143));
    prepared_image = vec3(r, g, b);
    vec3 _e24_ = prepared_image;
    vec3 _e27 = convertOpenDomainToNormalizedLog2_X_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e24_, -10.0, 6.5);
    prepared_image = _e27;
    vec3 _e28_ = prepared_image;
    prepared_image = clamp(_e28_, vec3(0.0), vec3(1.0));
    vec3 _e34_ = prepared_image;
    return _e34_;
}

vec3 sample_current_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 p) {
    vec4 _e4_ = textureLod(_group_0_binding_3_fs, vec3(p), 0.0);
    return _e4_.xyz;
}

vec3 applyLUT3DX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 Image_1_, float block_size) {
    vec3 _e10 = sample_current_lutX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(((Image_1_ * ((block_size - 1.0) / block_size)) + vec3((0.5 / block_size))));
    return _e10.xyz;
}

float tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 v) {
    return dot(v, vec3(0.2126, 0.7152, 0.0722));
}

vec3 saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 color_2_, float saturationAmount) {
    float _e2 = tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(color_2_);
    return mix(vec3(_e2), color_2_, vec3(saturationAmount));
}

vec4 tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec4 in_1_, ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX in_color_grading) {
    vec3 color_3_ = vec3(0.0);
    ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX color_grading = ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX(mat3x3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec2(0.0), 0.0, 0.0, 0.0);
    color_3_ = max(in_1_.xyz, vec3(0.0));
    color_grading = in_color_grading;
    vec3 _e8_1 = color_3_;
    float _e12_ = color_grading.exposure;
    vec3 _e13 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(vec3(2.0), _e12_);
    color_3_ = (_e8_1 * _e13);
    vec3 _e15_ = color_3_;
    vec3 _e16 = applyAgXLogX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e15_);
    color_3_ = _e16;
    vec3 _e17_1 = color_3_;
    vec3 _e19 = applyLUT3DX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e17_1, 32.0);
    color_3_ = _e19;
    vec3 _e20_ = color_3_;
    float _e22_ = color_grading.post_saturation;
    vec3 _e23 = saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e20_, _e22_);
    color_3_ = _e23;
    vec3 _e24_1 = color_3_;
    return vec4(_e24_1, in_1_.w);
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
    vec3 _e20_1 = output_rgb;
    vec3 _e23 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(_e20_1.xyz, 2.2);
    output_rgb = _e23;
    vec3 _e24_2 = output_rgb;
    _fs2p_location0 = vec4(_e24_2, hdr_color.w);
    return;
}
