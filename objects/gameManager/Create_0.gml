currentPower = 1;
gameIsPaused = false;

// Room name display
textDuration = 200;
currentRoom = room
text = ""
textTimer = 0;

lastSave = loadLastPlayedSave();
if (lastSave) {
	
} else {
	global.animations = true;
	global.sounds = true;
	global.music = false
	global.textures = true;
	global.colors = true;
	global.gravity = 90;
	global.power = 0;
	global.playerDied = false;
}

layer_set_visible("Particles", global.animations);

// Start fade
if (!instance_exists(objFade)) instance_create_depth(x, y, 0, objFade);
with objFade fadeIn();

function pauseGame() {
	
	pauseMenu = [
    {
        name: "Quit to main menu",
        clickEvent: function() {
			other.gameIsPaused = false;
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
			gameIsPaused = !gameIsPaused
		}
		
		if (gameIsPaused) {
			with (parentSolid) {
				phy_active = false;
			}
			
			instance_deactivate_all(true);
			instance_activate_object(objFade);
			draw_set_color(c_black);
			draw_rectangle(viewX, viewY, viewX + viewWidth, viewY + viewHeight, false);
			draw_set_color(c_white);
			drawMenu(pauseMenu)

		} else {
			instance_activate_all();
			with (parentSolid) {
				phy_active = true;
			}
		}
	}
}

#region // Layer effect

glowEffect = fx_create("_effect_glow");
glowSettingsTiles = {
	"g_GlowRadius": 8,
	"g_GlowQuality": 10,
	"g_GlowIntensity": 0.2,
	"g_GlowGamma": 0.6,
	"g_GlowAlpha": 1
};

glowSettingsPlayer = {
	"g_GlowRadius": min(20 + global.power * 5, 60),
	"g_GlowQuality": 5,
	"g_GlowIntensity": min(0.4 + global.power * 0.1, 1),
	"g_GlowGamma": 0,
	"g_GlowAlpha": 0.6
}

fx_set_parameters(glowEffect, glowSettingsTiles);
fx_set_single_layer(glowEffect, true);
layer_set_fx("Tiles", glowEffect);
fx_set_parameters(glowEffect, glowSettingsPlayer);
layer_set_fx("Player", glowEffect);

#endregion
