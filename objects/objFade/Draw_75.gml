draw_set_alpha(alpha);
draw_set_color(color);
draw_rectangle(0, 0, display_get_width(), display_get_height(), false);  // Draw full-screen rectangle
draw_set_alpha(1);
draw_set_color(c_white);