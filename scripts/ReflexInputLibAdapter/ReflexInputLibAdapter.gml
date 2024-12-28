function ReflexInputLibAdapter() : ReflexInputAdapterBase() constructor {
    gamepadProfile = "gamepad";
    
    static getMouseX = function() {
        return input_mouse_x(INPUT_COORD_SPACE.GUI);
    }
    
    static getMouseY = function() {
        return input_mouse_y(INPUT_COORD_SPACE.GUI);
    }
    
    static checkPressed = function(_verb) {
        return input_check_pressed(_verb);
    }
    
    static check = function(_verb) {
        return input_check(_verb);
    }
    
    static gamepadEnabled = function() {
        return input_profile_get() == gamepadProfile;
    }
}