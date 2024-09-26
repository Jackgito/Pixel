// File paths for save slots
var saveSlotFiles = ["saveSlot1.sav", "saveSlot2.sav", "saveSlot3.sav"];

// Helper function to get the file name for a given save slot
function getSaveFile(saveSlot) {
    return saveSlotFiles[saveSlot - 1];
}

// Struct to hold all save data
function SaveData(_animations, _power, _music, _sounds, _gravity, _roomName) constructor {
    animations = _animations;
    totalPower = _power;
    music = _music;
    sounds = _sounds;
    grav = _gravity;
    roomName = _roomName;
}

// Function: saveGame(saveSlot)
// Parameters: saveSlot (1, 2, or 3)
function saveGame(saveSlot) {
    var saveFile = getSaveFile(saveSlot);
    
    // Create a SaveData struct with the current global values and room name
    var saveData = new SaveData(
        global.animations,
        global.power,
        global.music,
        global.sounds,
        global.gravity,
        room_get_name(room) // Get current room name
    );
    
    // Convert the struct to a JSON string for saving
    var jsonData = json_stringify(saveData);
    
    // Open file for writing and save the JSON data
    var file = file_text_open_write(saveFile);
    file_text_write_string(file, jsonData);
    file_text_close(file);
}

// Function: loadGame(saveSlot)
// Parameters: saveSlot (1, 2, or 3)
function loadGame(saveSlot) {
    var saveFile = getSaveFile(saveSlot);
    
    // Check if the save file exists before trying to load it
    if (file_exists(saveFile)) {
        // Open file for reading and load the JSON data
        var file = file_text_open_read(saveFile);
        var jsonData = file_text_read_string(file);
        file_text_close(file);
        
        // Parse the JSON data back into a SaveData struct
        var saveData = json_parse(jsonData);
        
        // Restore global variables from the save data
        global.animations = saveData.animations;
        global.power = saveData.totalPower;
        global.music = saveData.music;
        global.sounds = saveData.sounds;
        global.gravity = saveData.grav;

        // Switch to the saved room
        var targetRoom = asset_get_index(saveData.roomName);
        if (targetRoom != -1) {
            room_goto(targetRoom);
        } else {
            show_message("Room not found!");
        }
    } else {
        show_message("No save file found in slot " + string(saveSlot));
    }
}

// Function: checkSaveFiles()
// This function returns an array indicating if save files exist for each slot.
function checkSaveFiles() {
    var saveStatus = [];
    
    for (var i = 0; i < 3; i++) {
        if (file_exists(saveSlotFiles[i])) {
            saveStatus[i] = true;  // Save file exists
        } else {
            saveStatus[i] = false; // No save file
        }
    }
    
    return saveStatus;
}
	
function loadLastPlayedSave() {
	return false;	
}