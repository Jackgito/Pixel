var radius = 50;
var targetX = x;  // Player or object performing the check
var targetY = y;

// Create an empty array to hold close instances
var closeDynamicObjects = [];

// Loop through all objDynamicParent instances
with (objDynamicParent) {
    // Check the distance between the player and each objDynamicParent
    var dist = point_distance(targetX, targetY, x, y);

    // If within the radius, add to the array
    if (dist <= radius) {
        array_push(closeDynamicObjects, id);  // Store the instance id in the array
    }
}

// Now, loop through the array of close objects and apply your logic
for (var i = 0; i < array_length(closeDynamicObjects); i++) {
    var obj = closeDynamicObjects[i];

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
//if (objPlayer.phy_linear_velocity_y < 0) { // Has upward momentum, disable collisions
//	physics_fixture_set_collision_group(fixture, -1);
//	physics_remove_fixture(self, boundFixture);
//	boundFixture = physics_fixture_bind (fixture, self);
	
//} else { // Falls down, enable collisions
//	physics_fixture_set_collision_group(fixture, 1);
//	physics_remove_fixture(self, boundFixture);
//	boundFixture = physics_fixture_bind (fixture, self);
//}