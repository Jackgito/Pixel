touchingLeft = collision_line(bbox_left, bbox_top + 10, bbox_left, bbox_bottom - 10, objStaticParent, false, false);
touchingRight = collision_line(bbox_right, bbox_top + 10, bbox_right, bbox_bottom - 10, objStaticParent, false, false);
touchingTop = collision_line(bbox_left + 10, bbox_top, bbox_right - 10, bbox_top, objStaticParent, false, false);
touchingBottom = collision_line(bbox_left + 2, bbox_bottom + 20, bbox_right - 2 , bbox_bottom + 20, objStaticParent || objHybridParent || objOneWayTile, false, false);

if (keyboard_check_pressed(vk_up)) size++;
if (keyboard_check_pressed(vk_down)) size--;

movement();
jump();
reset();
if (hp <= 0) playerDeath();

if (global.gravity > 0) {
	 //Extra gravity for friction and more responsive movement
	physics_apply_force(x, y, 0, 10);
}

if (global.animations) squishCollision();

// Click particles
if (mouse_check_button_pressed(mb_left)) {
	part_system_depth(particleSystem, 10000)
	part_particles_create(particleSystem, mouse_x, mouse_y, clickParticle, 1);
	part_system_depth(particleSystem, self.depth + 1);
}

image_xscale = lerp(image_xscale, size / 2, 0.1);
image_yscale = lerp(image_yscale, size /2, 0.1);


if (lastSize != size) {
	physics_remove_fixture(self, boundFixture);
	physics_fixture_set_box_shape(fixture, sprite_width / 2, sprite_height / 2);
	boundFixture = physics_fixture_bind(fixture, self);
	lastSize = size;
}

//if (phy_linear_velocity_y < 0) { // Instance moving up, disable collision
//	show_debug_message("UP")
//	physics_remove_fixture(id, boundFixture);
//	physics_fixture_set_collision_group(fix, -1);
//	boundFixture = physics_fixture_bind (fix, self);
	
//} else { // Instance is falling, enable collision group
//	//physics_remove_fixture(id, boundFixture);
//	//physics_fixture_set_collision_group(fix, 1);
//	//boundFixture = physics_fixture_bind (fix, self);
//	show_debug_message("DOWN")
//}


	//physics_remove_fixture(id, boundFixture);
	//physics_fixture_set_collision_group(fix, -1);
	//boundFixture = physics_fixture_bind (fix, self);

	//physics_remove_fixture(id, boundFixture);
	//physics_fixture_set_collision_group(fix, 1);
	//boundFixture = physics_fixture_bind (fix, self);






// Reset at the beginning of each step
touchingLeft = false;
touchingRight = false;
touchingTop = false;
touchingBottom = false;

