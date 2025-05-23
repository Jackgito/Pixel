ambientParticles();

if !instance_exists(objPlayer) { 
	playerDead = true;
	exit;
} else if (playerDead == true && instance_exists(objPlayer)) { // Teleport camera to player after they spawn
	playerDead = false;
	camera_set_view_pos(view_camera[0], objPlayer.x - camWidth / 2, objPlayer.y - camHeight / 2);
}

// Define arrays for camera widths and heights
var camWidths = [640, 800, 1024, 1152, 1280, 1366, 1600, 1760, 1920];
var camHeights = [360, 450, 576, 648, 720, 768, 900, 990, 1080];

// Interpolate camera width and height smoothly between categories
camWidth = lerp(camWidth, camWidths[clamp(objPlayer.size - 1, 0, array_length(camWidths) - 1)] , 0.05)
camHeight = lerp(camHeight, camHeights[clamp(objPlayer.size - 1, 0, array_length(camWidths) - 1)], 0.05)


var camX = objPlayer.x - camWidth / 2;
var camY = objPlayer.y - camHeight / 2;

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
