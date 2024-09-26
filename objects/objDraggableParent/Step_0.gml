// Detect if the mouse is clicking and dragging the object
if (mouse_check_button(mb_left)) {
    if (point_in_circle(mouse_x, mouse_y, phy_position_x, phy_position_y, 40)) {
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
	phy_position_x = mouse_x
	phy_position_y = mouse_y
    
    // Update the drag start position for the next frame
    dragStartX = mouse_x;
    dragStartY = mouse_y;
}

// Release object and stop dragging
if (mouse_check_button_released(mb_left) && isDragging) {
    isDragging = false;
    // Calculate the final force based on the distance moved during the drag
    //var final_distance_x = mouse_x - dragStartX;
    //var final_distance_y = mouse_y - dragStartY;
    //var final_force_x = final_distance_x * 0.1;
    //var final_force_y = final_distance_y * 0.1;
    
    //// Apply the final force
    //physics_apply_force(phy_position_x, phy_position_y, final_force_x, final_force_y);
}