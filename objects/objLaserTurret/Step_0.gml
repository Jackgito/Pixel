if (global.power > 0) {
	
    var laserDistance = 1000;
    laserWidth = random_range(laserSize - 0.2, laserSize + 0.2);

    // Calculate direction based on image_angle
    var dirX = lengthdir_x(100, image_angle - 90);
    var dirY = lengthdir_y(100, image_angle - 90);

    // Perpendicular direction for offsetting by laser width
    var perpDirX = lengthdir_x(laserWidth, image_angle);
    var perpDirY = lengthdir_y(laserWidth, image_angle);

    // Raycast for laser's contact points
    laserContactPoint1 = physics_raycast(
        x + perpDirX, y + perpDirY,
        x + perpDirX + dirX * laserDistance, y + perpDirY + dirY * laserDistance,
        [parentDynamic, parentStatic, objPlayer]
    );

    laserContactPoint2 = physics_raycast(
        x - perpDirX, y - perpDirY,
        x - perpDirX + dirX * laserDistance, y - perpDirY + dirY * laserDistance,
        [parentDynamic, parentStatic, objPlayer]
    );

    // Check for closest point along the laser to the player
    if (instance_exists(objPlayer)) {
        // Player position
        var playerX = objPlayer.x;
        var playerY = objPlayer.y;

        // Closest point on laser line calculation
        var lineStartX = x;
        var lineStartY = y;
        var lineEndX = x + dirX * laserDistance;
        var lineEndY = y + dirY * laserDistance;

        // Project player's position onto the laser line
        var t = ((playerX - lineStartX) * (lineEndX - lineStartX) + (playerY - lineStartY) * (lineEndY - lineStartY))
                / (sqr(lineEndX - lineStartX) + sqr(lineEndY - lineStartY));
        
        // Clamp t between 0 and 1 to stay on the laser segment
        t = clamp(t, 0, 1);

        // Closest point coordinates
        var closestPointX = lineStartX + t * (lineEndX - lineStartX);
        var closestPointY = lineStartY + t * (lineEndY - lineStartY);

        // Update the audio emitter to this closest point
        audio_emitter_position(audioEmitter, closestPointX, closestPointY, 0);
		
		// Handle damage
		if (laserContactPoint1 != undefined || laserContactPoint2 != undefined) {
		    var hitObject = noone;
    
		    if (laserContactPoint1 != undefined) {
		        hitObject = laserContactPoint1[0].instance;
		    } else if (laserContactPoint2 != undefined) {
		        hitObject = laserContactPoint2[0].instance;
		    }
    
		    if (instance_exists(objPlayer) && hitObject == objPlayer.id) {
		        with(objPlayer) takeDamage(100);
		    }
		}
    }

    // Play the sound on the emitter if it's not already playing
    if (!audio_is_playing(sfxLaser)) {
        laserSound = audio_play_sound_on(audioEmitter, sfxLaser, true, 1, 2);
		audio_sound_loop_start(laserSound, 2.8);
		audio_sound_loop_end(laserSound, 5.8);
    }
	
} else {
    // Stop the sound if the laser is inactive
    audio_stop_sound(laserSound);
}

// Spin
if (global.power >= spinPower && spinPower != -1) {
	phy_angular_velocity = spinAmount + global.power * 10;
}
