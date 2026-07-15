#version 460 core
struct FullscreenVertexOutput {
    vec4 position;
    vec2 uv;
};
layout(location = 0) smooth out vec2 _vs2fs_location0;

void main() {
    uint vertex_index = uint(gl_VertexID);
    vec2 uv = (vec2(float((vertex_index >> 1u)), float((vertex_index & 1u))) * 2.0);
    vec4 clip_position = vec4(((uv * vec2(2.0, -2.0)) + vec2(-1.0, 1.0)), 0.0, 1.0);
    FullscreenVertexOutput _tmp_return = FullscreenVertexOutput(clip_position, uv);
    gl_Position = _tmp_return.position;
    _vs2fs_location0 = _tmp_return.uv;
    return;
}
