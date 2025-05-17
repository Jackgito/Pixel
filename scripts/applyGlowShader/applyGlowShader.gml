/// @function applyGlowShader()
/// @description Applies a glow-like effect based on pixel brightness and global.power

function applyGlowShader() {
    shader_set(shdrTint);

    // Send power-based intensity (clamped)
    var intensity = clamp(global.power * 0.01, 0.0, 2.0);
    shader_set_uniform_f(shader_get_uniform(shdrTint, "u_glowIntensity"), intensity);
}
