//amount = 10;
//shape = pt_shape_square;
//size = {min: 0.25, max: 0.35, change: -0.02, wiggle: 0};
//spd = {min: 6, max: 8, increase: -0.01, wiggle: 0};
//dir = {min: 0, max: 360, increase: 0, wiggle: 0};

// Create particle system and particles based on the configuration
function createParticles() {
    // Create a particle system
    particleSystem = part_system_create_layer("particles", false);

    // Create a particle type based on the configuration
    particleType = part_type_create();

    // Set the shape of the particle
    part_type_shape(particleType, shape);
    
    // Set the size of the particle (initial size and change over time)
    part_type_size(particleType, size.min, size.max, size.change, size.wiggle);

    // Set the speed of the particle (initial speed, max speed, and wiggle)
    part_type_speed(particleType, spd.min, spd.max, spd.increase, spd.wiggle);

    // Set the direction of the particle
    part_type_direction(particleType, dir.min, dir.max, dir.increase, dir.wiggle);

    // Set the gravity applied to the particle
    part_type_gravity(particleType, grav.amount, grav.dir);

    // Set the color transitions
    part_type_color3(particleType, colors[0], colors[1], colors[2]);

    // Set the alpha transitions (opacity)
    part_type_alpha3(particleType, alphas[0], alphas[1], alphas[2]);

    // Set the lifetime of the particle
    part_type_life(particleType, lifetime.min, lifetime.max);

    // Set blend mode
    part_type_blend(particleType, blend);

    // Create the particles at the object's position (x, y)
    part_particles_create(particleSystem, x, y, particleType, amount);

	alarm[0] = 120;
}

createParticles();