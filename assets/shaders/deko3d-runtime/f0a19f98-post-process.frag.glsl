#version 460 core
struct FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX {
    vec4 position;
    vec2 uv;
};
struct LensDistortionSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X {
    float intensity;
    float scale;
    vec2 multiplier;
    vec2 center;
    float edge_curvature;
    uint unused;
};
struct ChromaticAberrationSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DUY3IOJXW2YLUNFRV6YLCMVZHEYLUNFXW4X {
    float intensity;
    uint max_samples;
    uint unused_a;
    uint unused_b;
};
struct VignetteSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU5TJM5XGK5DUMUX {
    float intensity;
    float radius;
    float smoothness;
    float roundness;
    vec2 center;
    float edge_compensation;
    uint unused;
    vec4 color;
};
const float VISUAL_THRESHOLDX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X = 0.0001;
const float MATH_EPSILONX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X = 1e-6;
const float VISUAL_THRESHOLDX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU5TJM5XGK5DUMUX = 0.0001;

layout(std140, binding = 2) uniform LensDistortionSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X_block_0Fragment { LensDistortionSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X _group_0_binding_5_fs; };

layout(std140, binding = 0) uniform ChromaticAberrationSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DUY3IOJXW2YLUNFRV6YLCMVZHEYLUNFXW4X_block_1Fragment { ChromaticAberrationSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DUY3IOJXW2YLUNFRV6YLCMVZHEYLUNFXW4X _group_0_binding_3_fs; };

layout(binding = 0) uniform sampler2D _group_0_binding_0_fs;

layout(binding = 1) uniform sampler2D _group_0_binding_2_fs;

layout(std140, binding = 1) uniform VignetteSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU5TJM5XGK5DUMUX_block_2Fragment { VignetteSettingsX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU5TJM5XGK5DUMUX _group_0_binding_4_fs; };

layout(location = 0) smooth in vec2 _vs2fs_location0;
layout(location = 0) out vec4 _fs2p_location0;

vec2 lens_distortionX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X(vec2 uv) {
    float intensity = _group_0_binding_5_fs.intensity;
    if ((abs(intensity) < VISUAL_THRESHOLDX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X)) {
        return uv;
    }
    vec2 multiplier = _group_0_binding_5_fs.multiplier;
    vec2 center = _group_0_binding_5_fs.center;
    vec2 uv_centered = (uv - center);
    float radius = max(length(uv_centered), MATH_EPSILONX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X);
    vec2 direction = (uv_centered / vec2(radius));
    float adjust = dot(abs(direction), multiplier);
    float k1_ = (intensity * adjust);
    float _e25_ = _group_0_binding_5_fs.edge_curvature;
    float k2_ = ((k1_ * intensity) * _e25_);
    float r2_ = (radius * radius);
    float r_distorted = (radius * (1.0 + ((k1_ + (k2_ * r2_)) * r2_)));
    vec2 uv_distorted = ((direction * r_distorted) + center);
    float _e39_ = _group_0_binding_5_fs.scale;
    vec2 uv_scaled = (((uv_distorted - center) / vec2(_e39_)) + center);
    vec2 uv_safe = clamp(uv_scaled, vec2(0.0), vec2(1.0));
    return uv_safe;
}

vec3 chromatic_aberrationX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DUY3IOJXW2YLUNFRV6YLCMVZHEYLUNFXW4X(vec2 start_pos) {
    vec3 color = vec3(0.0);
    vec3 sample_sum = vec3(0.0);
    vec3 modulate_sum = vec3(0.0);
    uint sample_index = 0u;
    float _e5_ = _group_0_binding_3_fs.intensity;
    vec2 end_pos = mix(start_pos, vec2(0.5), _e5_);
    uvec2 _e12_ = uvec2(textureSize(_group_0_binding_0_fs, 0).xy);
    float texel_length = length(((end_pos - start_pos) * vec2(_e12_)));
    uint _e20_ = _group_0_binding_3_fs.max_samples;
    uint sample_count = min(uint(ceil(texel_length)), _e20_);
    if ((sample_count > 1u)) {
        uvec2 _e25_1 = uvec2(textureSize(_group_0_binding_2_fs, 0).xy);
        float lut_u_offset = (0.5 / float(_e25_1.x));
        bool loop_init = true;
        while(true) {
            if (!loop_init) {
                uint _e62_ = sample_index;
                sample_index = (_e62_ + 1u);
            }
            loop_init = false;
            uint _e31_ = sample_index;
            if ((_e31_ < sample_count)) {
            } else {
                break;
            }
            {
                uint _e33_ = sample_index;
                float t = ((float(_e33_) + 0.5) / float(sample_count));
                vec2 sample_uv = mix(start_pos, end_pos, t);
                vec4 _e43_ = textureLod(_group_0_binding_0_fs, vec2(sample_uv), 0.0);
                vec3 sample_ = _e43_.xyz;
                float lut_u = mix(lut_u_offset, (1.0 - lut_u_offset), t);
                vec4 _e53_ = textureLod(_group_0_binding_2_fs, vec2(vec2(lut_u, 0.5)), 0.0);
                vec3 modulate = _e53_.xyz;
                vec3 _e56_ = sample_sum;
                sample_sum = (_e56_ + (sample_ * modulate));
                vec3 _e60_ = modulate_sum;
                modulate_sum = (_e60_ + modulate);
            }
        }
        vec3 _e65_ = sample_sum;
        vec3 _e66_ = modulate_sum;
        color = (_e65_ / _e66_);
    } else {
        vec4 _e72_ = textureLod(_group_0_binding_0_fs, vec2(start_pos), 0.0);
        color = _e72_.xyz;
    }
    vec3 _e74_ = color;
    return _e74_;
}

vec3 vignetteX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU5TJM5XGK5DUMUX(vec2 uv_1_, vec3 color_1_) {
    vec2 scale_vec = vec2(0.0);
    float intensity_1_ = _group_0_binding_4_fs.intensity;
    if ((intensity_1_ < VISUAL_THRESHOLDX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU5TJM5XGK5DUMUX)) {
        return color_1_;
    }
    float radius_1_ = _group_0_binding_4_fs.radius;
    float smoothness = _group_0_binding_4_fs.smoothness;
    float roundness = _group_0_binding_4_fs.roundness;
    float edge_comp = _group_0_binding_4_fs.edge_compensation;
    uvec2 dims = uvec2(textureSize(_group_0_binding_0_fs, 0).xy);
    vec2 resolution = vec2(dims.xy);
    float screen_aspect = (resolution.x / resolution.y);
    vec2 aspect_ratio = (resolution / vec2(min(resolution.x, resolution.y)));
    vec2 centered_uv = (uv_1_ - vec2(0.5));
    vec2 _e36_ = _group_0_binding_4_fs.center;
    vec2 offset = ((_e36_ - vec2(0.5)) * vec2(1.0, (resolution.y / resolution.x)));
    vec2 uv_from_center = (centered_uv - offset);
    scale_vec = (aspect_ratio * vec2(1.0, (1.0 / roundness)));
    if ((screen_aspect >= 1.0)) {
        float compensation_factor = mix(1.0, (1.0 / screen_aspect), edge_comp);
        float _e60_1 = scale_vec.x;
        scale_vec.x = (_e60_1 * compensation_factor);
    } else {
        float compensation_factor_1_ = mix(1.0, screen_aspect, edge_comp);
        float _e65_1 = scale_vec.y;
        scale_vec.y = (_e65_1 * compensation_factor_1_);
    }
    vec2 _e67_ = scale_vec;
    vec2 final_uv = (uv_from_center * _e67_);
    float dist = (length(final_uv) * (1.0 / radius_1_));
    float base_curve = (1.0 - (dist * dist));
    float clamped_factor = clamp(base_curve, 0.0, 1.0);
    float factor = pow(clamped_factor, smoothness);
    vec4 _e82_ = _group_0_binding_4_fs.color;
    return mix(color_1_, _e82_.xyz, ((1.0 - factor) * intensity_1_));
}

void main() {
    FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX in_ = FullscreenVertexOutputX_naga_oil_mod_XMJSXM6K7MNXXEZK7OBUXAZLMNFXGKOR2MZ2WY3DTMNZGKZLOL53GK4TUMV4F643IMFSGK4QX(gl_FragCoord, _vs2fs_location0);
    vec2 _e2 = lens_distortionX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU3DFNZZV6ZDJON2G64TUNFXW4X(in_.uv);
    vec3 _e3 = chromatic_aberrationX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DUY3IOJXW2YLUNFRV6YLCMVZHEYLUNFXW4X(_e2);
    vec3 _e5 = vignetteX_naga_oil_mod_XMJSXM6K7OBXXG5C7OBZG6Y3FONZTUOTFMZTGKY3UL5ZXIYLDNM5DU5TJM5XGK5DUMUX(in_.uv, _e3);
    _fs2p_location0 = vec4(_e5, 1.0);
    return;
}
