if (!instance_exists(objPlayer)) instance_destroy();

// Parameters
var eyeRange = 10;

// Calculate the offset for the eyes based on player’s movement direction
var eyeOffsetX = lengthdir_x(phy_position_x, 10);
var eyeOffsetY = lengthdir_y(phy_position_y, 10);

// Update eyes' position based on direction and speed
phy_position_x = objPlayer.phy_position_x;
phy_position_y = objPlayer.phy_position_y;

// Ensure eyes are always facing the same direction as the player
phy_rotation = objPlayer.phy_rotation;