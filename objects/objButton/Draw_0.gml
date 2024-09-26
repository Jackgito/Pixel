var imageIndex = 0;
if (global.power > 0) imageIndex = 1;
if (global.colors) draw_sprite_ext(sprite_index, imageIndex, x, y, image_xscale, image_yscale, image_angle, glowColor, image_alpha);
else draw_sprite_ext(sprite_index, imageIndex, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);

//draw_set_color(c_red)
//draw_line(bbox_left, bbox_top, bbox_left, bbox_bottom)
//draw_line(bbox_right, bbox_top, bbox_right, bbox_bottom)
//draw_rectangle(bbox_left + 5, bbox_top - 3, bbox_right - 5, bbox_top - 3, true);
//draw_rectangle(bbox_left, bbox_bottom, bbox_right, bbox_bottom, true);

var margin = 5;