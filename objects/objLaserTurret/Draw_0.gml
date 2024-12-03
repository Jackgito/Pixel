if (global.power > 0) {
    var dirX = lengthdir_x(1, image_angle - 90);
    var dirY = lengthdir_y(1, image_angle - 90);

    draw_set_color(NEON_RED_LIGHT);

    if (laserContactPoint1 != undefined && is_array(laserContactPoint1)) {
        draw_line_width(
            x, y,
            laserContactPoint1[0].hitpointX + dirX,
            laserContactPoint1[0].hitpointY + dirY,
            laserWidth * 2
        );
    } else {
        draw_line_width(
            x, y,
            x + dirX * (1000 + 32), y + dirY * 1000,
            laserWidth * 2
        );
    }

    if (laserContactPoint2 != undefined && is_array(laserContactPoint2)) {
        draw_line_width(
            x, y,
            laserContactPoint2[0].hitpointX + dirX,
            laserContactPoint2[0].hitpointY + dirY,
            laserWidth * 2
        );
    } else {
        // No contact point, draw to maximum distance + 32 pixels
        draw_line_width(
            x, y,
            x + dirX * (1000 + 32), y + dirY * 1000,
            laserWidth * 2
        );
    }
}

draw_self();
