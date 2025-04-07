/// @function moveBetweenPoints(startX, startY, endX, endY, movementType, movementSpeed = 2)
/// @description Moves an object between two points using different movement types, with continuous back-and-forth movement.
/// @param {real} startX - The starting X coordinate.
/// @param {real} startY - The starting Y coordinate.
/// @param {real} endX - The ending X coordinate.
/// @param {real} endY - The ending Y coordinate.
/// @param {string} movementType - The type of movement ("linear", "easeIn", "easeOut", "easeInOut").
/// @param {real} movementSpeed - The speed of the movement (default: 2).

function moveBetweenPoints(startX, startY, endX, endY, movementType, movementSpeed = 0.05) {
    // Initialize variables if they don't exist
    if (!variable_instance_exists(id, "moveProgress")) {
        moveProgress = 0;
        moveDirection = 1;
    }
    
    // Update progress
    moveProgress += movementSpeed * moveDirection * delta_time / 1000000;
    
    // Clamp progress between 0 and 1
    moveProgress = clamp(moveProgress, 0, 1);
    
    // Change direction when reaching endpoints
    if (moveProgress >= 1 || moveProgress <= 0) {
        moveDirection *= -1;
    }
    
    // Calculate interpolation factor based on movement type
    var t;
    switch (movementType) {
        case "linear":
            t = moveProgress;
            break;
        case "easeIn":
            t = moveProgress * moveProgress;
            break;
        case "easeOut":
            t = 1 - (1 - moveProgress) * (1 - moveProgress);
            break;
        case "easeInOut":
            t = moveProgress < 0.5 ? 2 * moveProgress * moveProgress : 1 - power(-2 * moveProgress + 2, 2) / 2;
            break;
        default:
            t = moveProgress; // Default to linear if invalid type
    }
    
    // Interpolate position
    phy_position_x = lerp(startX, endX, t);
    phy_position_y = lerp(startY, endY, t);
}
