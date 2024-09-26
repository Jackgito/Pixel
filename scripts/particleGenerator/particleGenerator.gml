
/// @description Creates and returns a particle type based on the provided particleData structure
function createParticleType(particleData) {
	// Create the particle type
	var ptype = part_type_create();
    
	// Set up the particle with the provided values
	part_type_shape(ptype, particleData.particleShape);  // Shape of the particle
	part_type_size(ptype, particleData.particleSize.min, particleData.particleSize.max, particleData.particleSize.change, 0);  // Size range
	part_type_speed(ptype, particleData.spd.min, particleData.spd.max, 0, particleData.spd.wiggle);  // Speed range
	part_type_direction(ptype, particleData.dir.min, particleData.dir.max, 0, 0);  // Direction range
	part_type_gravity(ptype, particleData.grav.amount, particleData.grav.dir);  // Gravity amount and direction
	part_type_colour3(ptype, particleData.colors[0], particleData.colors[1], particleData.colors[2]);  // Color range
	part_type_alpha3(ptype, particleData.alphas[0], particleData.alphas[1], particleData.alphas[2]);  // Alpha range for fading effect
	part_type_blend(ptype, particleData.blend);  // Blending mode
	part_type_life(ptype, particleData.lifetime.min, particleData.lifetime.max);  // Lifetime range

	return ptype;
}


/* Example:
particleConfig =  {
	trail: {
	    shape: pt_shape_ring,
	    size: {min: 0.2, max: 0.2, change: -0.01},
	    spd: {min: 3, max: 5},
	    dir: {min: currentDirection + 180, max: currentDirection + 180},
	    grav: {amount: 0, dir: 0},
	    colors: trailColors,
	    alphas: [0.9, 0.7, 0.1],
	    lifetime: {min: 50, max: 60},
	    blend: false
	},
	explosion: {
		shape: pt_shape_square,
	    size: {min: 0.2, max: 0.2, change: 0},
	    spd: {min: 8, max: 10},
	    dir: {min: 0, max: 360},
	    grav: {amount: 0, dir: 0},
	    colors: explosionColors,
	    alphas: [0.9, 0.7, 0.1],
	    lifetime: {min: 20, max: 30},
	    blend: false
	}
}
*/