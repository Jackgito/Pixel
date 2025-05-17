/// isGameLevel()
/// 
/// This function checks if the current room is a game level based on the room name.
/// It returns true if the current room name starts with "room" and the fifth character is a number (indicating it's a game level),
/// and false if it does not (e.g., for menu rooms or non-game rooms).
/// 
/// Usage:
/// You can call this function anywhere in your game to determine whether to apply game-specific
/// behaviors, like activating the glow effect or playing background music, based on the room type.
/// 
/// @returns {Boolean} true if the current room is a game level (room name starts with "room" and fifth character is a number),
/// false if it's not (e.g., main menu or other non-game room).
///
/// Example usage:
/// if (isGameLevel()) {
///     // Apply glow effect and play music for game levels
/// } else {
///     // Skip glow effect and handle non-game rooms differently
/// }

function isGameLevel() {
	var roomName = room_get_name(room);  // Get the current room name
	var roomNameHasNumber = string_length(string_digits(roomName)) > 0;

	// Check if the room name starts with "room" and the fifth character is a digit (number)
	if (string_copy(roomName, 1, 4) == "room" && roomNameHasNumber) {
	    return true;  // It's a game level
	} else {
	    return false;  // It's not a game level (e.g., menu or non-game room)
	}
}

