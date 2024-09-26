// Example usage:
//with(objFade) {
//	fadeIn = true;
//	targetAlpha = 1;
//}

alpha = 1;
fadeIn = false;
targetAlpha = 0;
color = c_black;
targetRoom = noone;
fadeSpeed = 0.02;

function fade() {
	if (targetAlpha != alpha) {
	    // Check if fading in or out
	    if (fadeIn) {
			alpha += fadeSpeed;
			alpha = min(alpha, 1);
	    } else {
	        // Fade out (decrease alpha)
	        alpha -= fadeSpeed;  // Decrement alpha by fadeSpeed
			alpha = max(alpha, 0);
	    }
	} else if (targetRoom != noone) {
		room_goto(targetRoom);
	}
}