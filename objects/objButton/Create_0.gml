currentPower = 1; // Change glow intensity when power changes
glowColor = choose(NEON_BLUE_LIGHT, NEON_GREEN_LIGHT, NEON_PINK_LIGHT, NEON_YELLOW_LIGHT, NEON_PURPLE_LIGHT)

originalYScale = image_yscale;
pressedYScale = image_yscale * 0.25;
originalSpriteWidth = sprite_width;
originalSpriteHeight = sprite_height;

isPressed = false;

originalX = x;
originalY = y;

collisionTimer = 0;

image_speed = 0;
sprite_set_bbox_mode(sprButton, bboxmode_automatic)

