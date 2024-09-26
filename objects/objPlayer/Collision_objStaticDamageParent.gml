if (invulnerable) exit;
if (takeDamage(other.damageAmount, true) == 0) {
	playerDeath();
} else {
	part_particles_create(particleSystem, x, y, damageParticle, 5);	
}