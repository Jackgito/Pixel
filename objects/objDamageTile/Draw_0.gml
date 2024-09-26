// Draw the tile with the pulsating brightness effect
draw_self();

// Apply the brightness effect by modulating color or alpha
var brightness = random_range(0.6, 0.9);
var color_mod = make_color_rgb(255, 255 * brightness, 255 * brightness);
draw_set_color(color_mod);

draw_self();

// Reset color to default
draw_set_color(c_white);