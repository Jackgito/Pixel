currentPower = 1;

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
