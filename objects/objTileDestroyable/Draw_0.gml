var imageIndex = 0;
var glowColor = NEON_ORANGE_MID;
if (global.power > 0) imageIndex = 1;
if (global.colors) draw_sprite_ext(sprite_index, imageIndex, x, y, image_xscale, image_yscale, image_angle, glowColor, image_alpha);
else draw_sprite_ext(sprite_index, imageIndex, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);

