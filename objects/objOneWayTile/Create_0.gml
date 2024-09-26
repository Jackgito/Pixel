currentPower = 0.5; // Change glow intensity when power changes
glowColor = choose(NEON_BLUE_LIGHT, NEON_GREEN_LIGHT, NEON_PINK_LIGHT, NEON_YELLOW_LIGHT, NEON_PURPLE_LIGHT);
timer = 0;
image_speed = 0;

fixture = physics_fixture_create();
physics_fixture_set_polygon_shape(fixture)

physics_fixture_add_point(fixture, 0, 0);                      // Top-left
physics_fixture_add_point(fixture, sprite_width, 0);           // Top-right
physics_fixture_add_point(fixture, sprite_width, 5);          // Bottom-right
physics_fixture_add_point(fixture, 0, 5);                     // Bottom-left
physics_fixture_set_collision_group(fixture, 1);
boundFixture = physics_fixture_bind(fixture, self);