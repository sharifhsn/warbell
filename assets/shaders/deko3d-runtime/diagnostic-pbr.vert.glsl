#version 460 core

layout(location = 0) in vec3 position;
layout(location = 1) in vec3 normal;
layout(location = 2) in vec2 uv;

layout(location = 0) smooth out vec4 world_position;
layout(location = 1) smooth out vec3 world_normal;
layout(location = 2) smooth out vec2 out_uv;
layout(location = 6) flat out uint instance_index;

void main() {
    gl_Position = vec4(position.x * 0.16, position.y * 0.25 + position.z * 0.16, 0.5, 1.0);
    world_position = vec4(position, 1.0);
    world_normal = normal;
    out_uv = uv;
    instance_index = 0u;
}
