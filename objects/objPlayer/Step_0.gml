// Check for collisions and log each state
touchingLeft = (collision_line(x, y, x - sprite_width, y, parentSolid, false, true) != noone);
touchingRight = (collision_line(x, y, x + sprite_width, y, parentSolid, false, true) != noone);
touchingTop = (collision_line(x, y, x, y - sprite_height, parentSolid, false, true) != noone);
touchingBottom = (collision_line(x, y, x, y + sprite_height * 2, parentSolid, false, true) != noone);

// Landing squish
if (touchingBottom && inAir) {
	squish(0.5, 1)
}

// Determine if the player is in the air and log the state
if !(touchingLeft || touchingRight || touchingBottom || touchingTop) {
    inAir = true;
} else {
    inAir = false;
}

manageSize();

movement();

if (keyboard_check_pressed(ord("G"))) {
enableGravityMovement = !enableGravityMovement;
}

if (enableGravityMovement) gravityMovement();

if (mouse_check_button_pressed(mb_left)) mouseImpulse();

reset();

if (hp <= 0) death();

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

