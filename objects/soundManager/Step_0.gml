if (global.music) {
	if (!audio_is_playing(musMain)) audio_play_sound(musMain, 10, true);
	audio_group_set_gain(audioGroupMusic, 1, 60);
}
else {
	audio_stop_sound(musMain);
	audio_group_set_gain(audioGroupMusic, 0, 60);
}

if (global.sounds) audio_group_set_gain(audioGroupSfx, 1, 60);
else audio_group_set_gain(audioGroupSfx, 0, 60);