if (textTimer > 0) {
    // Get the camera view dimensions
    var viewX = camera_get_view_x(view_camera[0]);
    var viewY = camera_get_view_y(view_camera[0]);
    var viewWidth = camera_get_view_width(view_camera[0]);
    var viewHeight = camera_get_view_height(view_camera[0]);

    // Calculate center position
    var centerX = viewX + viewWidth / 2;
    var centerY = viewY + viewHeight / 4;

    // Calculate alpha for fade-in and fade-out
    var alpha = 1; // Fully visible by default
	var fadeDuration = 100;
    if (textTimer > textDuration + fadeDuration) {
        // Fade-in phase
        alpha = 1 - ((textTimer - textDuration - fadeDuration) / fadeDuration);
    } else if (textTimer < fadeDuration) {
        // Fade-out phase
        alpha = textTimer / fadeDuration;
    }

    // Set alpha and draw text
    draw_set_alpha(alpha);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);
    draw_set_color(c_white);
	draw_set_font(fontMedium);
    draw_text(centerX, centerY, text);
	draw_set_font(fontMain);
    draw_set_alpha(1);
    draw_set_color(c_black);

    // Decrease the timer
    textTimer--;
}
