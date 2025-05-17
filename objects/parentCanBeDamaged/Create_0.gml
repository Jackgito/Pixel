// Add this at the start of each child to avoid overwriting there parent functions
// event_inherited();

// Each canBeDamaged parent has hp, damageSound and alarm that handles post damage logic
function takeDamage(damageAmount = 1) {
    // Don't deal damage if invulnerable
    if (!variable_instance_exists(self, "invulnerable") || invulnerable) exit;

    hp -= damageAmount;
    if (hp <= 0) {
        death();
        exit;
    }

    if (!is_undefined(damageSound)) {
        audio_play_sound_at(damageSound, x, y, 0, 100, 100, 100, false, 2);
        image_blend = NEON_RED_DARK;

        if (object_index == objPlayer) {
            screenShake(30);
            invulnerable = true;
        }

        alarm[0] = 30; // Set alarm to reset damage effects
    }
}


function death() {
	
	if (!is_undefined(deathSound)) audio_play_sound_at(deathSound, x, y, 0, 100, 100, 100, false, 2);
    layer_set_visible("Shake", false);
	if (object_index == objPlayer) global.playerDied = true;
	impulseExplosion(x, y, 20);
    instance_destroy(self);
}

// This can be overwritten in the child
//function death() {
//	if (!is_undefined(deathSound)) audio_play_sound_at(deathSound, x, y, 0, 100, 100, 100, false, 2);
//    instance_destroy();	
//}