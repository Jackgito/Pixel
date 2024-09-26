image_xscale = size;
image_yscale = size;

// Create a rectangle fixture that covers the entire sprite
fixture = physics_fixture_create();
physics_fixture_set_box_shape(fixture, sprite_height / 2, sprite_height / 2);

// Attach the fixture to the body
physics_fixture_bind(fixture, self);
physics_fixture_delete(fixture);