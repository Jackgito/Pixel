/// drawLevels(roomArray)
/// Arguments: roomArray - an array of room names to be drawn with selectors
function drawLevels(roomArray) {
    var levelCount = array_length(roomArray);

    // Get the camera's view information
    var camera = view_camera[0]; // Default camera
    var viewX = camera_get_view_x(camera);
    var viewY = camera_get_view_y(camera);
    var viewWidth = camera_get_view_width(camera);
    var viewHeight = camera_get_view_height(camera);

    // Dimensions of each level selector (32x32 scaled by 4)
    var levelWidth = 64;
    var levelHeight = 64;

    // Grid settings
    var columns = 3; // Number of levels per row
    var rows = ceil(levelCount / columns); // Calculate the number of rows needed
    var hSpacing = 50; // Horizontal spacing between levels
    var vSpacing = 50; // Vertical spacing between rows

    // Calculate total width and height of the grid
    var gridWidth = (levelWidth + hSpacing) * columns - hSpacing;
    var gridHeight = (levelHeight + vSpacing) * rows - vSpacing;

    // Calculate starting position to center the grid
    var startX = viewX + (viewWidth - gridWidth) / 2;
    var startY = viewY + (viewHeight - gridHeight) / 2;

    // Loop through the levels and place them in a grid
    for (var i = 0; i < levelCount; i++) {
        var targetRoom = roomArray[i];
        var levelName = i + 1; // Level names start from 1

        // Calculate the current row and column
        var col = i mod columns;
        var row = floor(i / columns);

        // Calculate the position for this level
        var xPos = startX + col * (levelWidth + hSpacing);
        var yPos = startY + row * (levelHeight + vSpacing);

        // Create a new objLevelSelector at the calculated xPos, yPos
        var levelSelector = instance_create_layer(xPos, yPos, "MainMenu", objLevelSelector, {targetRoom: targetRoom, levelName: levelName});
    }
}
