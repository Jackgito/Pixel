// Shoot
var detectionRange = 900;
// Step Event
if (instance_exists(objPlayer) && global.power > 0) {

    // Check if player is within detection range
    var distanceToPlayer = point_distance(x, y, objPlayer.x, objPlayer.y);
    if (distanceToPlayer < detectionRange) {
		
		var playerXSpeed = objPlayer.phy_linear_velocity_x
		var playerMaxSpeed = objPlayer.maxSpeed;

        // Predict player location based on if they are moving towards or away from the turret
        var predictionFactorX = 0;
		if (abs(playerXSpeed) > 100) predictionFactorX = playerXSpeed / playerMaxSpeed;

        // Predicted future position of the player based on their velocity and distance
		var predictionFactorY = 0;
		if (objPlayer.phy_linear_velocity_y < -100) predictionFactorY = 0.4;
		//else if (objPlayer.phy_linear_velocity_y < 5) predictionFactorY = -0.1;
		
        var predictedX = objPlayer.x + distanceToPlayer * predictionFactorX;
        var predictedY = objPlayer.y + distanceToPlayer * predictionFactorY

        // Calculate the angle to the predicted position
        var targetAngle = point_direction(x, y, predictedX, predictedY);

        // Calculate the angular difference
        var angleDiff = angle_difference(targetAngle, currentAngle);

		currentAngle += angleDiff * rotateFraction;


        // Update the image angle to reflect the new current angle
        image_angle = currentAngle;

        // Shooting logic
        if (shootTimer > 0) shootTimer--;
        else {
            shoot(predictedX, predictedY);  // Aim at the predicted position
            shootTimer = shotFrequency;
        }

        // Optional squish effect for cannon firing animation
        if (shootTimer < shotFrequency * 0.8) {
            squish(scale * 0.6, 0.01);
        } else {
            squish(scale, 0.8);
        }
    }
}