fixture = physics_fixture_create();
physics_fixture_set_box_shape(fixture, sprite_width / 2 - 1, sprite_height / 2 - 1);
boundFixture = physics_fixture_bind(fixture, self);