isUnlocked = isLevelUnlocked(levelName);

hovered = false;    // Whether the mouse is hovering
hoverSpeed = 0.1;   // Speed of scaling effect
hoverScale = 1;
hoverBrightness = isUnlocked ? 1 : 0.5; // If not unlocked, dim the sprite

// Scale variables
targetScale = 2; // The target scale (1 = normal size)
image_xscale = targetScale;
image_yscale = targetScale;
scaleSpeed = 0.1; // The speed of scaling animation


function hoverEffect() {
	// Check if the mouse is hovering over the object
	if (position_meeting(mouse_x, mouse_y, id)) {
	    targetScale = 2.2; // Increase size to 120%
	} else {
	    targetScale = 2; // Return to normal size
	}

	// Smoothly interpolate scale
	image_xscale = lerp(image_xscale, targetScale, scaleSpeed);
	image_yscale = lerp(image_yscale, targetScale, scaleSpeed);
}
