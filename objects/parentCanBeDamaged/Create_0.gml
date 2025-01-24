/// @description Insert description here
// You can write your code in this editor

// Each canBeDamaged parent has hp, damageSound and alarm that handles post damage logic
function takeDamage(damageAmount = 1) {

	// Don't deal damage if invulnerable
	if (!variable_instance_exists(self, "invulnerable") || invulnerable) exit;
	hp -= damageAmount;
	if (hp > 0 && !is_undefined(damageSound)) audio_play_sound_at(damageSound, x, y, 0, 100, 100, 100, false, 2);
	else if (hp <= 0 && !is_undefined(deathSound)) audio_play_sound_at(deathSound, x, y, 0, 100, 100, 100, false, 2);
	alarm[0] = 30;
}

// This can be overwritten in the child
//function death() {
//	if (!is_undefined(deathSound)) audio_play_sound_at(deathSound, x, y, 0, 100, 100, 100, false, 2);
//    instance_destroy();	
//}