function screenShake(duration = 60) {
	static timer = duration;
	if (timer <= 0) {
		layer_set_visible("Shake", false);
		exit
	}
	timer --;
}