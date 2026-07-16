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

layout(std140, binding = 0) uniform ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX_block_0Vertex { ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX _group_0_binding_0_vs; };

layout(location = 0) in vec3 _p2vs_location0;
layout(location = 1) in vec2 _p2vs_location1;
layout(location = 2) in vec4 _p2vs_location2;
layout(location = 3) in uint _p2vs_location3;
layout(location = 4) in vec4 _p2vs_location4;
layout(location = 5) in vec4 _p2vs_location5;
layout(location = 6) in vec2 _p2vs_location6;
layout(location = 7) in vec2 _p2vs_location7;
layout(location = 0) smooth out vec2 _vs2fs_location0;
layout(location = 1) smooth out vec4 _vs2fs_location1;
layout(location = 2) flat out vec2 _vs2fs_location2;
layout(location = 3) flat out uint _vs2fs_location3;
layout(location = 4) flat out vec4 _vs2fs_location4;
layout(location = 5) flat out vec4 _vs2fs_location5;
layout(location = 6) smooth out vec2 _vs2fs_location6;

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
    vec3 vertex_position = _p2vs_location0;
    vec2 vertex_uv = _p2vs_location1;
    vec4 vertex_color = _p2vs_location2;
    uint flags = _p2vs_location3;
    vec4 radius = _p2vs_location4;
    vec4 border = _p2vs_location5;
    vec2 size = _p2vs_location6;
    vec2 point = _p2vs_location7;
    VertexOutput out_ = VertexOutput(vec2(0.0), vec4(0.0), vec2(0.0), 0u, vec4(0.0), vec4(0.0), vec2(0.0), vec4(0.0));
    out_.uv = vertex_uv;
    mat4x4 _e6_ = _group_0_binding_0_vs.clip_from_world;
    out_.position = (_e6_ * vec4(vertex_position, 1.0));
    out_.color = vertex_color;
    out_.flags = flags;
    out_.radius = radius;
    out_.size = size;
    out_.border = border;
    out_.point = point;
    VertexOutput _e23_ = out_;
    _vs2fs_location0 = _e23_.uv;
    _vs2fs_location1 = _e23_.color;
    _vs2fs_location2 = _e23_.size;
    _vs2fs_location3 = _e23_.flags;
    _vs2fs_location4 = _e23_.radius;
    _vs2fs_location5 = _e23_.border;
    _vs2fs_location6 = _e23_.point;
    gl_Position = _e23_.position;
    return;
}
