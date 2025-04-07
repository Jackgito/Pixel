menuState = "Main"
rooms = [room1, room2, room3, room4, room5];

mainMenu = [
    {
        name: "Pixel",
		type: "Title"
    },
    {
        name: "Start game",
        clickEvent: function() {
            with (objMainMenu) menuState = "Start game";
        }
    },
    {
        name: "Controls",
        clickEvent: function() {
            with (objMainMenu) menuState = "Controls";
        }
    },
    {
        name: "Quit",
        clickEvent: function() {
            audio_group_set_gain(audioGroupMusic, 0, 50);
            audio_group_set_gain(audioGroupSfx, 0, 50);
            with (objFade) fadeOut(30, c_black, true);
        }
    }
];

controlsMenu = [
    {
        name: "Controls",
		type: "Title"
    },
    {
        name: "Left MB: Jump",
    },
    {
        name: "Right MB: Movement",
    },
    {
        name: "R: Restart",
    },
	{
        name: "F12: Fullscreen",
    },
		{
        name: "Esc: Pause menu",
    },
	{
	    name: "Back",
        clickEvent: function() {
            with (objMainMenu) menuState = "Main";
        }	
	}
];

levelsMenu = [
	{
	    name: "Back",
        clickEvent: function() {
            with (objMainMenu) menuState = "Main";
        }	
	}
];


// Create particle type
particleSystem = part_system_create();
particleEmitter = part_emitter_create(particleSystem);

ambientParticle = part_type_create();

// Set up particle appearance and behavior
part_type_shape(ambientParticle, pt_shape_square);
part_type_size(ambientParticle, 0, 0, 0.0005, 0);
part_type_color1(ambientParticle, make_color_rgb(200, 200, 200)); // Monochromatic color (light grey)
part_type_alpha3(ambientParticle, 1, 0.5, 0); // Fade over time
part_type_speed(ambientParticle, 0.05, 0.2, 0, 0); // Small random speed
part_type_direction(ambientParticle, 0, 360, 0, 0); // Move in any direction
part_type_life(ambientParticle, 60, 240); // Lifetime of particles
part_type_gravity(ambientParticle, 0.001, 90); // Small gravity for subtle drift