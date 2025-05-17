var glowColor = NEON_ORANGE_MID;
if (global.colors) draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, glowColor, image_alpha);
else draw_sprite_ext(sprite_index, 0, x, y, image_xscale, image_yscale, image_angle, c_white, image_alpha);

