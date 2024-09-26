/**
 * Squish Function
 * 
 * This function adjusts the player's scale (both width and height) to create a squishing effect, typically used for actions like jumping or landing.
 * The player can squish to become either shorter and wider (when the `targetScale` is less than 1) or taller and narrower (when the `targetScale` is greater than 1).
 * 
 * The function will gradually return the player to their normal size by interpolating the scale factors towards the `targetScale` at a given speed.
 * 
 * @param {float} targetScale - The desired target scale for both the width (x-axis) and height (y-axis) of the player. 
 *                              Values less than 1 make the player shorter and wider, values greater than 1 make them taller and narrower.
 *                              Defaults to 1, which represents the player's original size.
 * 
 * @param {float} squishSpeed - The speed at which the player's scale returns to the `targetScale`. A higher value means faster interpolation.
 *                              Defaults to 0.2.
 * 
 * @return {boolean} - Returns `true` if the player is still in the process of squishing or stretching (i.e., the scale has not yet reached `targetScale`).
 *                     Returns `false` if the player has finished squishing/stretching and the scale has returned to the `targetScale`.
 * 
 * Ensure that `global.animations` is enabled before calling this function.
 */
function squish(targetScale, squishSpeed) {
    // Ensure that animations are enabled, otherwise exit the function
    if (!global.animations) exit;
    
    // Gradually interpolate the player's scale towards the target scale
    image_xscale = lerp(image_xscale, targetScale, squishSpeed);
    image_yscale = lerp(image_yscale, targetScale, squishSpeed);
    
    // Check if the current scale is close enough to the target scale
    if (abs(image_xscale - targetScale) < 0.01 && abs(image_yscale - targetScale) < 0.01) {
        // If close enough, snap to the exact target scale and stop squishing
        image_xscale = targetScale;
        image_yscale = targetScale;
        return false;  // Squish is complete
    }
    
    // Continue squishing if not yet at the target scale
    return true;
}