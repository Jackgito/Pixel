function startGame() {
	with(objFade) {
		fadeIn = true;
		targetAlpha = 1;
		targetRoom = rm1;
		fadeSpeed = 0.02;
	}
};

menuState = "Main"

mainMenu = [
    {
        name: "Start game",
        clickEvent: function() {
			with (objMainMenu) menuState = "Start game";
        }
    },
    {
        name: "Quit",
        clickEvent: function() {
            instance_create_depth(0, 0, 0, objEndGame);
        }
    }
];

startMenu = [
    {
        name: "Save 1",
        clickEvent: startGame
    },
    {
        name: "Save 2",
        clickEvent: startGame
    },
    {
        name: "Save 3",
        clickEvent: startGame
    }
];