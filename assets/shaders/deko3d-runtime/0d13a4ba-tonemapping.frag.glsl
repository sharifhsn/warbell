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
const float LEVEL_MARGINX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X = 0.1;
const float LEVEL_MARGIN_DIVX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X = 5.0;

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

float tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 v) {
    return dot(v, vec3(0.2126, 0.7152, 0.0722));
}

vec3 sectional_color_gradingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 in_1_, inout ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX color_grading) {
    vec3 color_1_ = vec3(0.0);
    vec3 levels = vec3(0.0);
    color_1_ = in_1_;
    float _e5_ = color_1_.x;
    float _e7_ = color_1_.y;
    float _e10_ = color_1_.z;
    float level = (((_e5_ + _e7_) + _e10_) / 3.0);
    vec2 midtone_range = color_grading.midtone_range;
    if ((level < (midtone_range.x - LEVEL_MARGINX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X))) {
        levels.x = 1.0;
    } else {
        if ((level < (midtone_range.x + LEVEL_MARGINX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X))) {
            levels.y = (((level - midtone_range.x) * LEVEL_MARGIN_DIVX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X) + 0.5);
            float _e37_ = levels.y;
            levels.z = (1.0 - _e37_);
        } else {
            if ((level < (midtone_range.y - LEVEL_MARGINX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X))) {
                levels.y = 1.0;
            } else {
                if ((level < (midtone_range.y + LEVEL_MARGINX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X))) {
                    levels.z = (((level - midtone_range.y) * LEVEL_MARGIN_DIVX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X) + 0.5);
                    float _e59_ = levels.z;
                    levels.y = (1.0 - _e59_);
                } else {
                    levels.z = 1.0;
                }
            }
        }
    }
    vec3 _e64_ = levels;
    vec3 _e66_ = color_grading.contrast;
    float contrast = dot(_e64_, _e66_);
    vec3 _e68_ = levels;
    vec3 _e70_ = color_grading.saturation;
    float saturation = dot(_e68_, _e70_);
    vec3 _e72_ = levels;
    vec3 _e74_ = color_grading.gamma;
    float gamma = dot(_e72_, _e74_);
    vec3 _e76_ = levels;
    vec3 _e78_ = color_grading.gain;
    float gain = dot(_e76_, _e78_);
    vec3 _e80_ = levels;
    vec3 _e82_ = color_grading.lift;
    float lift = dot(_e80_, _e82_);
    vec3 _e84_ = color_1_;
    float _e85 = tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e84_);
    vec3 _e86_ = color_1_;
    color_1_ = (vec3(_e85) + (saturation * (_e86_ - vec3(_e85))));
    vec3 _e92_ = color_1_;
    color_1_ = (vec3(0.5) + ((_e92_ - vec3(0.5)) * contrast));
    vec3 _e100_ = color_1_;
    vec3 _e106 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(((_e100_ * gain) + vec3(lift)), (1.0 / gamma));
    color_1_ = _e106;
    vec3 _e107_ = color_1_;
    float _e111_ = color_grading.exposure;
    vec3 _e112 = powsafeX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX(vec3(2.0), _e111_);
    color_1_ = (_e107_ * _e112);
    vec3 _e114_ = color_1_;
    return max(_e114_, vec3(0.0));
}

vec3 convertOpenDomainToNormalizedLog2_X_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 color_2_, float minimum_ev, float maximum_ev) {
    vec3 normalized_color = vec3(0.0);
    normalized_color = max(vec3(0.0), color_2_);
    vec3 _e5_1 = normalized_color;
    vec3 _e6_ = normalized_color;
    vec3 _e10_1 = normalized_color;
    normalized_color = mix(_e5_1, (vec3(1.525878e-5) + _e6_), lessThan(_e10_1, vec3(3.051757e-5)));
    vec3 _e18_ = normalized_color;
    normalized_color = clamp(log2((_e18_ / vec3(0.18))), vec3(minimum_ev), vec3(maximum_ev));
    float total_exposure = (maximum_ev - minimum_ev);
    vec3 _e26_ = normalized_color;
    return ((_e26_ - vec3(minimum_ev)) / vec3(total_exposure));
}

vec3 applyAgXLogX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 Image) {
    vec3 prepared_image = vec3(0.0);
    prepared_image = max(vec3(0.0), Image);
    vec3 _e5_2 = prepared_image;
    float r = dot(_e5_2, vec3(0.84247905, 0.0784336, 0.07922375));
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

vec3 saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec3 color_3_, float saturationAmount) {
    float _e2 = tonemapping_luminanceX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(color_3_);
    return mix(vec3(_e2), color_3_, vec3(saturationAmount));
}

vec4 tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(vec4 in_2_, ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX in_color_grading) {
    vec3 color_4_ = vec3(0.0);
    ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX color_grading_1_ = ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX(mat3x3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec3(0.0), vec2(0.0), 0.0, 0.0, 0.0);
    color_4_ = max(in_2_.xyz, vec3(0.0));
    color_grading_1_ = in_color_grading;
    mat3x3 _e9_ = color_grading_1_.balance;
    vec3 _e10_2 = color_4_;
    color_4_ = max((_e9_ * _e10_2), vec3(0.0));
    vec3 _e15_ = color_4_;
    vec3 _e16 = sectional_color_gradingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e15_, color_grading_1_);
    color_4_ = _e16;
    vec3 _e17_1 = color_4_;
    vec3 _e18 = applyAgXLogX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e17_1);
    color_4_ = _e18;
    vec3 _e19_ = color_4_;
    vec3 _e21 = applyLUT3DX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e19_, 32.0);
    color_4_ = _e21;
    vec3 _e22_ = color_4_;
    float _e24_1 = color_grading_1_.post_saturation;
    vec3 _e25 = saturationX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(_e22_, _e24_1);
    color_4_ = _e25;
    vec3 _e26_1 = color_4_;
    return vec4(_e26_1, in_2_.w);
}

void main() {
    FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX in_ = FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX(gl_FragCoord, _vs2fs_location0);
    vec3 output_rgb = vec3(0.0);
    vec4 hdr_color = texture(_group_0_binding_1_fs, vec2(in_.uv));
    ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _e7_1 = _group_0_binding_0_fs.color_grading;
    vec4 _e9 = tone_mappingX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2ORXW4ZLNMFYHA2LOM4X(hdr_color, _e7_1);
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
    vec3 _e24_2 = output_rgb;
    _fs2p_location0 = vec4(_e24_2, hdr_color.w);
    return;
}
