// Moving
xSpeed = 0; //current horizontal speed
ySpeed = 0; //current vertical speed
moveSpeed = 4; //walk speed
moveDirection = 0;

// Jumping
grav = 0.275;
maxSpeed = 15;
jumpSpeed = -6;

grv = 0.6; //gravity
ySpeedJump = -6; //jump speed
canJump = 0; //above zero while we are able to jump
onGround = false; //are we on the ground?
jumpHoldMax = 10;     // How many frames the jump can be held to increase height
jumpHoldTimer = 0;    // Timer to track how long the player has held the jump key
jumping = false;      // Flag to check if the player is currently jumping
landingSpeed = 0;
coyoteTimeMax = 8;   // How long the player can jump after leaving the ground (in steps/frames)
coyoteTime = 0;       // Coyote time countdown
squishTimer = 20;  // Timer to track squish delay

isDead = false;

yScale = image_xscale;
xScale = image_yscale;

// Updated movementAndCollisions function to integrate the squish effect
function movementAndCollisions() {
	
	// Check if the player is on the ground
    var wasOnGround = onGround;
	
    onGround = place_meeting(x, y + 1, objSolid);
	
    // Handle squish effects
    if (!wasOnGround && onGround) { // Player just landed, squish based on landing speed
        squish(1, 0.7);  // Apply squish based on landing speed
    } else if (ySpeed < 0) { // Player is jumping, squish upwards
        squish(0.5, 1.1);
		squishTimer = 20;
    } else {
		if (squishTimer > 0) squishTimer --;
		else squish(0.05, 1); // Reset squish
	}
    
    // Set variables for friction, acceleration, and gravity
    var _friction = 0.25;         // Friction when no input is given
    var acceleration = 0.3;       // How fast the player accelerates
    var maxSpeed = moveSpeed;    // Maximum horizontal speed the player can reach

    // Work out where to move horizontally based on input
    var inputSpeed = (global.moveRight - global.moveLeft);

    // Apply input to horizontal speed with acceleration
    if (inputSpeed != 0) {
        // Accelerate towards the input direction
        xSpeed += inputSpeed * acceleration;

        // Clamp the speed to the maximum allowed speed
        if (abs(xSpeed) > maxSpeed) {
            xSpeed = sign(xSpeed) * maxSpeed;
        }
    } else if (onGround) {
        // Apply friction when there is no input and the player is on the ground
        if (abs(xSpeed) > 0) {
            // Reduce speed by friction, but stop at 0 to prevent infinite sliding
            xSpeed -= sign(xSpeed) * _friction;
            if (abs(xSpeed) < _friction) xSpeed = 0;  // Stop completely if speed is below friction value
        }
    }

    // Work out where to move vertically (apply gravity)
    ySpeed += grv;

    // Horizontal move & collide
    var _hCol = move_and_collide(xSpeed, 0, objSolid);

    // Walk down slope if applicable
    if (onGround && place_meeting(x, y + abs(xSpeed) + 1, objSolid) && ySpeed >= 0) {
        ySpeed += abs(xSpeed) + 1;
    }

    // Vertical move & collide
    var _vCol = move_and_collide(0, ySpeed, objSolid);
    if (array_length(_vCol) > 0) {
        if (ySpeed > 0) canJump = 10;
        ySpeed = 0;
    }
	
	// Set min/max speeds
	xSpeed = clamp(xSpeed, -15, 15);
	ySpeed = clamp(ySpeed, -15, 15);
}

// Function to handle the jump logic
function jump() {
    
    // Handle the coyote time (allow the player to jump a little after falling off an edge)
    if (onGround) {
        coyoteTime = coyoteTimeMax;  // Reset the coyote timer if the player is on the ground
        canJump = 10;                // Reset canJump if on ground
    } else {
        coyoteTime--;                // Decrease coyote time if not on the ground
    }

    // Start the jump if spacebar (global.jump) is pressed and coyoteTime allows jumping
    if (coyoteTime > 0 && global.jump && !jumping) {
        ySpeed = ySpeedJump;          // Initial jump speed
        jumpHoldTimer = jumpHoldMax;  // Reset jump hold timer
        jumping = true;               // Set the jumping flag to true
    }

    // Variable jump height: continue applying upward velocity if the jump key is still held
    if (jumping && global.jump && jumpHoldTimer > 0) {
        ySpeed += ySpeedJump * 0.15;          // Keep applying jump velocity
        jumpHoldTimer--;              // Decrease the hold timer
    }

    // Stop applying the jump velocity when the jump key is released or hold timer expires
    if (!global.jump || jumpHoldTimer <= 0) {
        jumping = false;              // End the jump if the key is released or time expires
    }
    
    // If the player hits the ground, reset all jump-related variables
    if (onGround) {
        jumping = false;              // Reset the jumping flag when on the ground
        jumpHoldTimer = 0;            // Reset jump hold timer
        coyoteTime = coyoteTimeMax;   // Reset coyote timer
    }
}

function playerRotation() {
	// Handle player rotation on slopes
	if (onGround) {
	    // Check for a collision point directly under the player
	    var _slopePosX = x;
	    var _slopePosY = y + 1; // Check a little below the player

	    // Check for a collision with the platform at this point
	    var _surfaceId = instance_place(_slopePosX, _slopePosY, objSolid);

	    if (_surfaceId != noone) {
	        // Get the normal vector of the surface we collided with
	        var _nx = 0;
	        var _ny = 0;
	        var _angle = 0;

	        // Compute the angle of the surface
	        // For simplicity, assume objSolid instances have a surface angle stored in their variable "surfaceAngle"
	        _angle = _surfaceId.image_angle; // For example, objSolid may store its angle as surfaceAngle

	        // Align player with the platform's angle
	        image_angle = _angle;
	    } else {
	        // Reset player rotation when not on a slope
	        image_angle = 0;
	    }
	} else {
	    // Reset player rotation when in the air
	    image_angle = 0;
	}
}


// Handle Animation Function
squishTimer = 0;
isSquishing = false;
hasSquished = true;

function handleAnimation() {
    // Handle animations based on priority
    var onTheGround = place_meeting(x, y + 1, objTileStatic);
    var squishDuration = fps / 10;

    if (!onTheGround) {

        squishTimer = 0; // Reset timer if in the air
		hasSquished = false;
    } else if (onTheGround && squishTimer == 0 && !hasSquished) {
        squishTimer = squishDuration;
		hasSquished = true;
    } else if (onTheGround && squishTimer > 0) {
		squishTimer -= 1;

	} else {

	}
	
    if (isDead) {
        // Death animation takes highest priority

		
    } else if (!onTheGround) {
        // Jump animation

		

		
    } else if (xSpeedeed != 0) {
        // Movement animation

		
    } else {
        // Idle/Blink animation

    }
}

function handleDeath() {

}

// If multiplier < 1, become shorter and wider. Else taller and narrower.
function squish(squishSpeed = 0.2, squishMultiplier = 1.2) {
	// Reset back to normal size
	image_xscale = lerp(image_xscale, xScale / squishMultiplier, squishSpeed);
	image_yscale = lerp(image_yscale, yScale * squishMultiplier, squishSpeed);
}