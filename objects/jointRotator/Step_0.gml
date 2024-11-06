// Find the nearest dynamic object (obj_dynamic) in the room
var nearestDynamicObject = instance_nearest(x, y, objTileDynamic);

// Check if the nearest dynamic object is within range (adjust distance as needed)
if (nearestDynamicObject != noone) {
    if (!jointCreated) {
        // Define the parameters for the revolute joint
        var wAnchorX = x; // x coordinate for the joint in the world
        var wAnchorY = y; // y coordinate for the joint in the world
        var motor = true; // Activate the motor
        var col = false; // Allow collision between the connected objects

        // Create the revolute joint to make the dynamic object rotate around the rotator
        var joint = physics_joint_revolute_create(
            self, // The static rotator (pivot point)
            nearestDynamicObject, // The dynamic object to attach
            wAnchorX, // X coordinate for the joint
            wAnchorY, // Y coordinate for the joint
            angMinLimit, // Lower permitted limit for the joint angle
            angMaxLimit, // Upper permitted limit for the joint angle
            angLimit, // Whether to limit the angle
            maxMotorTorque, // Maximum motor torque
            motorSpeed, // Motor speed
            motor, // Activate the motor
            col // Allow collision
        );

        // Mark that the joint has been created
        jointCreated = true;
    }
}