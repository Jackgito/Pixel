jointCreated = false;
joint = undefined;
smoothSpeed = 0;

// If the dynamic object moves out of range, remove the joint
//if (nearestDynamicObject != noone && point_distance(x, y, nearestDynamicObject.x, nearestDynamicObject.y) > 100) {
//    if (jointCreated) {
//        physics_joint_delete(joint);
//        jointCreated = false; // Reset the flag to allow creating a new joint later
//    }
//}