// Try to keep the object in place
if (phy_position_y < originalY) phy_position_y = originalY;
phy_position_x = originalX;

var xDifference = originalX - x;
var yDifference = originalY - y;

var forceStrength = 100 * phy_mass;
physics_apply_force(x, y, 0, yDifference * forceStrength);