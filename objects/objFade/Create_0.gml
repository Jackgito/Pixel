alpha = 0;
in = false;
out = false;
fadeRoom = false;
color = c_black;
duration = 30;
quitGame = false;
targetRoom = room;

function fadeIn(_duration = 60, _color = c_black) {
	in = true;
	alpha = 1;
	duration = _duration;
	color = _color;
}

function fadeOut(duration = 60, color = c_black, _quitGame = false) {
	out = true;
	alpha = 0;
	quitGame = _quitGame;
}

function fadeToRoom(_targetRoom, _duration = 60, _color = c_black) {
	fadeRoom = true;
	out = true;
	alpha = 0;
	duration = _duration;
	color = _color;
	targetRoom = _targetRoom
}
