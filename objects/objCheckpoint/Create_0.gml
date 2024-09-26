image_speed = 0;


function saveGame() {
	ini_open("checkpoint.ini");
	ini_write_real("player", "x", x);
	ini_write_real("player", "y", y);
	ini_close();
}