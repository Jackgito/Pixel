// INI structure
//[Levels]
//Level1=1
//Level2=0
//Level3=0


// Mark a level as completed
function saveLevelCompletion(level) {
    ini_open("progress.ini");
    ini_write_real("Levels", "Level" + string(level), 1);
	show_debug_message("Level " + string(level) + " completed and saved.");
    ini_close();
}

function isLevelUnlocked(level) {
    // First level is always unlocked
    if (level == 1) return true;

    ini_open("progress.ini");

    // Check if the previous level is completed
    var previousLevelCompleted = ini_read_real("Levels", "Level" + string(level - 1), 0); // Default to 0 (not completed)
    
    // Check if the current level is explicitly marked as unlocked
    var currentLevelUnlocked = ini_read_real("Levels", "Level" + string(level), 0); // Default to 0 (locked)

    ini_close();

    // A level is unlocked if it is explicitly marked as unlocked or if the previous level is completed
    var unlocked = (currentLevelUnlocked == 1) || (previousLevelCompleted == 1);

    return unlocked;
}

