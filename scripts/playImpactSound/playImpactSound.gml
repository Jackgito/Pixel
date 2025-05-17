/// @function playImpactSound(sound, forceThreshold)
/// @param sound The sound asset to play on impact
/// @param {real} forceThreshold The minimum force required to trigger the sound

function playImpactSound(sound, forceThreshold) {
    // Check if the object has physics enabled
        // Get the current speed of the object
        var currentSpeed = point_distance(0, 0, phy_speed_x, phy_speed_y);
        
        // Calculate the impact force (simplified)
        var impactForce = currentSpeed * phy_mass;
        
        // Check if the impact force exceeds the threshold
        if (impactForce >= forceThreshold) {
            // Play the sound only if it's not already playing
            if (!audio_is_playing(sound)) {
                audio_play_sound(sound, 10, false);
            }
        }
}
