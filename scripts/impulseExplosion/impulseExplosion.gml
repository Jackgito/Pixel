/// @description Applies an impulse explosion at the instance's position
/// @param maxRadius - The maximum radius of the explosion
/// @param maxImpulse - The maximum impulse applied to objects

function impulseExplosion(maxRadius, maxImpulse) {
    // Create a DS list to store the instances
    var dsList = ds_list_create();

    // Get all instances within the explosion radius
    collision_circle_list(x, y, maxRadius, all, false, true, dsList, false);

    // Iterate through the list of instance IDs
    if (ds_list_size(dsList) > 0) {
        for (var i = 0; i < ds_list_size(dsList); i++) {
            var inst = ds_list_find_value(dsList, i); // Get the instance ID

            // Skip non-physics objects to avoid errors
            if (!inst.phy_active) continue;

            // Calculate distance from the explosion center to the instance
            var dist = point_distance(x, y, inst.x, inst.y);

            // Ensure the instance is within the radius
            if (dist <= maxRadius) {
                with (inst) {
                    // Calculate the direction of the impulse
                    var angle = point_direction(other.x, other.y, x, y);

                    // Scale the impulse based on distance (closer = stronger)
                    var impulse = maxImpulse * (1 - (dist / maxRadius));
                    impulse = max(impulse, 0); // Ensure impulse is not negative

                    // Apply the impulse
                    var impulseX = lengthdir_x(impulse, angle);
                    var impulseY = lengthdir_y(impulse, angle);
                    physics_apply_impulse(x, y, impulseX, impulseY);
                }
            }
        }
    }

    // Clean up the DS list
    ds_list_destroy(dsList);
}
