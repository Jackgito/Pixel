// Fragment Shader
varying vec2 v_vTexcoord;
uniform float brightness;  // Brightness value (0.0 = dark, 1.0 = normal)

void main() {
    gl_FragColor = vec4(1.0, 0.0, 0.0, 1.0); // Red color
}