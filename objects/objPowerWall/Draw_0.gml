var doorWidth = sprite_width;
var doorHeight = sprite_height;
var barWidth = sprite_width * 0.8;
var powerProgress = global.power / requiredPower;

if (powerProgress > 1) powerProgress = 1;

//// Draw the door
var imageIndex = 0;
var glowColor = MEDIUM_GRAY;
if (global.power > 0) imageIndex = 1;

// Draw the door sprite with the desaturation shader
draw_sprite_ext(sprite_index, imageIndex, x, y, image_xscale, image_yscale, image_angle, glowColor, image_alpha);

var borderWidth = 4;
var margin = 0;
var color = NEON_GREEN_DARK;
if (orientation == "horizontal") {
    margin = sprite_width * 0.05;
    var barLength = (bbox_right - bbox_left - 2 * margin) * powerProgress;  // Calculate bar length based on power

    // Progress bar border
    draw_rectangle_color(bbox_left + margin - borderWidth, bbox_top + margin - borderWidth, 
                         bbox_right - margin + borderWidth, bbox_bottom - margin + borderWidth, 
                         glowColor, glowColor, glowColor, glowColor, false);
    
    // Progress bar (filled part)
    draw_rectangle_color(bbox_left + margin, bbox_top + margin, 
                         bbox_left + margin + barLength, bbox_bottom - margin, 
                         color, color, color, color, false);
} else if (orientation == "vertical") {
    margin = sprite_height * 0.05;
    var barLength = (bbox_bottom - bbox_top - 2 * margin) * powerProgress;  // Calculate bar height based on power

    // Progress bar border
    draw_rectangle_color(bbox_left + margin - borderWidth, bbox_top + margin - borderWidth, 
                         bbox_right - margin + borderWidth, bbox_bottom - margin + borderWidth, 
                         glowColor, glowColor, glowColor, glowColor, false);
    
    // Progress bar (filled part)
    draw_rectangle_color(bbox_left + margin, bbox_bottom - margin - barLength, 
                         bbox_right - margin, bbox_bottom - margin, 
                         color, color, color, color, false);
}

// Move the door if power is sufficient
var moveSpeed = 3;
if (global.power >= requiredPower) {
    phy_speed_x = 0; // Reset speed after move distance has reached
    if (distance_to_point(originalX, originalY) < moveDistance) {
        switch (unlockDirection) {
            case "right":
                moveDistance = sprite_width + 2;
                phy_speed_x = moveSpeed;
                break;

            case "left":
                moveDistance = sprite_width + 2;
                phy_speed_x = -moveSpeed;
                break;

            case "up":
                moveDistance = sprite_height + 2;
                phy_speed_y = -moveSpeed;
                break;

            case "down":
                moveDistance = sprite_height + 2;
                phy_speed_y = moveSpeed;
                break;
        }
    }
}
