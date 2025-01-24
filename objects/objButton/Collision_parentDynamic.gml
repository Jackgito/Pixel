// Calculate the direction of the collision
var directionX = phy_position_x - other.phy_position_x;
var directionY = phy_position_y - other.phy_position_y;
var magnitude = point_distance(phy_position_x, phy_position_y, other.phy_position_x, other.phy_position_y);

// Normalize the direction
if (magnitude != 0) {
    directionX /= magnitude;
    directionY /= magnitude;
}

// Apply a small impulse in the direction of the press
physics_apply_impulse(phy_position_x, phy_position_y, directionX * 0.2, directionY * 0.2);