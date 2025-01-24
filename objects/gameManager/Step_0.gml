// Fullscreen
if keyboard_check_pressed(vk_f12) {
	window_set_fullscreen( !window_get_fullscreen())
	display_reset(4, false);
	window_set_size(1920, 1080);
}

physics_world_gravity(0, global.gravity);

// Glow
if (currentPower != global.power) { // If power changed, change glow intensity
	currentPower = lerp(currentPower, global.power, 0.1);
	glowSettingsTiles = {
		"g_GlowRadius": min(global.power * 5, 50),
		"g_GlowQuality": 10,
		"g_GlowIntensity": min(global.power * 0.1, 0.8),
		"g_GlowGamma": min(global.power * 0.1, 1),
		"g_GlowAlpha": 1
	}
	layer_clear_fx("Tiles");
	layer_clear_fx("Objects");
	layer_clear_fx("Player");
	
	fx_set_parameters(glowEffect, glowSettingsTiles);
	layer_set_fx("Tiles", glowEffect);
	layer_set_fx("Objects", glowEffect);

	glowSettingsPlayer = {
	"g_GlowRadius": min(20 + global.power * 4, 60),
	"g_GlowQuality": 5,
	"g_GlowIntensity": min(0.4 + global.power * 0.1, 1),
	"g_GlowGamma": 0,
	"g_GlowAlpha": 1
	}
	fx_set_parameters(glowEffect, glowSettingsPlayer);
	layer_set_fx("Player", glowEffect);
}


// DEBUGGING

//for (var i = 1; i < 8; i++) {
//    if (keyboard_check_pressed(ord(string(i)))) {
//        switch (i) {
//            case 1: global.animations = !global.animations; break;
//            case 2: global.sounds = !global.sounds; break;
//            case 3: global.music = !global.music; break;
//            case 4: global.textures = !global.textures; break;
//            case 5: global.colors = !global.colors; break;
//            case 6: global.gravity = (global.gravity == 90) ? 0 : 90; break;
//        }
//    }
//}

if (keyboard_check_pressed(vk_left)) global.power -= 1;
if (keyboard_check_pressed(vk_right)) global.power += 1;


if (global.playerDied) {
	alarm[1] = 60;
	global.playerDied = false;	
}



//layer_shader("Tiles", shdrBrightness);

//g_GlowRadius (Real)
//g_GlowQuality (Real)
//g_GlowIntensity (Real)
//g_GlowGamma (Real)
//g_GlowAlpha (Real)