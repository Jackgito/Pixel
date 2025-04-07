particleSystem = part_system_create_layer("Particles", false);
partType = part_type_create();

audioEmitter = audio_emitter_create();
audio_falloff_set_model(audio_falloff_linear_distance);
audio_emitter_falloff(audioEmitter, 50, 250, 1);
audio_emitter_position(audioEmitter, x, y, 0);

laserContactPoint1 = 0;
laserContactPoint2 = 0;
laserWidth = random_range(laserSize - 1, laserSize + 1);

laserSound = audio_play_sound_on(audioEmitter, sfxLaser, false, 1);
audio_sound_loop_start(laserSound, 2);
audio_sound_loop_end(laserSound, 5);

startingX = phy_position_x;
startingY = phy_position_y;
