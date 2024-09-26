var doorWidth = sprite_width;
var doorHeight = sprite_height;
var barWidth = sprite_width * 0.8;

//// Draw the door
var imageIndex = 0;
var glowColor = c_white;
if (global.power > 0) imageIndex = 1;

// Draw the door sprite with the desaturation shader
draw_sprite_ext(sprite_index, imageIndex, x, y, image_xscale, image_yscale, image_angle, glowColor, image_alpha);

var borderWidth = 4;
var margin = 0;
var color = NEON_GREEN_DARK;
//if (orientation == "horizontal") {
//    margin = sprite_width * 0.05;
//    var barLength = (bbox_right - bbox_left - 2 * margin) * powerProgress;  // Calculate bar length based on power

//    // Progress bar border
//    draw_rectangle_color(bbox_left + margin - borderWidth, bbox_top + margin - borderWidth, 
//                         bbox_right - margin + borderWidth, bbox_bottom - margin + borderWidth, 
//                         glowColor, glowColor, glowColor, glowColor, false);
    
//    // Progress bar (filled part)
//    draw_rectangle_color(bbox_left + margin, bbox_top + margin, 
//                         bbox_left + margin + barLength, bbox_bottom - margin, 
//                         color, color, color, color, false);
//} else if (orientation == "vertical") {
//    margin = sprite_height * 0.05;
//    var barLength = (bbox_bottom - bbox_top - 2 * margin) * powerProgress;  // Calculate bar height based on power

//    // Progress bar border
//    draw_rectangle_color(bbox_left + margin - borderWidth, bbox_top + margin - borderWidth, 
//                         bbox_right - margin + borderWidth, bbox_bottom - margin + borderWidth, 
//                         glowColor, glowColor, glowColor, glowColor, false);
    
//    // Progress bar (filled part)
//    draw_rectangle_color(bbox_left + margin, bbox_bottom - margin - barLength, 
//                         bbox_right - margin, bbox_bottom - margin, 
//                         color, color, color, color, false);
//}

// Move the door if power is sufficient
with (objButton) {
    if (other.wallID == buttonID) {
        other.buttonPressed = isPressed;
    }
}

// Reset speed after move distance has reached
phy_speed_x = 0;
phy_speed_y = 0;

var moveSpeed = 3;

// Helper function to move towards a target within a limited distance
function moveTowards(currentPos, targetPos, speed) {
    var delta = targetPos - currentPos;
    if (abs(delta) > speed) {
        return (delta > 0 ? speed : -speed); // Move towards the target
    } 
    return 0; // Stop when close enough to the target
}

if (global.power = 0) exit;
// If button is not pressed, move back to the original position (ignore max distance)
if (buttonPressed == 0) {
    phy_speed_x = moveTowards(x, originalX, moveSpeed);
    phy_speed_y = moveTowards(y, originalY, moveSpeed);
} else { 
    // Continue with normal directional movement but respect max distance
    switch (unlockDirection) {
        case "right":
            moveDistance = sprite_width;
            if (x < originalX + moveDistance) { // Cap movement to sprite width
                phy_speed_x = moveSpeed * buttonPressed;
            } else {
                phy_speed_x = 0; // Stop when maximum distance is reached
            }
            phy_speed_y = 0; // Only move horizontally
            break;

        case "left":
            moveDistance = sprite_width;
            if (x > originalX - moveDistance) { // Cap movement to sprite width
                phy_speed_x = -moveSpeed * buttonPressed;
            } else {
                phy_speed_x = 0; // Stop when maximum distance is reached
            }
            phy_speed_y = 0; // Only move horizontally
            break;

        case "down":
            moveDistance = sprite_height;
            if (y < originalY + moveDistance) { // Cap movement to sprite height
                phy_speed_y = moveSpeed * buttonPressed;
            } else {
                phy_speed_y = 0; // Stop when maximum distance is reached
            }
            phy_speed_x = 0; // Only move vertically
            break;

        case "up":
            moveDistance = sprite_height;
            if (y > originalY - moveDistance) { // Cap movement to sprite height
                phy_speed_y = -moveSpeed * buttonPressed;
            } else {
                phy_speed_y = 0; // Stop when maximum distance is reached
            }
            phy_speed_x = 0; // Only move vertically
            break;
    }
}