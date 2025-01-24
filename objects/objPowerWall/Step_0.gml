// Move the door if power is sufficient
var moveSpeed = 2;
if (global.power >= requiredPower) {
    phy_speed_x = 0; // Reset speed after move distance has reached
    if (distance_to_point(originalX, originalY) < moveDistance) {
		if (!audio_is_playing(sfxWallMove)) audio_play_sound_at(sfxWallMove, x, y, 0, 100, 100, 1, false, 1);
        switch (unlockDirection) {
            case "right":
                moveDistance = sprite_width + 2;
                phy_speed_x = moveSpeed;
                break;

            case "left":
                moveDistance = sprite_width + 2;
                phy_speed_x = -moveSpeed;
                break;

            case "up":
                moveDistance = sprite_height + 2;
                phy_speed_y = -moveSpeed;
                break;

            case "down":
                moveDistance = sprite_height + 2;
                phy_speed_y = moveSpeed;
                break;
        }
    }
	else { audio_stop_sound(sfxWallMove) }
}

//if (phy_speed > 1 && !audio_is_playing(sfxWallMove)) audio_play_sound_at(sfxWallMove, x, y, 0, 100, 100, 1, false, 1);