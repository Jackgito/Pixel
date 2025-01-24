audio_group_load(audioGroupSfx);
audio_group_load(audioGroupMusic);

musicTracks = {
    "mainMenu": musMenu,
    "gameplay": musGameOwnMusic,
};
currentTrack = "";

function playMusic(trackName) {
    // Stop current track if it's playing
    if (currentTrack != "" && audio_is_playing(musicTracks[$ currentTrack])) {
        audio_stop_sound(musicTracks[$ currentTrack]);
    }

    // Start new track
    currentTrack = trackName;
	audio_play_sound(musicTracks[$ trackName], 1, true);
}

function stopMusic() {
    if (currentTrack != "" && audio_is_playing(musicTracks[currentTrack])) {
        audio_stop_sound(musicTracks[currentTrack]);
        currentTrack = "";
    }
}

function fadeToMusic(newTrack, fadeTime) {
    if (currentTrack != "") {
        audio_sound_gain(musicTracks[currentTrack], 0, fadeTime); // Fade out current track
    }
    alarm[0] = fadeTime; // Use an alarm to start the new track after the fade
    nextTrack = newTrack;
}