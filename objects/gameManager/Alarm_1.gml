/// @description Handle player death
if (gameIsPaused) alarm[1] = 20;
global.power = 0;
physics_world_gravity(0, 90);
room_restart();