// Move towards player when close
if (point_distance(x, y, objPlayer.x, objPlayer.y) < 40) {
    // Calculate the direction towards the player
    var dirX = objPlayer.x - x;
    var dirY = objPlayer.y - y;

    // Normalize the direction vector
    var length = point_distance(0, 0, dirX, dirY);
    if (length != 0) {
        dirX /= length; // Normalize X
        dirY /= length; // Normalize Y
    }

    // Set the force to apply (you can adjust these values)
    var forceMagnitude = 2; // Adjust this for how strong the force should be
    var xForce = dirX * forceMagnitude;
    var yForce = dirY * forceMagnitude;

    // Apply the calculated force
    physics_apply_force(x, y, xForce, yForce);
}