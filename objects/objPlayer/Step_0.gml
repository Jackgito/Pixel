touchingLeft = (collision_line(x, y, x - sprite_width / 2, y, parentSolid, false, true) != noone);
touchingRight = (collision_line(x, y, x + sprite_width / 2, y, parentSolid, false, true) != noone);
touchingTop = (collision_line(x, y, x, y - sprite_height / 2, parentSolid, false, true) != noone);
touchingBottom = (collision_line(x, y, x, y + sprite_height * 2, parentSolid, false, true) != noone);

if !(touchingLeft || touchingRight || touchingBottom || touchingTop) inAir = true

if (touchingBottom && inAir) {
	squish(0.5, 1)
	inAir = false;
}

if (keyboard_check_pressed(vk_up)) size++;
if (keyboard_check_pressed(vk_down)) size--;

movement();
//gravityMovement();
if (mouse_check_button_pressed(mb_left)) jump();
reset();
if (hp <= 0) playerDeath();

//if (global.gravity > 0) {
//	 //Extra gravity for friction and more responsive movement
//	physics_apply_force(x, y, 0, 2);
//}

// Reset player size after squish
image_xscale = lerp(image_xscale, size, 0.1);
image_yscale = lerp(image_yscale, size, 0.1);

physics_remove_fixture(self, boundFixture);
physics_fixture_set_box_shape(fixture, sprite_width / 2, sprite_height / 2);
boundFixture = physics_fixture_bind_ext(fixture, self, -1, -1);

// Reset at the beginning of each step
touchingLeft = false;
touchingRight = false;
touchingTop = false;
touchingBottom = false;

