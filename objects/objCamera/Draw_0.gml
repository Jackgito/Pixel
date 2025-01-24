//if (!global.colors) shader_set(shdrDesaturation);
//else shader_reset();

// Check if the surface is valid, and create it if not
if (!surface_exists(surfaceDarkness)) surfaceDarkness = surface_create(room_width, room_height);

// Set the target to the surface and clear it with black
surface_set_target(surfaceDarkness);
draw_clear_alpha(c_black, 1);

// Set the blending mode for subtracting light
gpu_set_blendmode(bm_subtract);

// Draw radial gradient light around the player using the gradient sprite
var lightX = prevX;
var lightY = prevY;

if instance_exists(objPlayer) {
	lightX = objPlayer.x - camera_get_view_x(view_camera[0]);
	lightY = objPlayer.y - camera_get_view_y(view_camera[0]);
	prevX = lightX;
	prevY = lightY
	var lightScale = 1+ objPlayer.size + global.power;
	draw_sprite_ext(sprLightGradient, 0, lightX, lightY, lightScale, lightScale, 0, c_white, 0.6 + global.power * 0.1);
}

// Reset the blend mode and surface target
gpu_set_blendmode(bm_normal);
surface_reset_target();

// Draw the surface with darkness on the screen
draw_surface(surfaceDarkness, camera_get_view_x(view_camera[0]), camera_get_view_y(view_camera[0]));