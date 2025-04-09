// Find the nearest dynamic object (obj_dynamic) in the room
var nearestDynamicObject = instance_nearest(x, y, objTileDynamic);

// Check if the nearest dynamic object is within range (adjust distance as needed)
if (nearestDynamicObject != noone) {
    if (!jointCreated) {
        // Define the parameters for the revolute joint
        var wAnchorX = x; // x coordinate for the joint in the world
        var wAnchorY = y; // y coordinate for the joint in the world
        var col = false; // Allow collision between the connected objects
		var enableMotor = (requiredPower <= global.power); // If enough power is collected, start motor

        // Create the revolute joint to make the dynamic object rotate around the rotator
		joint = physics_joint_revolute_create(
            self, // The static rotator (pivot point)
            nearestDynamicObject, // The dynamic object to attach
            wAnchorX, // X coordinate for the joint
            wAnchorY, // Y coordinate for the joint
            angMinLimit, // Lower permitted limit for the joint angle
            angMaxLimit, // Upper permitted limit for the joint angle
            angLimit, // Whether to limit the angle
            maxMotorTorque, // Maximum motor torque
            0, // Motor speed 0 without power
            false, // Activate the motor
            col // Allow collision
        );

        // Mark that the joint has been created
        jointCreated = true;
    }
}

// Ensure smoothSpeed starts at a low value
if (global.power >= requiredPower) {
    // Start with a low speed and increase it smoothly
    smoothSpeed = lerp(smoothSpeed, motorSpeed, 0.01);  // Adjust 0.01 for smoothness speed (you can change this value for a faster/slower start)
    
    // Set the joint motor speed to the smoothly increasing speed
    physics_joint_set_value(joint, phy_joint_motor_speed, smoothSpeed);
	physics_joint_enable_motor(joint, true);
}
