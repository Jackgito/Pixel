// File paths for save slots
var saveSlotFiles = ["saveSlot1.sav", "saveSlot2.sav", "saveSlot3.sav"];

// Helper function to get the file name for a given save slot
function getSaveFile(saveSlot) {
    return saveSlotFiles[saveSlot - 1];
}

// Struct to hold all save data
function saveData(_animations, _power, _music, _sounds, _gravity, _roomName) constructor {
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