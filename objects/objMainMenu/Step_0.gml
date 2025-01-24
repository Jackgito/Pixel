if (menuState != "Start game") instance_destroy(objLevelSelector);

// Ambient particles
part_emitter_region(particleSystem, particleEmitter, 0, room_width, 0, room_height, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(particleSystem, particleEmitter, ambientParticle, choose(0, 0, 1));