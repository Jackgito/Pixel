cameraTrailSpeed = 0.1;
surfaceDarkness = -1;
prevX = 0;
prevY = 0;
camWidth = 480
camHeight = 270;
finalCamX = clamp(objPlayer.x - camWidth / 2, 0, room_width - camWidth);
finalCamY = clamp(objPlayer.y - camHeight * 2, 0, room_height - camHeight);
camX = 0;

// Create particle type
particleSystem = part_system_create();
particleEmitter = part_emitter_create(particleSystem);
ambientParticle = part_type_create();

// Set up particle appearance and behavior
part_type_shape(ambientParticle, pt_shape_square);
part_type_size(ambientParticle, 0, 0, 0.0005, 0);
part_type_color1(ambientParticle, make_color_rgb(200, 200, 200)); // Monochromatic color (light grey)
part_type_alpha3(ambientParticle, 1, 0.5, 0); // Fade over time
part_type_speed(ambientParticle, 0.1, 0.5, 0, 0); // Small random speed
part_type_direction(ambientParticle, 0, 360, 0, 0); // Move in any direction
part_type_life(ambientParticle, 60, 240); // Lifetime of particles
part_type_gravity(ambientParticle, 0.001, 90); // Small gravity for subtle drift

function ambientParticles() {
	
    // Get camera coordinates and dimensions
    var camX = camera_get_view_x(view_camera[0]);
    var camY = camera_get_view_y(view_camera[0]);
    var camW = camera_get_view_width(view_camera[0]);
    var camH = camera_get_view_height(view_camera[0]);

    // Set the spawn area to be the camera view + 100 pixels in each direction
    var spawnXMin = camX - 300;
    var spawnXMax = camX + camW + 300;
    var spawnYMin = camY - 300;
    var spawnYMax = camY + camH + 300;

    // Update the emitter region to match the camera's view
    part_emitter_region(particleSystem, particleEmitter, spawnXMin, spawnXMax, spawnYMin, spawnYMax, ps_shape_rectangle, ps_distr_linear);

    // Control particle emission rate
    part_emitter_stream(particleSystem, particleEmitter, ambientParticle, irandom(1));
}




