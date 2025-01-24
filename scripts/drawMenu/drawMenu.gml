/*

This function uses menu configuration to draw menu elements.

The menu config is an array of structs, and each struct can have three propteries:
- name is the text drawn to the screen
- draw calls a function to render additional menu elements, such as sliders
- clickEvent calls the specified function when the menu item is clicked

Example:
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

*/

function drawMenu(menu, heightModifier = 50) {
	
	// Get the view position and size
	var viewX = camera_get_view_x(view_camera[0]);
	var viewY = camera_get_view_y(view_camera[0]);
	var viewWidth = camera_get_view_width(view_camera[0]);
	var viewHeight = camera_get_view_height(view_camera[0]);
    
	// Calculate the position to center the text within the current view
	var menuX = viewX + (viewWidth / 2);
	var menuY = viewY + (viewHeight) / 3 - heightModifier;
	
	
	draw_set_halign(fa_center);
	draw_set_valign(fa_middle);

    for (var i = 0; i < array_length(menu); i++) {
        var item = menu[i];
        
		var spacing = 48;
        var scale = 0.4;
        var color = c_white;
        var textWidth = string_width(item.name);
        var textHeight = string_height(item.name);
		var isTitle = variable_struct_exists(item, "type") && item.type == "Title";

        if (mouse_x < menuX + textWidth / 3 && mouse_x > menuX - textWidth / 3 && mouse_y < menuY + textHeight / 4 && mouse_y > menuY - textHeight / 4 && !isTitle) {
            scale = 0.5;
            color = c_aqua;
			
			if (mouse_check_button_pressed(mb_left) && struct_exists(item, "clickEvent")) {
				item.clickEvent();
				audio_play_sound(sfxClick, 0, false);
			}
        }
		
		// Check if the 'type' property exists and is "Title"
		if (isTitle) {
		    draw_set_font(fontTitle);
			spacing *= 2;
		} else {
		    // Set a default font if it's not a title
		    draw_set_font(fontMain); // Replace with your default menu font if different
		}

        draw_set_color(c_white);
        draw_text_transformed(menuX, menuY, item.name, scale, scale, 0);
        draw_set_color(c_white);
		
        menuY += spacing;
    }
}