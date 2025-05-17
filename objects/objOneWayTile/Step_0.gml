var closeDynamicObjects = ds_list_create();

// Use collision_rectangle_list correctly to fill the list
collision_rectangle_list(x - 10, y, x + sprite_width + 10, y + 48, parentSolidDynamic, true, true, closeDynamicObjects, false);

// Loop through the list of close objects and apply your logic
var list_size = ds_list_size(closeDynamicObjects);
for (var i = 0; i < list_size; i++) {
    var obj = ds_list_find_value(closeDynamicObjects, i);

    // Apply logic using 'with' to target each individual instance
    with (obj) {
        if (phy_linear_velocity_y < 0) {  // If moving upward, disable collisions
            physics_fixture_set_collision_group(fixture, -1);
            physics_remove_fixture(self, boundFixture);
            boundFixture = physics_fixture_bind(fixture, self);
        } else {  // If falling down, enable collisions
            physics_fixture_set_collision_group(fixture, 1);
            physics_remove_fixture(self, boundFixture);
            boundFixture = physics_fixture_bind(fixture, self);
        }
    }
}

// Clean up the list after you're done
ds_list_destroy(closeDynamicObjects);