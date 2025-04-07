if (!hasTriggeredExit) {
    hasTriggeredExit = true;

    with (objFade) fadeToRoom(other.targetRoom, 30, other.fadeColor);
    global.power = 0;
    audio_group_stop_all(audioGroupSfx);
	saveLevelCompletion(currentRoom);
}
