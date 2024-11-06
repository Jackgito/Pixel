if keyboard_check_pressed(vk_f12) {
    window_set_fullscreen( !window_get_fullscreen());
    display_reset(4, false);
    window_set_size(1920, 1080);
}

ambientParticles();

if !instance_exists(objPlayer) exit;

// Define arrays for camera widths and heights
var camWidths = [480, 640, 800, 1024, 1152, 1280, 1366, 1600, 1760, 1920];
var camHeights = [270, 360, 450, 576, 648, 720, 768, 900, 990, 1080];

// Interpolate camera width and height smoothly between categories
camWidth = lerp(camWidth, camWidths[clamp(objPlayer.size - 1, 0, array_length(camWidths) - 1)], 0.01);
camHeight = lerp(camHeight, camHeights[clamp(objPlayer.size - 1, 0, array_length(camWidths) - 1)], 0.01);

// Get player position
var playerX = objPlayer.x;
var playerY = objPlayer.y;

// Get current camera position (centered on the player)
var camX = finalCamX;
var camY = finalCamY;

// Calculate camera's edges
var leftEdge = camX;
var rightEdge = camX + camWidth;
var topEdge = camY;
var bottomEdge = camY + camHeight;

// Threshold distance from camera edges
var edgeBuffer = 200;

// Check if player is within 200px of any camera edge
if (playerX < leftEdge + edgeBuffer) {
    // Move camera left
    camX = playerX - edgeBuffer;
} else if (playerX > rightEdge - edgeBuffer) {
    // Move camera right
    camX = playerX + edgeBuffer - camWidth;
}

if (playerY < topEdge + edgeBuffer) {
    // Move camera up
    camY = playerY - edgeBuffer;
} else if (playerY > bottomEdge - edgeBuffer) {
    // Move camera down
    camY = playerY + edgeBuffer - camHeight;
}

// Clamp camera position within the room boundaries
camX = clamp(camX, 0, room_width - camWidth);
camY = clamp(camY, 0, room_height - camHeight);

// Smooth camera trailing
finalCamX += (camX - finalCamX) * cameraTrailSpeed;
finalCamY += (camY - finalCamY) * cameraTrailSpeed / 2;

// Set the new camera position
camera_set_view_pos(view_camera[0], finalCamX, finalCamY);

// Set the camera view size to match the updated width and height
camera_set_view_size(view_camera[0], camWidth, camHeight);