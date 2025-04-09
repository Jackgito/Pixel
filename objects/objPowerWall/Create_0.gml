originalX = x;
originalY = y;
hasStopped = false;
moveSoundID = undefined;

moveDistance = 0;
switch (unlockDirection) {
	case "right":
	case "left":
		moveDistance = sprite_width + 2;
		break;
	case "up":
	case "down":
		moveDistance = sprite_height + 2;
		break;
}