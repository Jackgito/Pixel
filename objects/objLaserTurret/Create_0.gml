particleSystem = part_system_create_layer("Particles", false);
partType = part_type_create();

function damageInstance(instance) {
	with(instance) takeDamage(100, true, NEON_RED_LIGHT);
}