// Draw the moving line at the current position
draw_set_color(c_white);
draw_line_width(x, y, x + 5, y, 5);  // 5-pixel wide, 1-pixel high line

// Draw the fading tail
for (var i = 1; i < tailLength; i++) {
    var alpha = 1 - (i / tailLength);  // Decrease alpha for fading effect
    draw_set_alpha(alpha);  // Set transparency based on tail position
    
    // Draw the fading part of the tail
    draw_line_width(tail[i][0], tail[i][1], tail[i][0] + 5, tail[i][1], 5);
}

// Reset alpha to fully opaque
draw_set_alpha(1);