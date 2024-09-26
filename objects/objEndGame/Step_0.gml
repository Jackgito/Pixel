if (global.music) audio_group_set_gain(audioGroupMusic, 0, 50);
if (global.sounds) audio_group_set_gain(audioGroupSfx, 0, 50);
with(objFade) {
	fadeIn = true;
	targetAlpha = 1;
	fadeSpeed = 0.05;
}
timer--;
if (timer == 0) game_end();