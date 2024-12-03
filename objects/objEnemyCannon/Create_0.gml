image_xscale = scale;
image_yscale = scale;

shootTimer = random_range(60, 100);
shotFrequency = random_range(80, 120);
shotSpeed = 250;

rotateFraction = 0.1;  // The fraction of the angle difference to rotate per step
rotateTolerance = 0.1;   // Tolerance within which to snap directly to the target angle
currentAngle = 0;      // Initial angle of the cannon

function shoot(targetX, targetY, shotSpeed) {
	// Calculate offset based on rotation
    var cannonLength = sprite_height;
    var bulletX = x + lengthdir_x(cannonLength, image_angle);
    var bulletY = y + lengthdir_y(cannonLength, image_angle);
	image_xscale = 0.9;
	image_yscale = 1.4;

	var bulletStruct = {
		bulletSpeed: shotSpeed,
		scale: scale,
		targetX: targetX,
		targetY: targetY
	}
	
	instance_create_layer(bulletX, bulletY, "Objects", objBullet, bulletStruct);
	audio_play_sound(sfxShoot, 2, false);
}