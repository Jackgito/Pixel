// Each canBeDamaged parent has hp, damageSound and alarm that handles post damage logic
function takeDamage(damageAmount = 1) {

	    //!object_is_ancestor(object_index, parentStaticCanBeDamaged))
	// Deal damage only to entities that can take damage (they also have hp and damageSound by default)
	if (!object_is_ancestor(object_index, parentCanBeDamaged)) {
	    exit;
	}

	// Don't deal damage if invulnerable
	if (!variable_instance_exists(self, "invulnerable") || invulnerable) exit;
	
	hp -= damageAmount;

	audio_play_sound(damageSound, 1, false, 1, 0, random_range(0.9, 1));
	
	image_blend = NEON_RED_DARK;
	alarm[0] = 30;
}