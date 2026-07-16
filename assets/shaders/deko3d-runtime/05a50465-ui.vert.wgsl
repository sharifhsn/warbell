struct ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX {
    balance: mat3x3<f32>,
    saturation: vec3<f32>,
    contrast: vec3<f32>,
    gamma: vec3<f32>,
    gain: vec3<f32>,
    lift: vec3<f32>,
    midtone_range: vec2<f32>,
    exposure: f32,
    hue: f32,
    post_saturation: f32,
}

struct ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX {
    clip_from_world: mat4x4<f32>,
    unjittered_clip_from_world: mat4x4<f32>,
    world_from_clip: mat4x4<f32>,
    world_from_view: mat4x4<f32>,
    view_from_world: mat4x4<f32>,
    clip_from_view: mat4x4<f32>,
    view_from_clip: mat4x4<f32>,
    world_position: vec3<f32>,
    exposure: f32,
    viewport: vec4<f32>,
    main_pass_viewport: vec4<f32>,
    frustum: array<vec4<f32>, 6>,
    lod_view_world_position: vec3<f32>,
    color_grading: ColorGradingX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX,
    mip_bias: f32,
    frame_count: u32,
}

struct VertexOutput {
    @location(0) uv: vec2<f32>,
    @location(1) color: vec4<f32>,
    @location(2) @interpolate(flat) size: vec2<f32>,
    @location(3) @interpolate(flat) flags: u32,
    @location(4) @interpolate(flat) radius: vec4<f32>,
    @location(5) @interpolate(flat) border: vec4<f32>,
    @location(6) point: vec2<f32>,
    @builtin(position) position: vec4<f32>,
}

const TEXTURED: u32 = 1u;
const RIGHT_VERTEX: u32 = 2u;
const BOTTOM_VERTEX: u32 = 4u;
const BORDER_LEFT: u32 = 256u;
const BORDER_TOP: u32 = 512u;
const BORDER_RIGHT: u32 = 1024u;
const BORDER_BOTTOM: u32 = 2048u;
const BORDER_ANY: u32 = 3840u;
const INVERT: u32 = 4096u;

@group(0) @binding(0) 
var<uniform> view: ViewX_naga_oil_mod_XMJSXM6K7OJSW4ZDFOI5DU5TJMV3QX;
@group(1) @binding(0) 
var sprite_texture: texture_2d<f32>;
@group(1) @binding(1) 
var sprite_sampler: sampler;

fn enabled(flags_1: u32, mask: u32) -> bool {
    return ((flags_1 & mask) != 0u);
}

fn sd_rounded_box(point_1: vec2<f32>, size_1: vec2<f32>, corner_radii: vec4<f32>) -> f32 {
    let rs: vec2<f32> = select(corner_radii.xy, corner_radii.wz, (0f < point_1.y));
    let radius_4: f32 = select(rs.x, rs.y, (0f < point_1.x));
    let corner_to_point: vec2<f32> = (abs(point_1) - (0.5f * size_1));
    let q: vec2<f32> = (corner_to_point + vec2(radius_4));
    let l: f32 = length(max(q, vec2(0f)));
    let m: f32 = min(max(q.x, q.y), 0f);
    return ((l + m) - radius_4);
}

fn sd_inset_rounded_box(point_2: vec2<f32>, size_2: vec2<f32>, radius_1: vec4<f32>, inset: vec4<f32>) -> f32 {
    var r: vec4<f32>;

    let inner_size: vec2<f32> = ((size_2 - inset.xy) - inset.zw);
    let inner_center: vec2<f32> = ((inset.xy + (0.5f * inner_size)) - (0.5f * size_2));
    let inner_point: vec2<f32> = (point_2 - inner_center);
    r = radius_1;
    let _e19: f32 = r.x;
    r.x = (_e19 - max(inset.x, inset.y));
    let _e26: f32 = r.y;
    r.y = (_e26 - max(inset.z, inset.y));
    let _e33: f32 = r.z;
    r.z = (_e33 - max(inset.z, inset.w));
    let _e40: f32 = r.w;
    r.w = (_e40 - max(inset.x, inset.w));
    let half_size: vec2<f32> = (inner_size * 0.5f);
    let min_size: f32 = min(half_size.x, half_size.y);
    let _e50: vec4<f32> = r;
    r = min(max(_e50, vec4(0f)), vec4(min_size));
    let _e56: vec4<f32> = r;
    let _e57: f32 = sd_rounded_box(inner_point, inner_size, _e56);
    return _e57;
}

fn nearest_border_active(point_vs_mid: vec2<f32>, size_3: vec2<f32>, width: vec4<f32>, flags_2: u32) -> bool {
    var local: bool;
    var local_1: bool;
    var local_2: bool;
    var local_3: bool;
    var local_4: bool;
    var local_5: bool;
    var local_6: bool;

    if ((flags_2 & BORDER_ANY) == BORDER_ANY) {
        return true;
    }
    let point_5: vec2<f32> = clamp((point_vs_mid + (size_3 * 0.49999f)), vec2(0f), size_3);
    let left: f32 = (point_5.x / width.x);
    let top: f32 = (point_5.y / width.y);
    let right: f32 = ((size_3.x - point_5.x) / width.z);
    let bottom: f32 = ((size_3.y - point_5.y) / width.w);
    let min_dist: f32 = min(min(left, top), min(right, bottom));
    let _e35: bool = enabled(flags_2, BORDER_LEFT);
    if _e35 {
        local = (min_dist == left);
    } else {
        local = false;
    }
    let _e40: bool = local;
    if !(_e40) {
        let _e43: bool = enabled(flags_2, BORDER_TOP);
        if _e43 {
            local_2 = (min_dist == top);
        } else {
            local_2 = false;
        }
        let _e48: bool = local_2;
        local_1 = _e48;
    } else {
        local_1 = true;
    }
    let _e52: bool = local_1;
    if !(_e52) {
        let _e55: bool = enabled(flags_2, BORDER_RIGHT);
        if _e55 {
            local_4 = (min_dist == right);
        } else {
            local_4 = false;
        }
        let _e60: bool = local_4;
        local_3 = _e60;
    } else {
        local_3 = true;
    }
    let _e64: bool = local_3;
    if !(_e64) {
        let _e67: bool = enabled(flags_2, BORDER_BOTTOM);
        if _e67 {
            local_6 = (min_dist == bottom);
        } else {
            local_6 = false;
        }
        let _e72: bool = local_6;
        local_5 = _e72;
    } else {
        local_5 = true;
    }
    let _e76: bool = local_5;
    return _e76;
}

fn antialias(distance_: f32) -> f32 {
    return saturate((0.5f - distance_));
}

fn draw_uinode_border(color: vec4<f32>, point_3: vec2<f32>, size_4: vec2<f32>, radius_2: vec4<f32>, border_1: vec4<f32>, flags_3: u32) -> vec4<f32> {
    let _e3: f32 = sd_rounded_box(point_3, size_4, radius_2);
    let _e5: f32 = sd_inset_rounded_box(point_3, size_4, radius_2, border_1);
    let border_distance: f32 = max(_e3, -(_e5));
    let _e9: bool = nearest_border_active(point_3, size_4, border_1, flags_3);
    let nearest_border: f32 = select(0f, 1f, _e9);
    let _e17: f32 = antialias(border_distance);
    let t: f32 = select((1f - step(0f, border_distance)), _e17, (_e3 < _e5));
    return vec4<f32>(color.xyz, saturate(((color.w * t) * nearest_border)));
}

fn draw_uinode_background(color_1: vec4<f32>, point_4: vec2<f32>, size_5: vec2<f32>, radius_3: vec4<f32>, border_2: vec4<f32>, flags_4: u32) -> vec4<f32> {
    let _e4: f32 = sd_inset_rounded_box(point_4, size_5, radius_3, border_2);
    let _e7: bool = enabled(flags_4, INVERT);
    let internal_distance: f32 = (_e4 * select(1f, -1f, _e7));
    let _e12: f32 = antialias(internal_distance);
    return vec4<f32>(color_1.xyz, saturate((color_1.w * _e12)));
}

@vertex 
fn vertex(@location(0) vertex_position: vec3<f32>, @location(1) vertex_uv: vec2<f32>, @location(2) vertex_color: vec4<f32>, @location(3) @interpolate(flat) flags: u32, @location(4) radius: vec4<f32>, @location(5) border: vec4<f32>, @location(6) size: vec2<f32>, @location(7) point: vec2<f32>) -> VertexOutput {
    var out: VertexOutput;

    out.uv = vertex_uv;
    let _e6: mat4x4<f32> = view.clip_from_world;
    out.position = (_e6 * vec4<f32>(vertex_position, 1f));
    out.color = vertex_color;
    out.flags = flags;
    out.radius = radius;
    out.size = size;
    out.border = border;
    out.point = point;
    let _e23: VertexOutput = out;
    return _e23;
}

@fragment 
fn fragment(in: VertexOutput) -> @location(0) vec4<f32> {
    let texture_color: vec4<f32> = textureSample(sprite_texture, sprite_sampler, in.uv);
    let _e10: bool = enabled(in.flags, TEXTURED);
    let color_2: vec4<f32> = select(in.color, (in.color * texture_color), _e10);
    let _e14: bool = enabled(in.flags, BORDER_ANY);
    if _e14 {
        let _e20: vec4<f32> = draw_uinode_border(color_2, in.point, in.size, in.radius, in.border, in.flags);
        return _e20;
    } else {
        let _e26: vec4<f32> = draw_uinode_background(color_2, in.point, in.size, in.radius, in.border, in.flags);
        return _e26;
    }
}
