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
struct GradientVertexOutput {
    vec2 uv;
    vec2 size;
    uint flags;
    vec4 radius;
    vec4 border;
    vec2 point;
    vec2 g_start;
    vec2 dir;
    vec4 start_color;
    float start_len;
    float end_len;
    vec4 end_color;
    float hint;
    vec4 position;
};
const float PIX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX = 3.1415927;
const uint BORDER_ANYX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX = 3840u;
const uint BORDER_LEFTX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX = 256u;
const uint BORDER_TOPX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX = 512u;
const uint BORDER_RIGHTX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX = 1024u;
const uint BORDER_BOTTOMX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX = 2048u;
const uint INVERTX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX = 4096u;
const float PI_2X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX = 6.2831855;
const float FRAC_PI_3X_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX = 1.0471976;
const float TAU = 6.2831855;
const uint RIGHT_VERTEX = 2u;
const uint BOTTOM_VERTEX = 4u;
const uint RADIAL = 16u;
const uint FILL_START = 32u;
const uint FILL_END = 64u;
const uint CONIC = 128u;
const uint BORDER_LEFT = 256u;
const uint BORDER_TOP = 512u;
const uint BORDER_RIGHT = 1024u;
const uint BORDER_BOTTOM = 2048u;
const uint BORDER_ANY = 3840u;

layout(std140, binding = 0) uniform ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX_block_0Vertex { ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _group_0_binding_0_vs; };

layout(location = 0) in vec3 _p2vs_location0;
layout(location = 1) in vec2 _p2vs_location1;
layout(location = 2) in uint _p2vs_location2;
layout(location = 3) in vec4 _p2vs_location3;
layout(location = 4) in vec4 _p2vs_location4;
layout(location = 5) in vec2 _p2vs_location5;
layout(location = 6) in vec2 _p2vs_location6;
layout(location = 7) in vec2 _p2vs_location7;
layout(location = 8) in vec2 _p2vs_location8;
layout(location = 9) in vec4 _p2vs_location9;
layout(location = 10) in float _p2vs_location10;
layout(location = 11) in float _p2vs_location11;
layout(location = 12) in vec4 _p2vs_location12;
layout(location = 13) in float _p2vs_location13;
layout(location = 0) smooth out vec2 _vs2fs_location0;
layout(location = 1) flat out vec2 _vs2fs_location1;
layout(location = 2) flat out uint _vs2fs_location2;
layout(location = 3) flat out vec4 _vs2fs_location3;
layout(location = 4) flat out vec4 _vs2fs_location4;
layout(location = 5) smooth out vec2 _vs2fs_location5;
layout(location = 6) flat out vec2 _vs2fs_location6;
layout(location = 7) flat out vec2 _vs2fs_location7;
layout(location = 8) flat out vec4 _vs2fs_location8;
layout(location = 9) flat out float _vs2fs_location9;
layout(location = 10) flat out float _vs2fs_location10;
layout(location = 11) flat out vec4 _vs2fs_location11;
layout(location = 12) flat out float _vs2fs_location12;

float sd_rounded_boxX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(vec2 point_1_, vec2 size_1_, vec4 corner_radii) {
    vec2 rs = ((0.0 < point_1_.y) ? corner_radii.wz : corner_radii.xy);
    float radius_4_ = ((0.0 < point_1_.x) ? rs.y : rs.x);
    vec2 corner_to_point = (abs(point_1_) - (0.5 * size_1_));
    vec2 q = (corner_to_point + vec2(radius_4_));
    float l = length(max(q, vec2(0.0)));
    float m = min(max(q.x, q.y), 0.0);
    return ((l + m) - radius_4_);
}

float sd_inset_rounded_boxX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(vec2 point_2_, vec2 size_2_, vec4 radius_1_, vec4 inset) {
    vec4 r = vec4(0.0);
    vec2 inner_size = ((size_2_ - inset.xy) - inset.zw);
    vec2 inner_center = ((inset.xy + (0.5 * inner_size)) - (0.5 * size_2_));
    vec2 inner_point = (point_2_ - inner_center);
    r = radius_1_;
    float _e19_ = r.x;
    r.x = (_e19_ - max(inset.x, inset.y));
    float _e26_ = r.y;
    r.y = (_e26_ - max(inset.z, inset.y));
    float _e33_ = r.z;
    r.z = (_e33_ - max(inset.z, inset.w));
    float _e40_ = r.w;
    r.w = (_e40_ - max(inset.x, inset.w));
    vec2 half_size = (inner_size * 0.5);
    float min_size = min(half_size.x, half_size.y);
    vec4 _e50_ = r;
    r = min(max(_e50_, vec4(0.0)), vec4(min_size));
    vec4 _e56_ = r;
    float _e57 = sd_rounded_boxX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(inner_point, inner_size, _e56_);
    return _e57;
}

bool enabledX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(uint flags_1_, uint mask) {
    return ((flags_1_ & mask) != 0u);
}

bool nearest_border_activeX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(vec2 point_vs_mid, vec2 size_3_, vec4 width, uint flags_2_) {
    bool local = false;
    bool local_1_ = false;
    bool local_2_ = false;
    bool local_3_ = false;
    bool local_4_ = false;
    bool local_5_ = false;
    bool local_6_ = false;
    if (((flags_2_ & BORDER_ANYX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX) == BORDER_ANYX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX)) {
        return true;
    }
    vec2 point_8_ = clamp((point_vs_mid + (size_3_ * 0.49999)), vec2(0.0), size_3_);
    float left = (point_8_.x / width.x);
    float top = (point_8_.y / width.y);
    float right = ((size_3_.x - point_8_.x) / width.z);
    float bottom = ((size_3_.y - point_8_.y) / width.w);
    float min_dist = min(min(left, top), min(right, bottom));
    bool _e42 = enabledX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(flags_2_, BORDER_LEFTX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX);
    if (_e42) {
        local = (min_dist == left);
    } else {
        local = false;
    }
    bool _e40_1 = local;
    if (!(_e40_1)) {
        bool _e48 = enabledX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(flags_2_, BORDER_TOPX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX);
        if (_e48) {
            local_2_ = (min_dist == top);
        } else {
            local_2_ = false;
        }
        bool _e48_ = local_2_;
        local_1_ = _e48_;
    } else {
        local_1_ = true;
    }
    bool _e52_ = local_1_;
    if (!(_e52_)) {
        bool _e56 = enabledX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(flags_2_, BORDER_RIGHTX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX);
        if (_e56) {
            local_4_ = (min_dist == right);
        } else {
            local_4_ = false;
        }
        bool _e60_ = local_4_;
        local_3_ = _e60_;
    } else {
        local_3_ = true;
    }
    bool _e64_ = local_3_;
    if (!(_e64_)) {
        bool _e64 = enabledX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(flags_2_, BORDER_BOTTOMX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX);
        if (_e64) {
            local_6_ = (min_dist == bottom);
        } else {
            local_6_ = false;
        }
        bool _e72_ = local_6_;
        local_5_ = _e72_;
    } else {
        local_5_ = true;
    }
    bool _e76_ = local_5_;
    return _e76_;
}

float antialiasX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(float distance_) {
    return clamp((0.5 - distance_), 0.0, 1.0);
}

vec4 draw_uinode_borderX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(vec4 color, vec2 point_3_, vec2 size_4_, vec4 radius_2_, vec4 border_1_, uint flags_3_) {
    float _e6 = sd_rounded_boxX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(point_3_, size_4_, radius_2_);
    float _e7 = sd_inset_rounded_boxX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(point_3_, size_4_, radius_2_, border_1_);
    float border_distance = max(_e6, -(_e7));
    bool _e10 = nearest_border_activeX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(point_3_, size_4_, border_1_, flags_3_);
    float nearest_border = (_e10 ? 1.0 : 0.0);
    float _e14 = antialiasX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(border_distance);
    float t_2_ = ((_e6 < _e7) ? _e14 : (1.0 - step(0.0, border_distance)));
    return vec4(color.xyz, clamp(((color.w * t_2_) * nearest_border), 0.0, 1.0));
}

vec4 draw_uinode_backgroundX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(vec4 color_1_, vec2 point_4_, vec2 size_5_, vec4 radius_3_, vec4 border_2_, uint flags_4_) {
    float _e6 = sd_inset_rounded_boxX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(point_4_, size_5_, radius_3_, border_2_);
    bool _e8 = enabledX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(flags_4_, INVERTX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX);
    float internal_distance = (_e6 * (_e8 ? -1.0 : 1.0));
    float _e13 = antialiasX_naga_oil_mod_XMJSXM6K7OVUTUOTVNFPW433EMUX(internal_distance);
    return vec4(color_1_.xyz, clamp((color_1_.w * _e13), 0.0, 1.0));
}

vec3 oklab_to_linear_rgbX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(vec3 c) {
    float l_1_ = ((c.x + (0.39633778 * c.y)) + (0.21580376 * c.z));
    float m_1_ = ((c.x - (0.105561346 * c.y)) - (0.06385417 * c.z));
    float s = ((c.x - (0.08948418 * c.y)) - (1.2914855 * c.z));
    float l_2_ = ((l_1_ * l_1_) * l_1_);
    float m_2_ = ((m_1_ * m_1_) * m_1_);
    float s_1_ = ((s * s) * s);
    return vec3((((4.0767417 * l_2_) - (3.3077116 * m_2_)) + (0.23096994 * s_1_)), (((-1.268438 * l_2_) + (2.6097574 * m_2_)) - (0.34131938 * s_1_)), (((-0.0041960864 * l_2_) - (0.7034186 * m_2_)) + (1.7076147 * s_1_)));
}

bool enabled(uint flags_5_, uint mask_1_) {
    return ((flags_5_ & mask_1_) != 0u);
}

float radial_distance(vec2 point_5_, vec2 center, float ratio) {
    vec2 d = (point_5_ - center);
    return length(vec2(d.x, (d.y * ratio)));
}

float conic_distance(float start, vec2 point_6_, vec2 center_1_) {
    vec2 d_1_ = (point_6_ - center_1_);
    float angle = (atan(-(d_1_.x), d_1_.y) + PIX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU3LBORUHGX);
    return ((((angle - start) - TAU * trunc((angle - start) / TAU)) + TAU) - TAU * trunc((((angle - start) - TAU * trunc((angle - start) / TAU)) + TAU) / TAU));
}

float linear_distance(vec2 point_7_, vec2 g_start_1_, vec2 g_dir) {
    return dot((point_7_ - g_start_1_), g_dir);
}

vec3 mix_colors(vec3 start_color_1_, vec3 end_color_1_, float t) {
    return mix(start_color_1_, end_color_1_, t);
}

vec4 convert_to_linear_rgbaX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(vec4 color_2_) {
    vec3 _e2 = oklab_to_linear_rgbX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(color_2_.xyz);
    return vec4(_e2, color_2_.w);
}

vec4 interpolate_gradient(float distance_1_, vec4 start_color_2_, float start_distance, vec4 end_color_2_, float end_distance, float hint_1_, uint flags_6_) {
    bool local_7_ = false;
    bool local_8_ = false;
    float t_1_ = 0.0;
    if ((start_distance == end_distance)) {
        if ((distance_1_ <= start_distance)) {
            bool _e13 = enabled(flags_6_, FILL_START);
            local_7_ = _e13;
        } else {
            local_7_ = false;
        }
        bool _e11_ = local_7_;
        if (_e11_) {
            vec4 _e16 = convert_to_linear_rgbaX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(start_color_2_);
            return _e16;
        }
        if ((start_distance <= distance_1_)) {
            bool _e19 = enabled(flags_6_, FILL_END);
            local_8_ = _e19;
        } else {
            local_8_ = false;
        }
        bool _e20_ = local_8_;
        if (_e20_) {
            vec4 _e22 = convert_to_linear_rgbaX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(end_color_2_);
            return _e22;
        }
        return vec4(0.0);
    }
    t_1_ = ((distance_1_ - start_distance) / (end_distance - start_distance));
    float _e29_ = t_1_;
    if ((_e29_ < 0.0)) {
        bool _e32 = enabled(flags_6_, FILL_START);
        if (_e32) {
            vec4 _e33 = convert_to_linear_rgbaX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(start_color_2_);
            return _e33;
        }
        return vec4(0.0);
    }
    float _e37_ = t_1_;
    if ((1.0 < _e37_)) {
        bool _e40 = enabled(flags_6_, FILL_END);
        if (_e40) {
            vec4 _e41 = convert_to_linear_rgbaX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(end_color_2_);
            return _e41;
        }
        return vec4(0.0);
    }
    float _e46_ = t_1_;
    if ((_e46_ < hint_1_)) {
        float _e48_1 = t_1_;
        t_1_ = ((0.5 * _e48_1) / hint_1_);
    } else {
        float _e52_1 = t_1_;
        t_1_ = (0.5 * (1.0 + ((_e52_1 - hint_1_) / (1.0 - hint_1_))));
    }
    float _e63_ = t_1_;
    vec3 _e62 = mix_colors(start_color_2_.xyz, end_color_2_.xyz, _e63_);
    float _e67_ = t_1_;
    vec4 _e68 = convert_to_linear_rgbaX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DUY3PNRXXEX3POBSXEYLUNFXW44YX(vec4(_e62, mix(start_color_2_.w, end_color_2_.w, _e67_)));
    return _e68;
}

float rem_euclid(float a, float b) {
    return (((a - b * trunc(a / b)) + b) - b * trunc(((a - b * trunc(a / b)) + b) / b));
}

void main() {
    vec3 vertex_position = _p2vs_location0;
    vec2 vertex_uv = _p2vs_location1;
    uint flags = _p2vs_location2;
    vec4 radius = _p2vs_location3;
    vec4 border = _p2vs_location4;
    vec2 size = _p2vs_location5;
    vec2 point = _p2vs_location6;
    vec2 g_start = _p2vs_location7;
    vec2 dir = _p2vs_location8;
    vec4 start_color = _p2vs_location9;
    float start_len = _p2vs_location10;
    float end_len = _p2vs_location11;
    vec4 end_color = _p2vs_location12;
    float hint = _p2vs_location13;
    GradientVertexOutput out_ = GradientVertexOutput(vec2(0.0), vec2(0.0), 0u, vec4(0.0), vec4(0.0), vec2(0.0), vec2(0.0), vec2(0.0), vec4(0.0), 0.0, 0.0, vec4(0.0), 0.0, vec4(0.0));
    mat4x4 _e4_ = _group_0_binding_0_vs.clip_from_world;
    out_.position = (_e4_ * vec4(vertex_position, 1.0));
    out_.uv = vertex_uv;
    out_.size = size;
    out_.flags = flags;
    out_.radius = radius;
    out_.border = border;
    out_.point = point;
    out_.dir = dir;
    out_.start_color = start_color;
    out_.start_len = start_len;
    out_.end_len = end_len;
    out_.end_color = end_color;
    out_.g_start = g_start;
    out_.hint = hint;
    GradientVertexOutput _e35_ = out_;
    _vs2fs_location0 = _e35_.uv;
    _vs2fs_location1 = _e35_.size;
    _vs2fs_location2 = _e35_.flags;
    _vs2fs_location3 = _e35_.radius;
    _vs2fs_location4 = _e35_.border;
    _vs2fs_location5 = _e35_.point;
    _vs2fs_location6 = _e35_.g_start;
    _vs2fs_location7 = _e35_.dir;
    _vs2fs_location8 = _e35_.start_color;
    _vs2fs_location9 = _e35_.start_len;
    _vs2fs_location10 = _e35_.end_len;
    _vs2fs_location11 = _e35_.end_color;
    _vs2fs_location12 = _e35_.hint;
    gl_Position = _e35_.position;
    return;
}
