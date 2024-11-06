// Keep the island in place
if (phy_position_y < originalY) phy_position_y = originalY;
phy_position_x = originalX;

// Calculate the difference from the original position
var yDifference = originalY - y;
var xDifference = originalX - x;

// This value tries to move the button to the original position
var forceStrength = 8 * phy_mass;
physics_apply_force(x, y, 0, yDifference * forceStrength);