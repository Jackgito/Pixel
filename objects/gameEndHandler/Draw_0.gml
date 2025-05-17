// Get center of camera view
var cam = view_camera[0];
var cx = camera_get_view_x(cam) + camera_get_view_width(cam) / 2;
var cy = camera_get_view_y(cam) + camera_get_view_height(cam) / 2;

// Set the font and alignment
draw_set_font(fontMedium);
draw_set_halign(fa_center);
draw_set_valign(fa_middle);

// Calculate alpha for fade-in (max 1 when fully faded in)
var alpha1 = clamp((messageTimer - 40) / 60, 0, 1); // Fade in over 1 second
var alpha2 = clamp((messageTimer - 180) / 60, 0, 1); // Fade in for second message

// Apply alpha before drawing text
draw_set_alpha(alpha1);
if (messageTimer >= 40) {
    draw_text(cx, cy - 40, "You escaped the Void!");
}

draw_set_alpha(alpha2);
if (messageTimer >= 180) {
    draw_text(cx, cy + 40, "The End");
}

// Reset alpha to 1 for the rest of the drawing
draw_set_alpha(1);

// Trigger the fade to the next room after the text fades in
if (messageTimer == 460) {
	with (objFade) {
	    fadeToRoom(roomMainMenu, 120, c_white);
	}
}
