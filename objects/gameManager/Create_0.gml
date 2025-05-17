currentPower = 1;
gameIsPaused = false;

// Room name display
textDuration = 200;
currentRoom = room
text = ""
textTimer = 0;

global.animations = true;
global.sounds = true;
global.music = false
global.textures = true;
global.colors = true;
global.power = 0;
global.gravity = 90;
global.playerDied = false;
global.dev_mode = true;
global.playTime = 0; // in seconds

layer_set_visible("Particles", global.animations);

// Start fade
if (!instance_exists(objFade)) instance_create_depth(x, y, 0, objFade);
with objFade fadeIn();

function pauseGame() {
	
	pauseMenu = [
    {
        name: "Quit to main menu",
        clickEvent: function() {
			instance_activate_object(objFade);
			instance_activate_object(self);
			global.power = 0;
            with (objFade) fadeToRoom(roomMainMenu);
        }
    }
	];
	
	var viewX = camera_get_view_x(view_camera[0]);
	var viewY = camera_get_view_y(view_camera[0]);
	var viewWidth = camera_get_view_width(view_camera[0]);
	var viewHeight = camera_get_view_height(view_camera[0]);
	
	if (room != roomMainMenu) {
		if (keyboard_check_pressed(vk_escape)) {
			gameIsPaused = !gameIsPaused;
			audio_play_sound(sfxClick, 1, false);
		}
		
		if (gameIsPaused) {
			with (parentSolid) {
				phy_active = false;
			}
			
			instance_deactivate_all(true);
			instance_activate_object(objFade);

			//audio_group_get_gain()
			audio_group_stop_all(audioGroupSfx);
			draw_set_color(c_black);
			draw_rectangle(viewX, viewY, viewX + viewWidth, viewY + viewHeight, false);
			draw_set_color(c_white);
			drawMenu(pauseMenu);

		} else {
			instance_activate_all();
			with (parentSolid) {
				phy_active = true;
			}
		}
	}
}

window_set_caption(GAME_NAME);
