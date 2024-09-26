/// @function dragLightOrb(size, angle, distanceFromParent, color, flickerRange, flickerSpeed)
/// @param size The size of the light orb sprite
/// @param angle The angle of the light orb relative to the parent
/// @param distanceFromParent The distance from the parent object where the light orb should appear
/// @param color The color of the light orb
/// @param flickerRange The range of alpha values for flicker effect
/// @param flickerSpeed The speed of the flicker effect

function drawLightOrb(size, angle, distanceFromParent, color, flickerRange, flickerSpeed, alpha) {
    // Declare local variables for flicker effect
    var targetAlpha = alpha;

    // Smoothly transition alpha for the flicker effect
    if (abs(targetAlpha - alpha) < 0.01) {
        targetAlpha = 1.0 - random(flickerRange);  // Set new target alpha for flicker
    }

    //alpha = lerp(alpha, targetAlpha, flickerSpeed);  // Flicker transition

    // Calculate the position for the light orb

	var orbX = x - lengthdir_x(distanceFromParent, image_angle + angle);
	var orbY = y - lengthdir_y(distanceFromParent, image_angle + angle);

    // Set the color and alpha for drawing
    draw_set_color(color);
    draw_set_alpha(alpha);

    // Draw the sprite of the light orb
    draw_sprite_ext(sprLightGradient, 0, orbX, orbY, size, size, 0, color, alpha);
	
    // Reset the color and alpha
    draw_set_color(c_white);
    draw_set_alpha(1);
}