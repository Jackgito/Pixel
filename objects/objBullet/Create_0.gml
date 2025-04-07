var fixture = physics_fixture_create();
physics_fixture_set_circle_shape(fixture, 4);
physics_fixture_set_density(fixture, 0.01);
physics_fixture_set_restitution(fixture, 0.1);
physics_fixture_set_friction(fixture, 0.2);
physics_fixture_bind(fixture, id);
physics_fixture_delete(fixture);

damageAmount = 1;

// Calculate the direction to the target
playerDirection = point_direction(x, y, objPlayer.x, objPlayer.y -5);
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

	with (other) {

	    // Calculate the distance between the explosion (other) and the object
	    var dist = point_distance(x, y, other.x, other.y);
		var maxForce = 900;
    
	    // Only apply force if within 150 pixels
	    if (dist <= 150) {
        
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
	
	//instance_create_layer(x, y, "particles", objParticleBurst); // Explosion particles
	instance_destroy(self);	
}

particleSystem = part_system_create_layer("Particles", false);
particleConfig =  {
	trail: {
	    particleShape: pt_shape_ring,
	    particleSize: {min: 0.05, max: 0.2, change: -0.01},
	    spd: {min: 1, max: 2, wiggle: 0},
	    dir: {min: currentDirection + 180, max: currentDirection + 180},
	    grav: {amount: 0, dir: 0},
	    colors: trailColors,
	    alphas: [0.9, 0.7, 0.1],
	    lifetime: {min: 20, max: 35},
	    blend: false
	}
}

trailParticle = createParticleType(particleConfig.trail);