/// @function impulseExplosion(xPos, yPos, strength)

function impulseExplosion(xPos, yPos, strength) {
    var radius = strength * 3;
    var hitList = ds_list_create();
    var affectedObjects = ds_list_create(); // To track affected instances

    // Find nearby physics objects
    collision_circle_list(xPos, yPos, radius, parentSolidDynamic, false, true, hitList, false);

    for (var i = 0; i < ds_list_size(hitList); i++) {
        var inst = hitList[| i];

        // Skip if explosion is blocked by objParentSolid (not working)
        if (collision_line(xPos, yPos, inst.x, inst.y, parentSolidStatic, true, true)) {
            continue;
        }

        // Skip if the object has already been affected by the explosion
        if (ds_list_find_index(affectedObjects, inst) != -1) {
            continue;
        }

        var dx = inst.x - xPos;
        var dy = inst.y - yPos;
        var dist = point_distance(xPos, yPos, inst.x, inst.y);

        if (dist > 0 && dist < radius) {
            var dir = point_direction(xPos, yPos, inst.x, inst.y);
            var falloff = 1 - (dist / radius);

            var force = (strength * falloff);
            var fx = lengthdir_x(force, dir);
            var fy = lengthdir_y(force, dir);

            // Apply impulse to the object
            with (inst) {
                physics_apply_impulse(inst.x, inst.y, fx, fy);
            }

            // Mark this instance as affected by the explosion
            ds_list_add(affectedObjects, inst);
        }
    }

    // Clean up hit list and affected objects list
    ds_list_destroy(hitList);
    ds_list_destroy(affectedObjects);
}
