/// @description Handle damage

if (alarm_get(0) = 30) {
	image_blend = NEON_RED_DARK;
		
	if (object_index == objPlayer) {
		screenShake(30);
		invulnerable = true;
	}
		
}
else if (alarm_get(0) == 0) {
	image_blend = c_white;
	invulnerable = false;
}
	



