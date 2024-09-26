currentPower = 1;
gameSpeedTimer = 0; // This is used to reset the game speed after slow effect

lastSave = loadLastPlayedSave();
if (lastSave) {
	
} else {
	global.animations = true;
	global.sounds = true;
	global.music = false
	global.textures = false;
	global.colors = true;
	global.gravity = 0;
	global.power = 0;	
}

alarm[0] = 60; // Improved performance

// Fade screen from black at the beginning of the game
with(objFade) {
	fadeIn = true;
	targetAlpha = 0;
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
