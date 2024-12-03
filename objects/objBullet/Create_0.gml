var fixture = physics_fixture_create();
physics_fixture_set_circle_shape(fixture, 4);
physics_fixture_set_density(fixture, 0.01);
physics_fixture_set_restitution(fixture, 0.1);
physics_fixture_set_friction(fixture, 0.2);
physics_fixture_bind(fixture, id);
physics_fixture_delete(fixture);

damageAmount = 1;

// Calculate the direction to the target
playerDirection = point_direction(x, y, targetX, targetY);
phy_linear_velocity_x = lengthdir_x(bulletSpeed, playerDirection);
phy_linear_velocity_y = lengthdir_y(bulletSpeed, playerDirection);

// Set the lifetime of the trail
lifetime = 180;
alphaValue = 0.8;  // Initial opacity

// Calculate the current direction of the object
var currentDirection = point_direction(0, 0, phy_linear_velocity_x, phy_linear_velocity_y);
var trailColors = [NEON_RED_MID, NEON_ORANGE_MID, NEON_YELLOW_LIGHT];
var explosionColors = [NEON_RED_MID, NEON_ORANGE_MID, NEON_YELLOW_LIGHT];

function explosionHit() {
	// Explosion force
	part_particles_create(particleSystem, x, y, explosionParticle, 5);

	with (parentDynamic) {

	    // Calculate the distance between the explosion (other) and the object
	    var dist = point_distance(x, y, other.x, other.y);
		var maxForce = sprite_width * 20;
    
	    // Only apply force if within 100 pixels
	    if (dist <= 100) {
        
	        // Calculate direction
	        var dir = point_direction(x, y, other.x, other.y);

	        // Scale force based on distance (closer objects receive more force)
	        var force = maxForce / dist

	        // Calculate force components based on direction and apply the force
	        var dirX = lengthdir_x(force, dir) * -1;
	        var dirY = lengthdir_y(force, dir) * -1;
        
	        // Apply the force
	        physics_apply_impulse(x, y, dirX, dirY);
	    }
	}
	
	//instance_create_layer(x, y, "particles", objParticleBurst);
	instance_destroy(self);	
}

particleSystem = part_system_create_layer("Particles", false);
particleConfig =  {
	trail: {
	    particleShape: pt_shape_ring,
	    particleSize: {min: 0.05, max: 0.1, change: -0.02},
	    spd: {min: 3, max: 5, wiggle: 0},
	    dir: {min: currentDirection + 180, max: currentDirection + 180},
	    grav: {amount: 0, dir: 0},
	    colors: trailColors,
	    alphas: [0.9, 0.7, 0.1],
	    lifetime: {min: 20, max: 25},
	    blend: false
	},
	explosion: {
		particleShape: pt_shape_square,
	    particleSize: {min: 0.1, max: 0.2, change: -0.01},
	    spd: {min: 4, max: 6, wiggle: 0},
	    dir: {min: 0, max: 360},
	    grav: {amount: 0, dir: 0},
	    colors: explosionColors,
	    alphas: [0.9, 0.7, 0.1],
	    lifetime: {min: 15, max: 25},
	    blend: false
	}
}

trailParticle = createParticleType(particleConfig.trail);
explosionParticle = createParticleType(particleConfig.explosion);