part_type_destroy(damageParticle);
part_type_destroy(clickParticle);
part_system_destroy(particleSystem);
if (surface_exists(surfaceDarkness)) surface_free(surfaceDarkness);