/*

This function uses menu configuration to draw menu elements.

The menu config is an array of structs, and each struct can have three propteries:
- name is the text drawn to the screen
- draw calls a function to render additional menu elements, such as sliders
- clickEvent calls the specified function when the menu item is clicked

Example:
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

*/

function drawMenu(menu, heightModifier) {
	
	// Get the view position and size
	var viewX = camera_get_view_x(view_camera[0]);
	var viewY = camera_get_view_y(view_camera[0]);
	var viewWidth = camera_get_view_width(view_camera[0]);
	var viewHeight = camera_get_view_height(view_camera[0]);
    
	// Calculate the position to center the text within the current view
	var menuX = viewX + (viewWidth / 2);
	var menuY = viewY + (viewHeight) / 2 - heightModifier;
	
    var spacing = 48;
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

    for (var i = 0; i < array_length(menu); i++) {
        var item = menu[i];
        
        var scale = 0.4;
        var color = c_white;
        var textWidth = string_width(item.name);
        var textHeight = string_height(item.name);

        if (mouse_x < menuX + textWidth / 3 && mouse_x > menuX - textWidth / 3 && mouse_y < menuY + textHeight / 4 && mouse_y > menuY - textHeight / 4) {
            scale = 0.5;
            color = c_aqua;
			
			if (mouse_check_button_pressed(mb_left) && struct_exists(item, "clickEvent")) {
				item.clickEvent();
				audio_play_sound(sfxMenu, 0, false);
			}
        }

        draw_set_color(c_white);
        draw_text_transformed(menuX, menuY, item.name, scale, scale, 0);
        draw_set_color(c_white);
		
        menuY += spacing;
    }
}