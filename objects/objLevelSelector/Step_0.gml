// Move to target room when this is clicked
if (mouse_check_button_pressed(mb_left) && position_meeting(mouse_x, mouse_y, id)) {
    
	if (isUnlocked) {
		audio_play_sound(sfxClick, 1, false);
		musicManager.playMusic("gameplay");
		with (objFade) fadeToRoom(other.targetRoom);
	} else {
		audio_play_sound(sfxError, 0, false);
	}
}

hoverEffect();