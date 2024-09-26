var heightModifier = -50
switch (menuState) {
	case "Main":
		drawMenu(mainMenu, heightModifier);
	break;
	
	case "Start game":
		drawMenu(startMenu, heightModifier);
		break;	
}