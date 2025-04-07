event_inherited(); // Inherit functions from canBeDamaged parent

// Size variables
image_xscale = 0;
image_yscale = 0;
size = 1;
targetSize = 1;
startingScale = 1;

// Damage variables
global.playerDied = false;

// Collision variables
touchingLeft = false;
touchingRight = false;
touchingTop = false;
touchingBottom = false;
inAir = false;
outsideTimer = 0;

// Movement variables
impulseForce = 550 * size;
movementSpeed = 40 * size;
maxSpeed = 550 + size * 50;
mouseArea = 90; // How far the mouse can be so it can affect the player
enableGravityMovement = false;
coyoteTimer = 0;

// Set physics properties
fixture = physics_fixture_create();
physics_fixture_set_box_shape(fixture, sprite_width / 2 - 1, sprite_height / 2 - 1);
physics_fixture_set_density(fixture, 1);
physics_fixture_set_friction(fixture, 0.2);
physics_fixture_set_linear_damping(fixture, 1);
physics_fixture_set_angular_damping(fixture, 0.5);
physics_fixture_set_collision_group(fixture, -1);
boundFixture = physics_fixture_bind_ext(fixture, self, 0, 0);

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

	    // If mouse is within the movement area
	    if (dist <= mouseArea) {

	        // Calculate direction and force based on distance
	        var dir = point_direction(x, y, mouse_x, mouse_y);
       
	        var minForce = movementSpeed / 4;
		
			// Calculate the base force with a 50% speed boost when on the ground
			var groundBoost = inAir ? 0 : movementSpeed * 0.5;
			var distanceFactor = dist / 10;
			var force = movementSpeed + groundBoost - distanceFactor;
		
	        // Apply force based on the distance-scaled speed
	        var dirX = lengthdir_x(-force, dir);
	        var dirY = lengthdir_y(-force / 2, dir);
	        physics_apply_force(x, y, dirX, dirY);
	    }
	}

    // Max speed limits
	if (phy_active) {
	    phy_linear_velocity_x = clamp(phy_linear_velocity_x, -maxSpeed, maxSpeed);
	    phy_linear_velocity_y = clamp(phy_linear_velocity_y, -maxSpeed, maxSpeed);
	}

}

hasUnlockedWallJump = true;
unlockedDoubleJump = true;
canDoubleJump = false;

// Acts as jump, (but can also affect other dynamic objects)
function mouseImpulse() {
	
	// Create jump particles at mouse
    part_system_depth(particleSystem, 10000);
    part_particles_create(particleSystem, mouse_x, mouse_y, clickParticle, 1);
    part_system_depth(particleSystem, self.depth + 1);
	
	// Create a DS list to store the instances
	var dsList = ds_list_create();

	// Get all the instances within the radius using collision_circle_list
	collision_circle_list(mouse_x, mouse_y, mouseArea / 2, objPlayer, false, false, dsList, false);

	// Iterate through the list of instance IDs
	if (ds_list_size(dsList) > 0) {
		for (var i = 0; i < ds_list_size(dsList); i++) {
		    var inst = ds_list_find_value(dsList, i); // Get the instance ID from the list
			if (!inst.touchingBottom && coyoteTimer == 0 && global.gravity > 0) exit;
		    // Use the 'with' statement to apply force or other logic to each instance
		    with (inst) {
				// Calculate the distance between the mouse and player
				var dist = point_distance(mouse_x, mouse_y, x, y);
		
			    // Check if player can jump && (!inAir || canDoubleJump)
			    if (dist <= other.mouseArea) {
        
			        // Check if the player is grounded or using double jump
			        //if (!inAir) {
			        //    canDoubleJump = true;  // Allow double jump after the initial jump
			        //} else if (canDoubleJump) {
			        //    canDoubleJump = false; // Disable further double jumps after double jump
			        //}
        
			        // Calculate direction from the mouse to the player
			        var dir = point_direction(mouse_x, mouse_y, x, y);
        
			        // Scale force based on distance (closer objects receive more force)
			        var force = other.impulseForce / max(dist, 20);
        
			        // Calculate force components based on direction and apply the force
			        var dirX = lengthdir_x(force, dir);
			        var dirY = lengthdir_y(force, dir) * 1.1;
			        physics_apply_torque(dirX);
        
			        // Apply the jump force
			        physics_apply_impulse(x, y, dirX, dirY);
		
					// Player specific
					if (self == other) {
				
						// Dust particles
					    part_system_depth(self.particleSystem, self.depth + 1);
					    part_particles_create(self.particleSystem, x, y + sprite_height / 2, self.jumpParticle, 3);
				
						// Play jump sound
						audio_play_sound(sfxPlayerJump, 3, false, 0.6, 0, random_range(0.8, 1));
				
						// Jump squish
				        if (mouse_y > y) { 
				            self.squish(0.5); 
				        } else { 
				            self.squish(0.5, 1); 
				        }		
					}
			    }
			}
		}

	// Clean up the DS list when done
	ds_list_destroy(dsList);
		
    }
}

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

resetTimer = 0;
function reset() {
    if (keyboard_check(ord("R"))) {
		squish(0.5, true);
        resetTimer++;
        if (!audio_is_playing(sfxPlayerReset)) audio_play_sound(sfxPlayerReset, 3, false, 1, 0, 1.5);
        if (resetTimer >= 60) death();
    } else {
        audio_stop_sound(sfxPlayerReset);
        resetTimer = 0;
    }
}

// Squish the player based on their rotation
function squish(multiplier, reverse = -1) {
    if (!global.animations) return;

    // Normalize the angle to always be between 0 and 360
    var normalizedAngle = image_angle % 360;
    if (normalizedAngle < 0) normalizedAngle += 360; // Ensures positive range

    // Check the normalized angle for squishing
    if ((normalizedAngle >= 315 || normalizedAngle < 45) || (normalizedAngle >= 135 && normalizedAngle < 225)) {
        image_xscale = startingScale * (1 - multiplier * -reverse);
        image_yscale = startingScale * (1 + multiplier * -reverse);
    } else {
        image_xscale = startingScale * (1 + multiplier * -reverse);
        image_yscale = startingScale * (1 - multiplier * -reverse);
    }
}

//function manageSize() {
//	// Change size
//	// Variables to store target size and the lerp speed
//	var lerpSpeed = 0.1;
//	var sizeChange = 0.1;

//	if (keyboard_check_pressed(vk_up)) {
//	    // Set the target size to a larger value when the UP key is pressed
//	    targetSize = size + sizeChange;
//	}

//	if (keyboard_check_pressed(vk_down)) {
//	    // Set the target size to a smaller value when the DOWN key is pressed
//	    targetSize = size - sizeChange;
//	}

//	// Interpolate the size smoothly towards the target size
//	size = lerp(size, targetSize, lerpSpeed);	
//}

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