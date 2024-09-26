/// @function drag_and_throw(shape)
/// @param {string} shape - The shape of the object, "circle" or "rectangle"
function dragAndThrow(shape) {

    // Detect if the mouse is clicking and dragging the object
    if (mouse_check_button(mb_left)) {
        var isInside = false;

        if (shape == "circle") {
            isInside = point_in_circle(mouse_x, mouse_y, phy_position_x, phy_position_y, 40);
        } else if (shape == "rectangle") {
            isInside = point_in_rectangle(mouse_x, mouse_y, bbox_left, bbox_top, bbox_right, bbox_bottom);
        }

        if (isInside) {
            isDragging = true;
            // Store the starting position when dragging begins
            dragStartX = mouse_x;
            dragStartY = mouse_y;
        }
    }

    // Handle dragging
    if (isDragging) {
        // Apply force to move the object towards the mouse
        var drag_distance_x = mouse_x - dragStartX;
        var drag_distance_y = mouse_y - dragStartY;
        
        // Calculate force to apply based on the distance dragged
        var force_x = drag_distance_x;
        var force_y = drag_distance_y;
        
        // Apply force to the physics body
        phy_position_x = mouse_x;
        phy_position_y = mouse_y;
        
        // Update the drag start position for the next frame
        dragStartX = mouse_x;
        dragStartY = mouse_y;
    }

    // Release object and stop dragging
    if (mouse_check_button_released(mb_left) && isDragging) {
        isDragging = false;
        // Calculate the final force based on the distance moved during the drag
        var final_distance_x = mouse_x - dragStartX;
        var final_distance_y = mouse_y - dragStartY;
        var final_force_x = final_distance_x;
        var final_force_y = final_distance_y;
        
        // Apply the final force
        physics_apply_impulse(phy_position_x, phy_position_y, final_force_x * 100, final_force_y * 100);
    }
}