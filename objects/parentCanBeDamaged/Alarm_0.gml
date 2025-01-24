/// @description Handle damage

if (alarm_get(0) = 30) { // Red damage effect and screenshake for player
	image_blend = NEON_RED_DARK;
		
	if (object_index == objPlayer) {
		screenShake(30);
		invulnerable = true;
	}
		
}
else if (alarm_get(0) == 0) { // Reset damage effects
	image_blend = c_white;
	invulnerable = false;
}
	



