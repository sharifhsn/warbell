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
struct BoxShadowVertexOutput {
    vec4 position;
    vec2 point;
    vec4 color;
    vec2 size;
    vec4 radius;
    float blur;
};
const float PI = 3.1415927;
const int SAMPLES = 4;

layout(std140, binding = 0) uniform ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX_block_0Vertex { ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _group_0_binding_0_vs; };

layout(location = 0) in vec3 _p2vs_location0;
layout(location = 1) in vec2 _p2vs_location1;
layout(location = 2) in vec4 _p2vs_location2;
layout(location = 3) in vec2 _p2vs_location3;
layout(location = 4) in vec4 _p2vs_location4;
layout(location = 5) in float _p2vs_location5;
layout(location = 6) in vec2 _p2vs_location6;
layout(location = 0) smooth out vec2 _vs2fs_location0;
layout(location = 1) smooth out vec4 _vs2fs_location1;
layout(location = 2) flat out vec2 _vs2fs_location2;
layout(location = 3) flat out vec4 _vs2fs_location3;
layout(location = 4) flat out float _vs2fs_location4;

float gaussian(float x, float sigma) {
    return (exp((-((x * x)) / ((2.0 * sigma) * sigma))) / (2.5066283 * sigma));
}

vec2 erf(vec2 p) {
    vec2 result = vec2(0.0);
    vec2 s = sign(p);
    vec2 a = abs(p);
    result = (vec2(1.0) + ((vec2(0.278393) + ((vec2(0.230389) + (0.078108 * (a * a))) * a)) * a));
    vec2 _e18_ = result;
    vec2 _e19_ = result;
    result = (_e18_ * _e19_);
    vec2 _e21_ = result;
    vec2 _e22_ = result;
    return (s - (s / (_e21_ * _e22_)));
}

float selectCorner(vec2 p_1_, vec4 c) {
    return mix(mix(c.x, c.y, step(0.0, p_1_.x)), mix(c.w, c.z, step(0.0, p_1_.x)), step(0.0, p_1_.y));
}

float horizontalRoundedBoxShadow(float x_1_, float y, float blur_1_, float corner, vec2 half_size) {
    float d = min(((half_size.y - corner) - abs(y)), 0.0);
    float c_1_ = ((half_size.x - corner) + sqrt(max(0.0, ((corner * corner) - (d * d)))));
    vec2 _e27 = erf(((vec2(x_1_) + vec2(-(c_1_), c_1_)) * (0.70710677 / blur_1_)));
    vec2 integral = (vec2(0.5) + (0.5 * _e27));
    return (integral.y - integral.x);
}

float roundedBoxShadow(vec2 lower, vec2 upper, vec2 point, float blur_2_, vec4 corners) {
    float y_1_ = 0.0;
    float value = 0.0;
    int i = 0;
    vec2 center = ((lower + upper) * 0.5);
    vec2 half_size_1_ = ((upper - lower) * 0.5);
    vec2 p_2_ = (point - center);
    float low = (p_2_.y - half_size_1_.y);
    float high = (p_2_.y + half_size_1_.y);
    float start = clamp((-3.0 * blur_2_), low, high);
    float end = clamp((3.0 * blur_2_), low, high);
    float step_ = ((end - start) / 4.0);
    y_1_ = (start + (step_ * 0.5));
    bool loop_init = true;
    while(true) {
        if (!loop_init) {
            int _e53_ = i;
            i = (_e53_ + 1);
        }
        loop_init = false;
        int _e33_ = i;
        if ((_e33_ < SAMPLES)) {
        } else {
            break;
        }
        {
            float _e38 = selectCorner(p_2_, corners);
            float _e39_ = value;
            float _e42_ = y_1_;
            float _e44 = horizontalRoundedBoxShadow(p_2_.x, (p_2_.y - _e42_), blur_2_, _e38, half_size_1_);
            float _e45_ = y_1_;
            float _e46 = gaussian(_e45_, blur_2_);
            value = (_e39_ + ((_e44 * _e46) * step_));
            float _e50_ = y_1_;
            y_1_ = (_e50_ + step_);
        }
    }
    float _e55_ = value;
    return _e55_;
}

void main() {
    vec3 vertex_position = _p2vs_location0;
    vec2 uv = _p2vs_location1;
    vec4 vertex_color = _p2vs_location2;
    vec2 size = _p2vs_location3;
    vec4 radius = _p2vs_location4;
    float blur = _p2vs_location5;
    vec2 bounds = _p2vs_location6;
    BoxShadowVertexOutput out_ = BoxShadowVertexOutput(vec4(0.0), vec2(0.0), vec4(0.0), vec2(0.0), vec4(0.0), 0.0);
    mat4x4 _e4_ = _group_0_binding_0_vs.clip_from_world;
    out_.position = (_e4_ * vec4(vertex_position, 1.0));
    out_.point = ((uv.xy - vec2(0.5)) * bounds);
    out_.color = vertex_color;
    out_.size = size;
    out_.radius = radius;
    out_.blur = blur;
    BoxShadowVertexOutput _e25_ = out_;
    gl_Position = _e25_.position;
    _vs2fs_location0 = _e25_.point;
    _vs2fs_location1 = _e25_.color;
    _vs2fs_location2 = _e25_.size;
    _vs2fs_location3 = _e25_.radius;
    _vs2fs_location4 = _e25_.blur;
    return;
}
