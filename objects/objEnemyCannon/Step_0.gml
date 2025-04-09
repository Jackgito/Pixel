// Shoot
var detectionRange = 600;

// Step Event
if (instance_exists(objPlayer) && global.power > 0) {

    // Check if player is within detection range
    var distanceToPlayer = point_distance(x, y, objPlayer.x, objPlayer.y);
    if (distanceToPlayer < detectionRange) {

        // Calculate the angle directly towards the player
        var targetAngle = point_direction(x, y, objPlayer.x, objPlayer.y);

        // Smoothly adjust the turret's angle
        var angleDiff = angle_difference(targetAngle, currentAngle);
        currentAngle += angleDiff * rotateFraction;

        // Update the image angle to reflect the new current angle
        image_angle = currentAngle;

        // Shooting logic
        if (shootTimer > 0) shootTimer--;
        else {
            shoot(objPlayer.x, objPlayer.y, shotSpeed); // Aim at player
            shootTimer = shotFrequency;
        }
    }
}
