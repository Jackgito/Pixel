// Shaders are drawn onto this surface
if (!surface_exists(screenSurface))
{
    screenSurface = surface_create(window_get_width(), window_get_height());
}

// Set the target surface to the screenSurface
surface_set_target(screenSurface);

// Clear the surface (optional, for safety)
draw_clear_alpha(c_black, 0.1);

// Draw the entire scene to the surface (you can draw everything here)
// For example, you might want to draw the background, objects, or any layers here
draw_self(); // Or use `draw_sprite()` or any other drawing functions

// Reset the target back to the default (the screen)
surface_reset_target();

// Apply the glow shader
//gpu_set_blendmode(bm_add);
gpu_set_blendmode(bm_add);
//shader_set(shdrGlow);

// Send power-based intensity (clamped)
glowIntensity = lerp(glowIntensity, global.power / 100, 0.01);
shader_set_uniform_f(shader_get_uniform(shdrTint, "u_glowIntensity"), glowIntensity);

// Draw the surface with the glow effect applied
draw_surface(screenSurface, 0, 0);

// Reset shader after drawing
shader_reset();
gpu_set_blendmode(bm_normal);