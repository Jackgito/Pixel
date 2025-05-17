// Display room number
if (currentRoom != room) {
    // Convert the room name to a displayable format
    var roomNumber = string_digits(room_get_name(room)); // Extract digits from the room name
    text = "Level " + roomNumber;
    // Start the message timer
    textTimer = textDuration;

    // Update the currentRoom variable
    currentRoom = room;
}

gameIsPaused = false;