// LCD "OLED-like" grade: deeper blacks, S-curve contrast, restrained vibrance.
#version 300 es
precision highp float;

in vec2 v_texcoord;
layout(location = 0) out vec4 fragColor;
uniform sampler2D tex;

const float CONTRAST = 0.32;
const float VIBRANCE = 1.2;
const float BLACK_CRUSH = 0.022;
const float GAMMA = 1.055;

float luma(vec3 c) {
    return dot(c, vec3(0.2126, 0.7152, 0.0722));
}

void main() {
    vec4 pix = texture(tex, v_texcoord);
    vec3 c = clamp(pix.rgb, 0.0, 1.0);

    c = pow(c, vec3(GAMMA));

    vec3 s = c * c * (3.0 - 2.0 * c);
    c = mix(c, s, CONTRAST);

    c = max(c - vec3(BLACK_CRUSH), 0.0) / (1.0 - BLACK_CRUSH);

    float l = luma(c);
    float sat = max(max(c.r, c.g), c.b) - min(min(c.r, c.g), c.b);
    float vib = mix(VIBRANCE, 1.0, clamp(sat * 1.35, 0.0, 1.0));
    c = mix(vec3(l), c, vib);

    fragColor = vec4(clamp(c, 0.0, 1.0), pix.a);
}
