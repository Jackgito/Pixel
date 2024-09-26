isPaused = false;
pauseSurf = -1;
pauseSurfBuffer = -1;

global.renderSettings = noone;
menuConfig = [
    {
        name: "Difficulty",
        draw: difficultySettings
    },
    {
        name: "Sounds",
        draw: soundSlider
    },
    {
        name: "Music",
        draw: musicSlider
    },
    {
        name: "Quit",
        clickEvent: endGame
    }
];

