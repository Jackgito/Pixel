if (isPaused) {
	gpu_set_blendenable(false);
	surface_set_target(application_surface);
	if (surface_exists(pauseSurf)) draw_surface(pauseSurf, 0, 0);
	else {
		pauseSurf = surface_create(resW, resH);
		buffer_set_surface(pauseSurfBuffer, pauseSurf, 0);
	}
	surface_reset_target()
}

if (keyboard_check_pressed(vk_escape) && room == !roomMainMenu) {
	if (!isPaused) {
		isPaused = true;
		
		instance_deactivate_all(true);
		
		pauseSurf = surface_create(1920, 1080);
		surface_set_target(pauseSurf);
		draw_surface(application_surface, 0, 0);
		surface_reset_target();
		
		// Backup surface
		if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);
		pauseSurfBuffer = buffer_create(resW * resH * 4, buffer_fixed, 1);
		buffer_get_surface(pauseSurfBuffer, pauseSurf, 0);
	} else { // Unpause
		gpu_set_blendenable(true);
		isPaused = false;
		instance_activate_all();
		if (surface_exists(pauseSurf)) surface_free(pauseSurf);
		if (buffer_exists(pauseSurfBuffer)) buffer_delete(pauseSurfBuffer);	
	}
}
