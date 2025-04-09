global.power += 1;
audio_play_sound(sfxPowerOrb, 0, false, 1, 0, 0.4 + global.power * 0.15);
instance_destroy();