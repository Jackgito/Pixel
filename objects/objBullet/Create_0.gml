var fixture = physics_fixture_create();
physics_fixture_set_circle_shape(fixture, 4);
physics_fixture_set_density(fixture, 0.01);
physics_fixture_set_restitution(fixture, 0.1);
physics_fixture_set_friction(fixture, 0.2);
physics_fixture_bind(fixture, id);
physics_fixture_delete(fixture);

damageAmount = 1;

// Calculate the direction to the target
// Get the direction towards the player
playerDirection = point_direction(x, y + 16, targetX, targetY);

// Calculate the velocity components
var velX = lengthdir_x(bulletSpeed, playerDirection);
var velY = lengthdir_y(bulletSpeed, playerDirection);

// Apply an impulse to the bullet to move it towards the player
physics_apply_impulse(x, y, velX, velY);


// Set the lifetime of the trail
lifetime = 180;
alphaValue = 0.8;  // Initial opacity

// Calculate the current direction of the object
var currentDirection = point_direction(0, 0, phy_linear_velocity_x, phy_linear_velocity_y);
var trailColors = [NEON_RED_MID, NEON_ORANGE_MID, NEON_YELLOW_LIGHT];
var explosionColors = [NEON_RED_MID, NEON_ORANGE_MID, NEON_YELLOW_LIGHT];

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