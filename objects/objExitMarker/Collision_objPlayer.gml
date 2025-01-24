with objFade fadeIn();
global.power = 0;
audio_group_stop_all(audioGroupSfx);
room_goto(targetRoom);

saveLevelCompletion(currentRoom);