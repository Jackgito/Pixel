fixture = physics_fixture_create();
physics_fixture_set_box_shape(fixture, sprite_width / 2, sprite_height / 2);
physics_fixture_set_density(fixture, 0.06);
physics_fixture_set_friction(fixture, 0.5);
physics_fixture_set_restitution(fixture, 0.3);
boundFixture = physics_fixture_bind(fixture, self);