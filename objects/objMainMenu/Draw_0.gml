var heightModifier = -50;

switch (menuState) {
    case "Main":
        drawMenu(mainMenu, heightModifier);
        break;
        
    case "Controls":
        drawMenu(controlsMenu, heightModifier * -1);
        break;
        
    case "Start game":
		drawLevels(rooms);
		drawMenu(levelsMenu, heightModifier * 5) // Back button
}