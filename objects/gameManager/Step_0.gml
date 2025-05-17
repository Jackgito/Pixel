// Fullscreen
if keyboard_check_pressed(vk_f12) {
	window_set_fullscreen( !window_get_fullscreen())
	display_reset(4, false);
	window_set_size(1920, 1080);
}

// DEBUGGING
if (global.dev_mode) {
    // Handle number key presses for debug actions
    for (var i = 1; i <= 3; i++) {
        if (keyboard_check_pressed(ord(string(i)))) {
            switch (i) {
                case 1:
                    global.power++;
                    break;
                case 2:
                    global.power--;
                    break;
                case 3:
                    global.gravity = (global.gravity == 90) ? 0 : 90;
                    break;
            }
        }
    }

    // Handle level navigation with arrow keys
    if (keyboard_check_pressed(vk_left)) {
        global.power = 0;
        room_goto_previous();
    } else if (keyboard_check_pressed(vk_right)) {
        global.power = 0;
        room_goto_next();
    }
}

physics_world_gravity(0, global.gravity);

if (global.playerDied) {
	alarm[1] = 60;
	global.playerDied = false;	
}

// Speedrtun timer
if (!gameIsPaused && isGameLevel()) {
    global.playTime += delta_time / 1000000; // Converts microseconds to seconds
}
