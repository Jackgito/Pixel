function bindKeyboard(_name, _key) constructor {
    bindName = _name;
    key = _key;
    
    // Store key states as variables
    isPressed = false;
    isHeld = false;
    isReleased = false;
    
    // Define functions to check key states
    updatePressed = function() {
        isPressed = keyboard_check_pressed(key);
    }
    updateHeld = function() {
        isHeld = keyboard_check(key);
    }
    updateReleased = function() {
        isReleased = keyboard_check_released(key);
    }
}

function inputUpdate() {
    with (inputManager) {
        for (var i = 0; i < array_length(keybinds); i++) {
            // Update the key states in the input update step
            keybinds[i].updatePressed();
            keybinds[i].updateHeld();
            keybinds[i].updateReleased();
        }
    }
}

function inputCheckPressed(_name) {
    with (inputManager) {
        for (var i = 0; i < array_length(keybinds); i++) {
            if (keybinds[i].bindName == _name) {
                return keybinds[i].isPressed;    
            }
        }
    }
    return false;
}

function inputCheckHeld(_name) {
    with (inputManager) {
        for (var i = 0; i < array_length(keybinds); i++) {
            if (keybinds[i].bindName == _name) {
                return keybinds[i].isHeld;    
            }
        }
    }
    return false;
}

function inputCheckReleased(_name) {
    with (inputManager) {
        for (var i = 0; i < array_length(keybinds); i++) {
            if (keybinds[i].bindName == _name) {
                return keybinds[i].isReleased;    
            }
        }
    }
    return false;
}

function initializeKeybinds() {
    with (inputManager) {
        keybinds = [
            new bindKeyboard("Move right", vk_right),
            new bindKeyboard("Move left", vk_left),
            new bindKeyboard("Jump", vk_space),
        ];
    }
}

function keybindings() {
    global.moveRight = inputCheckHeld("Move right");
    global.moveLeft = inputCheckHeld("Move left");
    global.jump = inputCheckHeld("Jump");
}