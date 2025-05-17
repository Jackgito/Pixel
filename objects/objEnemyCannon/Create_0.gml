shootTimer = random_range(60, 100);
shotFrequency = random_range(80, 100);
shotSpeed = 300;

rotateFraction = 0.2;  // The fraction of the angle difference to rotate per step
rotateTolerance = 0.1;   // Tolerance within which to snap directly to the target angle
currentAngle = 0;      // Initial angle of the cannon

function shoot(targetX, targetY, shotSpeed) {
	// Calculate offset based on rotation
    var cannonLength = sprite_height;
    var bulletX = x + lengthdir_x(cannonLength + 10, image_angle);
    var bulletY = y + lengthdir_y(cannonLength + 10, image_angle);
	image_xscale = 1.2;
	image_yscale = 0.9;

	var bulletStruct = {
		bulletSpeed: shotSpeed,
		scale: 1,
		targetX: targetX,
		targetY: targetY
	}
	
	instance_create_layer(bulletX, bulletY, "Objects", objBullet, bulletStruct);
	audio_play_sound_at(sfxShoot, x, y, 0, 100, 100, 1, false, 3);
}