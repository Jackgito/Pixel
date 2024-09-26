// Stop rotation
phy_fixed_rotation = true; // Keep the button from rotating

if (global.power > 0) image_index = 1;

// Calculate the difference from the original position
var yDifference = originalY - y;
var xDifference = originalX - x;

// This value tries to move the button to the original position
var forceStrength = 50;

// Determine collisions based on rotation
var collidesWithDynamic = 0, collidesWithMarker = 0;
var colliderModifier = 5; // This is used to detect collision right before it happens

switch (dir) {
    case "left": // left
        collidesWithDynamic = collision_line(bbox_left - colliderModifier, bbox_top, bbox_left - colliderModifier, bbox_bottom, objDynamicParent, false, true);
        collidesWithMarker = collision_line(bbox_right + colliderModifier, bbox_top, bbox_right + colliderModifier, bbox_bottom, objMarkerButton, false, true);
		if (phy_position_x < originalX) phy_position_x = originalX; // Make sure the button doesn't move further than original location
        phy_position_y = originalY;
		break;
    
    case "right": // right
        collidesWithDynamic = collision_line(bbox_right + colliderModifier, bbox_top, bbox_right + colliderModifier, bbox_bottom, objDynamicParent, false, true);
        collidesWithMarker = collision_line(bbox_left - colliderModifier, bbox_top, bbox_left - colliderModifier, bbox_bottom, objMarkerButton, false, true);
		if (phy_position_x > originalX) phy_position_x = originalX;
		phy_position_y = originalY;
        break;
    
    case "down": // down
	    collidesWithDynamic = collision_line(bbox_left, bbox_bottom + colliderModifier, bbox_right, bbox_bottom + colliderModifier, objDynamicParent, false, true);
        collidesWithMarker = collision_line(bbox_left, bbox_top - colliderModifier, bbox_right, bbox_top - colliderModifier, objMarkerButton, false, true);
        if (phy_position_y > originalY) phy_position_y = originalY;
		phy_position_x = originalX;
		break;
    
    case "up": // up
        collidesWithDynamic = collision_line(bbox_left, bbox_top - colliderModifier, bbox_right, bbox_top - colliderModifier, objDynamicParent, false, true);
        collidesWithMarker = collision_line(bbox_left, bbox_bottom + colliderModifier, bbox_right, bbox_bottom + colliderModifier, objMarkerButton, false, true);
        if (phy_position_y < originalY) phy_position_y = originalY;
		phy_position_x = originalX;
		break;
}

// Check if button is pressed
if (collidesWithMarker) {
    isPressed = true;
} else {
    isPressed = false;
}

// Handle collision with dynamic objects and apply force
if (collidesWithDynamic) {
    collisionTimer = 10;
} else {
    collisionTimer--;

    // Only apply movement correction if the collision timer is inactive
    if (collisionTimer <= 0) {
        // Move the button back to its original position based on the current rotation
        switch (dir) {
            case "left": // left
                if (xDifference < 2) {
                    phy_position_x = originalX;
                    phy_linear_velocity_x = 0;
                }
                physics_apply_force(x, y, -xDifference * forceStrength, 0);
                break;

            case "right": // right
                if (xDifference < 2) {
                    phy_position_x = originalX;
                    phy_linear_velocity_x = 0;
                }
                physics_apply_force(x, y, xDifference * forceStrength, 0);
				break;

            case "up": // up
                if (yDifference < 2) {
                    phy_position_y = originalY;
                    phy_linear_velocity_y = 0;
                }
                physics_apply_force(x, y, 0, yDifference * forceStrength);
				break;

            case "down": // down
                if (yDifference < 2) {
                    phy_position_y = originalY;
                    phy_linear_velocity_y = 0;
                }
                physics_apply_force(x, y, 0, yDifference * forceStrength);
				break;
        }
    }
}