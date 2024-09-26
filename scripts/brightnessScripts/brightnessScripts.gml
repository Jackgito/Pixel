// Script to apply the shader
function beginLayerBrightness() {
    // Activate the shader
    shader_set(shdrBrightness);

    // Set the brightness uniform (pass the global brightness variable)
    var brightnessLocation = shader_get_uniform(shdrBrightness, "brightness");
    shader_set_uniform_f(brightnessLocation, global.power);
}

function endLayerBrightness() {
    // Reset the shader after the layer is drawn
    shader_reset();
}