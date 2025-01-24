var heightModifier = -50;

switch (menuState) {
    case "Main":
        drawMenu(mainMenu, heightModifier);
        break;
        
    case "Controls":
        drawMenu(controlsMenu, heightModifier * -1);
        break;
        
    case "Start game":
		drawLevels([room1, room2, room3]);
		drawMenu(levelsMenu, heightModifier * 5) // Back button
}