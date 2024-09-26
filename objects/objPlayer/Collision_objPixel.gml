pixelCounter++;
audio_play_sound(sfxPlayerJump, 0, false, 1, 0, pixelCounter * 0.9);
instance_destroy(other);