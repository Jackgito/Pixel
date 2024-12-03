startDrawing = false;

// This is used to draw the level selection map
levelSelectConfig = {
    background: undefined,
    color: c_white,
    hoverSound: sfxMenu,
    clickSound: sfxMenu,
	levelsPerRow: 3,
    levels: [
        { 
            levelName: "1", 
            roomName: room1
        },
        { 
            levelName: "2", 
            roomName: room2 
        },
        { 
            levelName: "3", 
            roomName: room3
        },
		{
            levelName: "4", 
            roomName: room4
        },
		{
            levelName: "4", 
            roomName: room4
        },
		{
            levelName: "4", 
            roomName: room4
        }
    ]
};

function drawLevelSelect(levelSelectConfig) {
    // Draw the background
    if (levelSelectConfig.background != undefined) {
        draw_sprite(levelSelectConfig.background, 0, 0, 0);
    }

    // Draw levels
    for (var i = 0; i < array_length(levelSelectConfig.levels); i++) {
        var level = levelSelectConfig.levels[i];
        var posX = level.position[0];
        var posY = level.position[1];
        var levelText = level.levelName;

        // Draw the frame
        draw_set_color(levelSelectConfig.color);
        draw_rectangle(posX - 50, posY - 50, posX + 50, posY + 50, true);

        // Draw the level name
        draw_set_color(c_white);
        draw_text(posX, posY, levelText);

        //// Draw connecting lines to the next level in the row
        //if ((i + 1) mod levelSelectConfig.levelsPerRow != 0 && i < array_length(levelSelectConfig.levels) - 1) {
        //    var nextLevel = levelSelectConfig.levels[i + 1];
        //    draw_line(posX + 50, posY, nextLevel.position[0] - 50, nextLevel.position[1]);
        //}

        //// Draw connecting lines to the next row
        //if (i + levelSelectConfig.levelsPerRow < array_length(levelSelectConfig.levels)) {
        //    var nextRowLevel = levelSelectConfig.levels[i + levelSelectConfig.levelsPerRow];
        //    draw_line(posX, posY + 50, nextRowLevel.position[0], nextRowLevel.position[1] - 50);
        //}
    }
}

mouseOverAny = false;
function updateLevelSelect(levelSelectConfig) {

    for (var i = 0; i < array_length(levelSelectConfig.levels); i++) {
        var level = levelSelectConfig.levels[i];
        var posX = level.position[0];
        var posY = level.position[1];

        // Check if mouse is hovering over this level
        if (mouse_x > posX - 50 && mouse_x < posX + 50 &&
            mouse_y > posY - 50 && mouse_y < posY + 50) {

            // Play hover sound if this is the first hover frame
            if (!mouseOverAny) {
                audio_play_sound(levelSelectConfig.hoverSound, 1, false);
            }

            mouseOverAny = true;

            // Check for a click
            if (mouse_check_button_pressed(mb_left)) {
                audio_play_sound(levelSelectConfig.clickSound, 1, false);
				soundManager.playMusic("gameplay");
				with objFade fadeToRoom(level.roomName)
            }
        }
    }
}

// Set up the level positions dynamically
function setupLevelPositions(levelSelectConfig) {
    var levels = levelSelectConfig.levels;
    var levelsPerRow = levelSelectConfig.levelsPerRow;

    // Camera dimensions and position
    var cam = view_camera[0];
    var camX = camera_get_view_x(cam);
    var camY = camera_get_view_y(cam);
    var camWidth = camera_get_view_width(cam);
    var camHeight = camera_get_view_height(cam);

    // Level frame size and spacing
    var levelWidth = 100; // Width of each level frame
    var levelHeight = 100; // Height of each level frame
    var horizontalSpacing = 150; // Spacing between levels horizontally
    var verticalSpacing = 150; // Spacing between levels vertically

    // Calculate grid width and start position based on camera size
    var gridWidth = (levelsPerRow - 1) * horizontalSpacing + levelWidth;
    var gridHeight = ((array_length(levels) div levelsPerRow) + 1) * verticalSpacing;

    // Start position ensures the grid is centered within the camera view
    var startX = camX + (camWidth - gridWidth) / 2;
    var startY = camY + (camHeight - gridHeight) / 2;

    // Assign positions
    for (var i = 0; i < array_length(levels); i++) {
        var row = i div levelsPerRow;
        var col = i mod levelsPerRow;

        var posX = startX + col * horizontalSpacing;
        var posY = startY + row * verticalSpacing;

        levels[i].position = [posX, posY];
    }
}

setupLevelPositions(levelSelectConfig);




