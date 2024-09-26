with (objParticleManager) {
	particleBurst(other.x, other.y, pt_shape_square, 3, 1, [c_black, NEON_RED_DARK, NEON_RED_MID]);	
}

damageDuration = 15; // This triggers the damage script
//instance_destroy(self);