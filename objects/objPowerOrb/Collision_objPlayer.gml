global.power += 1;
audio_play_sound(sfxPowerOrb, 0, false, 1, 0, 0.5 + global.power * 0.1);
instance_destroy();