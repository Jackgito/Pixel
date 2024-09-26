function takeDamage(damageAmount = 1, screenShake = false, damageColor = NEON_RED_DARK,  timeStop = 60) {
    if (!variable_instance_exists(self, "invulnerable") || invulnerable) exit
	hp -= damageAmount;
	if (hp < 1) {
        return 0;
    }
	
	audio_play_sound(sfxHurt, 1, false);
	image_blend = damageColor;
	if (screenShake) layer_set_visible("Shake", true);
	invulnerable = true;
	alarm[0] = 20;
	show_debug_message("DAMAG")
	return 1;
}

// Reset damage
//image_blend = c_white;

//// Turn off screen shake layer
//layer_set_visible("Shake", false);

//// Remove invulnerability
//invulnerable = false;

//// Optionally: Reset the game speed back to normal if you changed it
//game_set_speed(fps, fps);