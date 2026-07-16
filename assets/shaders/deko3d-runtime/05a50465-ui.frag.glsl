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
struct VertexOutput {
    vec2 uv;
    vec4 color;
    vec2 size;
    uint flags;
    vec4 radius;
    vec4 border;
    vec2 point;
    vec4 position;
};
const uint TEXTURED = 1u;
const uint RIGHT_VERTEX = 2u;
const uint BOTTOM_VERTEX = 4u;
const uint BORDER_LEFT = 256u;
const uint BORDER_TOP = 512u;
const uint BORDER_RIGHT = 1024u;
const uint BORDER_BOTTOM = 2048u;
const uint BORDER_ANY = 3840u;
const uint INVERT = 4096u;

layout(binding = 0) uniform sampler2D _group_1_binding_0_fs;

layout(location = 0) smooth in vec2 _vs2fs_location0;
layout(location = 1) smooth in vec4 _vs2fs_location1;
layout(location = 2) flat in vec2 _vs2fs_location2;
layout(location = 3) flat in uint _vs2fs_location3;
layout(location = 4) flat in vec4 _vs2fs_location4;
layout(location = 5) flat in vec4 _vs2fs_location5;
layout(location = 6) smooth in vec2 _vs2fs_location6;
layout(location = 0) out vec4 _fs2p_location0;

bool enabled(uint flags_1_, uint mask) {
    return ((flags_1_ & mask) != 0u);
}

float sd_rounded_box(vec2 point_1_, vec2 size_1_, vec4 corner_radii) {
    vec2 rs = ((0.0 < point_1_.y) ? corner_radii.wz : corner_radii.xy);
    float radius_4_ = ((0.0 < point_1_.x) ? rs.y : rs.x);
    vec2 corner_to_point = (abs(point_1_) - (0.5 * size_1_));
    vec2 q = (corner_to_point + vec2(radius_4_));
    float l = length(max(q, vec2(0.0)));
    float m = min(max(q.x, q.y), 0.0);
    return ((l + m) - radius_4_);
}

float sd_inset_rounded_box(vec2 point_2_, vec2 size_2_, vec4 radius_1_, vec4 inset) {
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
    float _e57 = sd_rounded_box(inner_point, inner_size, _e56_);
    return _e57;
}

bool nearest_border_active(vec2 point_vs_mid, vec2 size_3_, vec4 width, uint flags_2_) {
    bool local = false;
    bool local_1_ = false;
    bool local_2_ = false;
    bool local_3_ = false;
    bool local_4_ = false;
    bool local_5_ = false;
    bool local_6_ = false;
    if (((flags_2_ & BORDER_ANY) == BORDER_ANY)) {
        return true;
    }
    vec2 point_5_ = clamp((point_vs_mid + (size_3_ * 0.49999)), vec2(0.0), size_3_);
    float left = (point_5_.x / width.x);
    float top = (point_5_.y / width.y);
    float right = ((size_3_.x - point_5_.x) / width.z);
    float bottom = ((size_3_.y - point_5_.y) / width.w);
    float min_dist = min(min(left, top), min(right, bottom));
    bool _e42 = enabled(flags_2_, BORDER_LEFT);
    if (_e42) {
        local = (min_dist == left);
    } else {
        local = false;
    }
    bool _e40_1 = local;
    if (!(_e40_1)) {
        bool _e48 = enabled(flags_2_, BORDER_TOP);
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
        bool _e56 = enabled(flags_2_, BORDER_RIGHT);
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
        bool _e64 = enabled(flags_2_, BORDER_BOTTOM);
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

float antialias(float distance_) {
    return clamp((0.5 - distance_), 0.0, 1.0);
}

vec4 draw_uinode_border(vec4 color, vec2 point_3_, vec2 size_4_, vec4 radius_2_, vec4 border_1_, uint flags_3_) {
    float _e6 = sd_rounded_box(point_3_, size_4_, radius_2_);
    float _e7 = sd_inset_rounded_box(point_3_, size_4_, radius_2_, border_1_);
    float border_distance = max(_e6, -(_e7));
    bool _e10 = nearest_border_active(point_3_, size_4_, border_1_, flags_3_);
    float nearest_border = (_e10 ? 1.0 : 0.0);
    float _e14 = antialias(border_distance);
    float t = ((_e6 < _e7) ? _e14 : (1.0 - step(0.0, border_distance)));
    return vec4(color.xyz, clamp(((color.w * t) * nearest_border), 0.0, 1.0));
}

vec4 draw_uinode_background(vec4 color_1_, vec2 point_4_, vec2 size_5_, vec4 radius_3_, vec4 border_2_, uint flags_4_) {
    float _e6 = sd_inset_rounded_box(point_4_, size_5_, radius_3_, border_2_);
    bool _e8 = enabled(flags_4_, INVERT);
    float internal_distance = (_e6 * (_e8 ? -1.0 : 1.0));
    float _e13 = antialias(internal_distance);
    return vec4(color_1_.xyz, clamp((color_1_.w * _e13), 0.0, 1.0));
}

void main() {
    VertexOutput in_ = VertexOutput(_vs2fs_location0, _vs2fs_location1, _vs2fs_location2, _vs2fs_location3, _vs2fs_location4, _vs2fs_location5, _vs2fs_location6, gl_FragCoord);
    vec4 texture_color = texture(_group_1_binding_0_fs, vec2(in_.uv));
    bool _e7 = enabled(in_.flags, TEXTURED);
    vec4 color_2_ = (_e7 ? (in_.color * texture_color) : in_.color);
    bool _e14 = enabled(in_.flags, BORDER_ANY);
    if (_e14) {
        vec4 _e20 = draw_uinode_border(color_2_, in_.point, in_.size, in_.radius, in_.border, in_.flags);
        _fs2p_location0 = _e20;
        return;
    } else {
        vec4 _e26 = draw_uinode_background(color_2_, in_.point, in_.size, in_.radius, in_.border, in_.flags);
        _fs2p_location0 = _e26;
        return;
    }
}
