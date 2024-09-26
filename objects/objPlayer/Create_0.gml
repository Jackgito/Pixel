size = 1;
lastSize = 1;
pixelCounter = 0; // This tracks how many pixels have been gathered since last size increase

resetTimer = 0;
damageDuration = 0;
maxSpeed = 150 + size * 50;
oldGravity = 0;
invulnerable = false;
hp = 3;
startingScale = 1;

touchingLeft = false;
touchingRight = false;
touchingTop = false;
touchingBottom = false;

layerID = layer_get_id("Tiles");
tiles = layer_tilemap_get_id(layerID);

jumpForce = [0, 200, 300, 400, 500, 600, 700, 800, 900, 1000];

fixture = physics_fixture_create();
physics_fixture_set_box_shape(fixture, sprite_width / 2 - 1, sprite_height / 2 - 1);
boundFixture = physics_fixture_bind(fixture, self);

function movement() {
    var force = 1 * size;
    if (touchingBottom) force *= 1.25;

    var appliedForce;
    var acceleration = 0.2 * size;
    var deceleration = 0.1 * size;

if (mouse_check_button(mb_right)) {
    with (objDynamicParent) {

        // Calculate the distance between the mouse and the current objDynamicParent instance
        var dist = point_distance(mouse_x, mouse_y, x, y);
        var maxForce = 20 + objPlayer.size * 3;

        // Only apply force if within 50 pixels
        if (dist <= 50) {

            // Calculate direction from the mouse to the current objDynamicParent instance
            var dir = point_direction(mouse_x, mouse_y, x, y);

            // Scale force based on distance (closer objects receive more force)
            var force = (200 - dist) / 200 * maxForce;

            // Calculate force components based on direction and apply the force
            var dirX = lengthdir_x(force, dir);
            var dirY = lengthdir_y(force, dir);

            // Apply the force to the objDynamicParent instance
            physics_apply_force(x, y, dirX, dirY / 2);
        }
    }
} else {
    if (phy_linear_velocity_x > 0) {
        phy_linear_velocity_x = max(phy_linear_velocity_x - deceleration, 0);
    } else if (phy_linear_velocity_x < 0) {
        phy_linear_velocity_x = min(phy_linear_velocity_x + deceleration, 0);
    }
        
    if (phy_linear_velocity_y > 0) {
        phy_linear_velocity_y = max(phy_linear_velocity_y - deceleration, 0);
    } else if (phy_linear_velocity_y < 0) {
        phy_linear_velocity_y = min(phy_linear_velocity_y + deceleration, 0);
    }
}

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

if (mouse_check_button_pressed(mb_left)) {
    with (objDynamicParent) {

        // Calculate the distance between the mouse and the current objDynamicParent instance
        var dist = point_distance(mouse_x, mouse_y, x, y);
		
        // Only apply force if within 60 pixels
        if (dist <= 60) {

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
            // Play jump sound for the player (objPlayer) and vary pitch based on force
            if (x == objPlayer.x) {
                audio_play_sound(sfxPlayerJump, 3, false, 0.6);
            }
        }
    }
}
	
    //var dist = point_distance(x, y, mouse_x, mouse_y);
    //var maxMouseDist = 50 * size;
    //var maxForce = 50 * size;

    //if (mouse_check_button_pressed(mb_left)) {
    //    if (wallJump()) {
    //        return;
    //    }
    //}

    //if (mouse_check_button_pressed(mb_left)) {
    //    var dir = point_direction(mouse_x, mouse_y, x, y);
    //    var force = dist / maxForce;
    //    force = clamp(force, 0, maxForce); 

    //    if (touchingBottom) {
    //        if (dist <= maxMouseDist) {
    //            phy_linear_velocity_y = 10;
    //            var dirX = lengthdir_x(force, dir) / 2;
    //            var dirY = lengthdir_y(force, dir);
	//			show_debug_message(dirX)
	//			show_debug_message(dirY)
    //            physics_apply_impulse(x, y, maxForce - dirX, maxForce - dirY);
    //            audio_play_sound(sfxPlayerJump, 3, false);
    //            phy_angular_velocity = 150 * sign(dirX);
    //            hasJumped = true;
    //            canDoubleJump = hasUnlockedDoubleJump;
    //        }
    //    } else if (canDoubleJump) {
    //        if (dist <= maxMouseDist) {
    //            var dirX = lengthdir_x(force, dir) / 2;
    //            var dirY = lengthdir_y(force, dir);
    //            physics_apply_impulse(x, y, dirX, dirY);
    //            audio_play_sound(sfxPlayerJump, 3, false, 1, 0, 1.2);

    //            if (global.animations) {
    //                image_xscale = startingScale - 0.05;
    //                image_yscale = startingScale + 0.05;
    //            }

    //            canDoubleJump = false;
    //        }
    //    }
    //}

    //if (touchingBottom) {
    //    hasJumped = false;
    //    canDoubleJump = hasUnlockedDoubleJump;
    //}
}

hasCollided = false;
function squishCollision() {
    if (!hasCollided) {
        if (touchingBottom || touchingTop) {
            image_xscale = startingScale + 0.08;
            image_yscale = startingScale - 0.01;
            hasCollided = true;
        }    
    }

    if (!touchingBottom) hasCollided = false;
    squish(startingScale, 0.1);
}
    
function playerDeath() {
    layer_set_visible("Shake", false);
    audio_stop_sound(sfxPlayerReset);
    audio_play_sound(sfxPlayerDie, 1, false);
    instance_create_layer(x, y, "particles", objParticleBurst);
    instance_destroy();
}

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

#region // Particles
particleSystem = part_system_create();
part_system_depth(particleSystem, self.depth + 1);
damageParticle = part_type_create();
part_type_shape(damageParticle, pt_shape_square);
part_type_size(damageParticle, 0.1 * size, 0.2 * size, -0.001, 0); // Scale particle size
part_type_speed(damageParticle, 5 * size, 8 * size, 0, 0); // Scale speed if needed
part_type_colour1(damageParticle, c_white);
part_type_alpha3(damageParticle, 1, 0.5, 0);
part_type_life(damageParticle, 20, 30);

clickParticle = part_type_create();
part_type_shape(clickParticle, pt_shape_circle);
part_type_size(clickParticle, 0.1, 0.1, 0.02, 0);
part_type_alpha3(clickParticle, 1, 0.5, 0);
part_type_life(clickParticle, 10, 10);

#endregion