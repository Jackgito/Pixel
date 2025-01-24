/// @description Makes the power orb pulse by changing its size
function pulsePowerOrb() {
    // Define the pulse speed and brightness range
    var pulse_speed = 0.05; // Speed of the pulse (adjust as needed)
    var min_brightness = 0.5; // Minimum brightness (50%)
    var max_brightness = 1.0; // Maximum brightness (100%)
    
    // Calculate the sine wave value based on the current time
    var time = current_time / 1000; // Convert time to seconds
    var brightness = (sin(time * pulse_speed) + 1) / 2; // Normalize sine wave to range [0, 1]
    
    // Scale brightness to desired range
    brightness = lerp(min_brightness, max_brightness, brightness);

    // Draw the sprite with the modulated brightness
    draw_sprite_ext(sprite_index, image_index, x, y, image_xscale, image_yscale, image_angle, 
        make_color_hsv(0, 0, brightness * 255), image_alpha);
}
