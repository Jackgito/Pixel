if (in) {
	var fadeStep = 1 / duration;
	alpha -= fadeStep;
	if (alpha <= 0) {
		in = false;
	}
	
} else if (out) {
	var fadeStep = 1 / duration;
	alpha += fadeStep;
	if (alpha >= 1) {
		out = false;
		
		if (quitGame) game_end();
		
		if (fadeRoom) {
			room_goto(targetRoom)
			in = true;
			fadeRoom = false;
		}
	}
}