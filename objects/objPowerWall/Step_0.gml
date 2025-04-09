// Move the door if power is sufficient
var moveSpeed = 2;
if (global.power >= requiredPower) {

	if (distance_to_point(originalX, originalY) < moveDistance) {
		
		var pitch = 1;
		if (sprite_width > 128 || sprite_height > 128) pitch = 0.85;
		if (!audio_is_playing(sfxWallMove)) {
			moveSoundID = audio_play_sound_at(sfxWallMove, x, y, 0, 100, 100, 1, false, 1, 1, 0, pitch);
		}
		
		switch (unlockDirection) {
			case "right":  phy_speed_x = moveSpeed;  break;
			case "left":   phy_speed_x = -moveSpeed; break;
			case "up":     phy_speed_y = -moveSpeed; break;
			case "down":   phy_speed_y = moveSpeed;  break;
		}
	} else if (!hasStopped)  { // Movement finished, stop and silence sound
		// Stop once reached target
		phy_speed_x = 0;
		phy_speed_y = 0;

	    // Fade out the sound gradually
		audio_sound_gain(moveSoundID, 0, 120);
		hasStopped = true;
	}
}
