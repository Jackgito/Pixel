// Constrain movement to a small range (e.g., 10 pixels in any direction)
var maxOffset = 10;

if (point_distance(x, y, initialX, initialY) > maxOffset) {
    // Snap back to the original position if it moves too far
    physics_body_set_position(id, initialX, initialY);
    physics_body_set_linear_velocity(id, 0, 0); // Stop any ongoing movement
}
