var fixture = physics_fixture_create();
physics_fixture_set_restitution(fixture, 0);
physics_fixture_set_friction(fixture, DEFAULT_FRICTION);
physics_fixture_set_density(fixture, 0.1);
physics_fixture_set_linear_damping(fixture, 1);

originalX = x;
originalY = y;

switch (image_index) {
	case 0:
		physics_fixture_set_box_shape(fixture, TILE_SIZE * 6, TILE_SIZE / 2);
		physics_fixture_bind_ext(fixture, self, sprite_width / 2, TILE_SIZE / 2);
		
		physics_fixture_set_box_shape(fixture, TILE_SIZE * 4.5, TILE_SIZE / 2);
		physics_fixture_bind_ext(fixture, self, sprite_width / 2 - TILE_SIZE / 2, TILE_SIZE * 1.5);
		
		physics_fixture_set_box_shape(fixture, TILE_SIZE, TILE_SIZE / 2);
		physics_fixture_bind_ext(fixture, self, sprite_width / 2 + TILE_SIZE * 2, TILE_SIZE * 2.5);
	break;

	case 1:
		physics_fixture_set_box_shape(fixture, TILE_SIZE, TILE_SIZE / 2);
		physics_fixture_bind_ext(fixture, self, TILE_SIZE, TILE_SIZE / 2);
		
		physics_fixture_set_box_shape(fixture, TILE_SIZE, TILE_SIZE / 2);
		physics_fixture_bind_ext(fixture, self, TILE_SIZE * 2, TILE_SIZE * 1.5);
	break;
}

physics_fixture_delete(fixture);
phy_fixed_rotation = true;