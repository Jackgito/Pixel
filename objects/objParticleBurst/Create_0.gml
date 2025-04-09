//amount = 10;
//shape = pt_shape_square;
//size = {min: 0.25, max: 0.35, change: -0.02, wiggle: 0};
//spd = {min: 6, max: 8, increase: -0.01, wiggle: 0};
//dir = {min: 0, max: 360, increase: 0, wiggle: 0};


particleSystem = part_system_create_layer("particles", false);
part_particles_burst(particleSystem, x, y, psBulletExplosion);
alarm[0] = 120;
