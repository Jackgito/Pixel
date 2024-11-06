// Size variables
image_xscale = 0;
image_yscale = 0;
size = 1;
lastSize = 1;
startingScale = 1;
pixelCounter = 0; // This tracks how many pixels have been gathered since last size increase

// Damage variables
hp = 3;
damageDuration = 0;
invulnerable = false;

// Collision variables
touchingLeft = false;
touchingRight = false;
touchingTop = false;
touchingBottom = false;
inAir = false;

// Movement variables
jumpForce = [0, 300, 400, 800, 1500, 2000, 600, 700, 800, 900];
movementSpeed = 60;
maxSpeed = 250 + size * 50;
mouseArea = 60; // How far the mouse can be so it can affect the player

// Set physics properties
fixture = physics_fixture_create();
physics_fixture_set_box_shape(fixture, sprite_width / 2 - 1, sprite_height / 2 - 1);
physics_fixture_set_density(fixture, 0.5);
physics_fixture_set_friction(fixture, 0.2);
physics_fixture_set_linear_damping(fixture, 1);
physics_fixture_set_angular_damping(fixture, 0.5);
physics_fixture_set_collision_group(fixture, -1);
boundFixture = physics_fixture_bind_ext(fixture, self, -1, -1);

function gravityMovement() {
	// Variables for tracking the closest marker
	var closest_marker = noone;
	var closest_distance = 1000000;  // Start with a large number
	var target_x, target_y;          // The closest point on the edge to move towards

	// Find the closest objMarkerDefault
	with (objMarkerDefault) {
	    // Calculate distance to this objMarkerDefault's bounding box
	    var left = bbox_left;
	    var right = bbox_right;
	    var top = bbox_top;
	    var bottom = bbox_bottom;

	    // Calculate the closest point on this marker's bounding box to the player
	    var closest_x = clamp(other.x, left, right);
	    var closest_y = clamp(other.y, top, bottom);

	    // Calculate the distance from the player to this point on the edge
	    var dist = point_distance(other.x, other.y, closest_x, closest_y);

	    // If this marker is closer than the previous closest, update
	    if (dist < closest_distance) {
	        closest_distance = dist;
	        closest_marker = id;
	        target_x = closest_x;
	        target_y = closest_y;
	    }
	}

	// If a closest marker was found, move towards the calculated edge point
	if (closest_marker != noone) {
	    // Calculate the direction to the closest point on the edge of the marker
	    var dir = point_direction(x, y, target_x, target_y);

	    // Set the amount of force to apply (adjust force as needed)
	    var force_magnitude = 25;  // Increase or decrease for more or less force

	    // Calculate force components based on direction
	    var fx = lengthdir_x(force_magnitude, dir);
	    var fy = lengthdir_y(force_magnitude, dir);

	    // Apply the force towards the closest point on the edge
	    physics_apply_force(x, y, fx, fy);
	}
}

function movement() {

    if (mouse_check_button(mb_right)) {

        // Calculate the distance between the mouse and the player
        var dist = point_distance(mouse_x, mouse_y, x, y);

        // If mouse is close enough to player
        if (dist <= mouseArea) {

            // Calculate direction and force based on distance
            var dir = point_direction(mouse_x, mouse_y, x, y);
            var maxForce = 20 + objPlayer.size * 3;


            // Apply force based on how close the mouse is
			show_debug_message(dist)
            var dirX = lengthdir_x(movementSpeed - dist, dir);
            var dirY = lengthdir_y(movementSpeed - dist, dir);
            physics_apply_force(x, y, dirX, dirY / 2);
        }
    } else { 
        // Deceleration
        var deceleration = 0.1 * size;
        
        // Smooth deceleration for X-axis
        if (abs(phy_linear_velocity_x) > 0) {
            phy_linear_velocity_x -= sign(phy_linear_velocity_x) * deceleration;
            if (abs(phy_linear_velocity_x) < deceleration) phy_linear_velocity_x = 0;
        }
        
        // Smooth deceleration for Y-axis
        if (abs(phy_linear_velocity_y) > 0) {
            phy_linear_velocity_y -= sign(phy_linear_velocity_y) * deceleration;
            if (abs(phy_linear_velocity_y) < deceleration) phy_linear_velocity_y = 0;
        }
    }

    // Enforce max speed limits
    phy_linear_velocity_x = clamp(phy_linear_velocity_x, -maxSpeed, maxSpeed);
    phy_linear_velocity_y = clamp(phy_linear_velocity_y, -maxSpeed * 3, maxSpeed * 3);
}

hasUnlockedDoubleJump = true;
hasUnlockedWallJump = true;
canDoubleJump = false;

function wallJump() {
    var wallJumpForceX = 200 * size;
    var wallJumpForceY = -150 * size;

    if (!touchingBottom) {
        if (touchingLeft) {
            phy_linear_velocity_x = wallJumpForceX;
            phy_linear_velocity_y = wallJumpForceY;
            audio_play_sound(sfxPlayerJump, 3, false);
            return true;
        } 
        else if (touchingRight) {
            phy_linear_velocity_x = -wallJumpForceX;
            phy_linear_velocity_y = wallJumpForceY;
            audio_play_sound(sfxPlayerJump, 3, false);
            return true;
        }
    }
    
    return false;
}

function jump() {
	
	// Calculate the distance between the mouse and player
	var dist = point_distance(mouse_x, mouse_y, x, y);
	
	// Jump particles
	part_system_depth(particleSystem, 10000)
	part_particles_create(particleSystem, mouse_x, mouse_y, clickParticle, 1);
	part_system_depth(particleSystem, self.depth + 1);
		
	if (dist <= mouseArea) {
		
		show_debug_message(mouse_y < y)
		if (mouse_y > y) { squish(0.5) } else { squish(0.5, 1) }
		
		if (touchingBottom || touchingLeft || touchingRight) {
			part_system_depth(particleSystem, self.depth + 1);
			part_particles_create(particleSystem, x, y + sprite_height / 2, jumpParticle, 3);
		}
	    // Calculate direction from the mouse to the current objDynamicParent instance
	    var dir = point_direction(mouse_x, mouse_y, x, y);

	    // Scale force based on distance (closer objects receive more force)
		var force = objPlayer.jumpForce[objPlayer.size] / max(dist, 20);

	    // Calculate force components based on direction and apply the force
	    var dirX = lengthdir_x(force, dir);
	    var dirY = lengthdir_y(force, dir);
		physics_apply_torque(dirX);

	    // Apply the force to the objDynamicParent instance
	    physics_apply_impulse(x, y, dirX, dirY);
	    // Play jump sound for the player and vary pitch based on force
	    if (x == objPlayer.x) {
	        audio_play_sound(sfxPlayerJump, 3, false, 0.6);
	    }
	}
}
    
function playerDeath() {
    layer_set_visible("Shake", false);
    audio_stop_sound(sfxPlayerReset);
    audio_play_sound(sfxPlayerDie, 1, false);
    instance_create_layer(x, y, "particles", objParticleBurst);
    instance_destroy();
}

resetTimer = 0;
function reset() {
    if (keyboard_check(ord("R"))) {
        image_xscale -= 0.01;
        image_yscale += 0.11;
        resetTimer++;
        if (!audio_is_playing(sfxPlayerReset)) audio_play_sound(sfxPlayerReset, 3, false);
        if (resetTimer >= 120) playerDeath();
    } else {
        audio_stop_sound(sfxPlayerReset);
        resetTimer = 0;
    }
}

// Squish the player based on their rotation
function squish(multiplier, reverse = -1) {
	if (!global.animations) return;
	if (image_angle > 315 || image_angle < 45 || (image_angle > 135 && image_angle < 225)) {
		image_xscale = startingScale * (1 - multiplier * -reverse);
		image_yscale = startingScale * (1 + multiplier * -reverse);
	} else {
		image_xscale = startingScale * (1 + multiplier * -reverse);
		image_yscale = startingScale * (1 - multiplier * -reverse);
	}
}

#region // Particles
particleSystem = part_system_create();
part_system_global_space(particleSystem, true);
part_system_depth(particleSystem, self.depth + 1);

damageParticle = part_type_create();
part_type_shape(damageParticle, pt_shape_square);
part_type_size(damageParticle, 0.1 * size, 0.2 * size, -0.001, 0);
part_type_speed(damageParticle, 5 * size, 8 * size, 0, 0);
part_type_colour1(damageParticle, c_white);
part_type_alpha3(damageParticle, 1, 0.5, 0);
part_type_life(damageParticle, 20, 30);


clickParticle = part_type_create();
part_type_shape(clickParticle, pt_shape_circle);
part_type_size(clickParticle, 0.1, 0.1, 0.02, 0);
part_type_alpha3(clickParticle, 1, 0.5, 0);
part_type_life(clickParticle, 10, 10);

jumpParticle = part_type_create();
part_type_shape(jumpParticle, pt_shape_square);
part_type_size(jumpParticle, 0.02, 0.03, 0, 0);
part_type_speed(jumpParticle, 1, 2, 0, 0);
part_type_direction(jumpParticle, 65, 125, 0, 0);
part_type_gravity(jumpParticle, 0.1, 270);
part_type_colour1(jumpParticle, c_white);
part_type_alpha3(jumpParticle, 1, 0.5, 0);
part_type_life(jumpParticle, 15, 25);
#endregion