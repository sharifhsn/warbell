#version 460

const vec4 positions[3] = vec4[](
    vec4( 0.0, +1.0, 0.0, 1.0),
    vec4(-1.0, -1.0, 0.0, 1.0),
    vec4(+1.0, -1.0, 0.0, 1.0)
);

const vec4 colors[3] = vec4[](
    vec4(1.0, 0.0, 0.0, 1.0),
    vec4(0.0, 1.0, 0.0, 1.0),
    vec4(0.0, 0.0, 1.0, 1.0)
);

layout(location = 0) out vec4 out_color;

void main() {
    gl_Position = positions[gl_VertexID];
    out_color = colors[gl_VertexID];
}
