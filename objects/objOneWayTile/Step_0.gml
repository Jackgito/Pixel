var radius = sprite_width / 2;
var targetX = x;  // Player or object performing the check
var targetY = y;

// Create an empty array to hold close instances
var closeDynamicObjects = [];

// Loop through all objDynamicParent instances
with (parentDynamic) {
    // Calculate the rectangle's boundaries
    var rectLeft = x - 5;
    var rectRight = x + sprite_width + 5;
    var rectTop = y - 30;
    var rectBottom = y + 30;
    
    // Check if the target point (targetX, targetY) is inside the rectangle
    if (point_in_rectangle(parentDynamic.x, parentDynamic.y, rectLeft, rectTop, rectRight, rectBottom)) {
        array_push(closeDynamicObjects, id);  // Store the instance id in the array
    }
}
// Now, loop through the array of close objects and apply your logic
for (var i = 0; i < array_length(closeDynamicObjects); i++) {
    var obj = closeDynamicObjects[i];

    // Apply logic using 'with' to target each individual instance
    with (obj) {
		if (!variable_instance_exists(id, "boundFixture")) exit;
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