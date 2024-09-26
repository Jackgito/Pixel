// Laser activation check
if (global.power > 0) {

	var laserDistance = 1000;
	var laserWidth = random_range(laserSize - 1, laserSize + 1);

	// Initialize direction vectors (dir determines the direction)
	var dirX = 0;
	var dirY = 0;

	switch (dir) {
	    case "right":
	        dirX = 1;
	        dirY = 0;
	        break;
        
	    case "left":
	        dirX = -1;
	        dirY = 0;
	        break;
        
	    case "up":
	        dirX = 0;
	        dirY = -1;
	        break;
        
	    case "down": // Down
	        dirX = 0;
	        dirY = 1;
	        break;
	}

	// Raycast for laser's contact points, adjusting the direction based on dir
	var laserContactPointTop = physics_raycast(
	    x, y + laserWidth, 
	    x + dirX * laserDistance, y + dirY * laserDistance + laserWidth, 
	    [objDynamicParent, objStaticParent, objPlayer]
	);

	var laserContactPointBottom = physics_raycast(
	    x, y - laserWidth, 
	    x + dirX * laserDistance, y + dirY * laserDistance - laserWidth, 
	    [objDynamicParent, objStaticParent, objPlayer]
	);

	// Check if the top raycast hit something
	if (laserContactPointTop != undefined) {
	    var hitObject = laserContactPointTop[0].instance;


	    // Check if the laser hit the player
	    if (instance_exists(objPlayer) && hitObject == objPlayer.id) damageInstance(objPlayer);

	    // Draw the laser from the origin to the top contact point
	    draw_set_color(NEON_RED_LIGHT);
	    draw_rectangle(
	        x, y - laserWidth, 
	        laserContactPointTop[0].hitpointX, laserContactPointTop[0].hitpointY + laserWidth, 
	        false
	    );
	}

	// Check if the bottom raycast hit something
	if (laserContactPointBottom != undefined) {
	    var hitObjectBottom = laserContactPointBottom[0].instance;

	    // Check if the laser hit the player
		
	    if (instance_exists(objPlayer) && hitObjectBottom == objPlayer.id) damageInstance(objPlayer);

	    // Create particles at the bottom contact point
	    instance_create_layer(
	        laserContactPointBottom[0].hitpointX, 
	        laserContactPointBottom[0].hitpointY + laserWidth / 2,
	        "particles",
	        objParticleBurst,
			{ amount: 1, size: {min: 0.10, max: 0.20, change: -0.02, wiggle: 0}}
	    );

	    // Draw the laser from the origin to the bottom contact point
	    draw_set_color(NEON_RED_LIGHT);
	    draw_rectangle(
	        x, y + laserWidth, 
	        laserContactPointBottom[0].hitpointX * 1.01, laserContactPointBottom[0].hitpointY - laserWidth, 
	        false
	    );
	}
}

draw_self();