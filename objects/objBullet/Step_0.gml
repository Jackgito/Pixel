image_xscale = lerp(image_xscale, 1, 0.1);
image_yscale = lerp(image_yscale, 1, 0.1);

phy_linear_velocity_x = lengthdir_x(bulletSpeed, playerDirection);
phy_linear_velocity_y = lengthdir_y(bulletSpeed, playerDirection);

image_blend = NEON_RED_LIGHT;

part_particles_create(particleSystem, x, y, trailParticle, 1);
