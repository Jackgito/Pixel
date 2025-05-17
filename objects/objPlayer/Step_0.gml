// Check for collisions
// Adjust these values as needed based on object origin and size
// Store the object IDs to check against
var check_ids = [parentSolid];

// Raycast distance from center
var dist_x = sprite_width / 2 + 4;
var dist_y = sprite_height / 2 + 4;

// Cast rays in each direction
var left = physics_raycast(x, y, x - dist_x, y, check_ids);
var right = physics_raycast(x, y, x + dist_x, y, check_ids);
var up = physics_raycast(x, y, x, y - dist_y, check_ids);
var down = physics_raycast(x, y, x, y + dist_y, check_ids);

// Determine if touching
touchingLeft = (left != undefined);
touchingRight = (right != undefined);
touchingTop = (up != undefined);
touchingBottom = (down != undefined);

// Handle coyote timer
if (touchingBottom && phy_speed_y > -1) {
    coyoteTimer = 15 // Reset coyote timer when touching the ground and going down
} else if (coyoteTimer > 0) {
    coyoteTimer--; // Decrease coyote timer when not touching the ground
}

// Landing squish
if (touchingBottom && inAir) {
	squish(0.5, 1)
}

// Determine if the player is in the air
if !(touchingLeft || touchingRight || touchingBottom || touchingTop) {
    inAir = true;
} else {
    inAir = false;
}

//manageSize();

movement();

if (keyboard_check_pressed(ord("G")) && global.dev_mode) {
	enableGravityMovement = !enableGravityMovement;
}

if (enableGravityMovement) gravityMovement();

if (mouse_check_button_pressed(mb_left)) {
	mouseImpulse();
	coyoteTimer = 0;
}

reset();

// Reset player size after squish
image_xscale = lerp(image_xscale, size, 0.1);
image_yscale = lerp(image_yscale, size, 0.1);

physics_remove_fixture(self, boundFixture);
physics_fixture_set_box_shape(fixture, sprite_width / 2, sprite_height / 2);
boundFixture = physics_fixture_bind_ext(fixture, self, 0, 0);

// Audio listeners for more dynamic sound
audio_listener_position(x, y, 0);
audio_listener_orientation(0, 0, 1000, 0, -1, 0);

// Reset at the beginning of each step
touchingLeft = false;
touchingRight = false;
touchingTop = false;
touchingBottom = false;

