//show_debug_message(menuState)
//if (menuState) == "Start game" { 
//	with (objWorldMap) startDrawing = true; 
//			show_debug_message("HELLO")
//	}

// Ambient particles
part_emitter_region(particleSystem, particleEmitter, 0, room_width, 0, room_height, ps_shape_rectangle, ps_distr_linear);
part_emitter_stream(particleSystem, particleEmitter, ambientParticle, choose(0, 0, 1));