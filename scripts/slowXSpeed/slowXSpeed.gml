/// @function slowXspeed(xSpeed, acceleration)
/// @param xSpeed The current horizontal speed of the object
/// @param acceleration The rate at which the speed decelerates
/// @return The new xSpeed after deceleration

function slowXspeed(xSpeed, acceleration) {
    // Decelerate when no direction is pressed
    if (xSpeed > 0) {
        xSpeed -= acceleration;
        if (xSpeed < 0) xSpeed = 0; // Ensure it doesn't go negative
    } else if (xSpeed < 0) {
        xSpeed += acceleration;
        if (xSpeed > 0) xSpeed = 0; // Ensure it doesn't go positive
    }

    return xSpeed;
}
