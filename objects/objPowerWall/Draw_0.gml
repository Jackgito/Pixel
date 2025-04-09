var doorWidth = sprite_width;
var doorHeight = sprite_height;
var barWidth = sprite_width * 0.8;
var powerProgress = global.power / requiredPower;

if (powerProgress > 1) powerProgress = 1;

// Draw the door
var imageIndex = 0;
var glowColor = DARKEST_GRAY;
draw_self()
var borderWidth = 4;
var margin = 0;
var color = NEON_GREEN_DARK;

if (orientation == "horizontal") {
    margin = sprite_height * 0.15;

    // Adjust the bar length based on the margin and border width
    var barLength = (bbox_right - bbox_left - 2 * margin - 2 * borderWidth) * powerProgress;  // Ensure the bar length fits inside the border

    // Progress bar border
    //draw_rectangle_color(bbox_left + margin - borderWidth, bbox_top - margin - borderWidth, 
    //                     bbox_right - margin + borderWidth, bbox_bottom + margin + borderWidth, 
    //                     glowColor, glowColor, glowColor, glowColor, false);
    
    if (global.power > 0) {
        // Progress bar (filled part)
        draw_rectangle_color(bbox_left + margin, bbox_top + margin, 
                             bbox_left - margin + barLength, bbox_bottom - margin - 4, 
                             color, color, color, color, false);
    }
} else if (orientation == "vertical") {
    margin = sprite_width * 0.15;

    // Adjust the bar height based on the margin and border width
    var barLength = (bbox_bottom - bbox_top - 2 * margin - 2 * borderWidth) * powerProgress;  // Ensure the bar height fits inside the border

    // Progress bar border
    //draw_rectangle_color(bbox_left + margin - borderWidth, bbox_top + margin - borderWidth, 
    //                     bbox_right - margin + borderWidth, bbox_bottom - margin + borderWidth, 
    //                     glowColor, glowColor, glowColor, glowColor, false);
    
    if (global.power > 0) {
        // Progress bar (filled part)
        draw_rectangle_color(bbox_left + margin, bbox_bottom - margin - barLength, 
                             bbox_right - margin - 4, bbox_bottom - margin, 
                             color, color, color, color, false);
    }
}
