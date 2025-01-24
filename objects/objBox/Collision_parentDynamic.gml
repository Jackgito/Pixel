// Get the relative velocity of the collision
var relative_velocity = lengthdir_x(phy_speed, phy_rotation) - other.phy_speed;

// Calculate the impact force
var impact_force = abs(relative_velocity);

// Define the threshold force
var force_threshold = 3; // Adjust this value as needed


// Play the sound if the impact force exceeds the threshold
if (impact_force > force_threshold) {
    audio_play_sound(sfxBox, 1, false);
}