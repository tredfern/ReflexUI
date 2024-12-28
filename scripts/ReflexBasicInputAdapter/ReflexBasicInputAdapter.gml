function ReflexBasicInputAdapter() : ReflexInputAdapterBase() constructor {
    deviceNumber = 0;
        
    static getMouseX = function() {
        return device_mouse_x_to_gui(0);
    }
    
    static getMouseY = function() {
        return device_mouse_y_to_gui(0);
    }
    
    static checkPressed = function(_verb) {
        switch(_verb) {
            case mb_left:
            case mb_right:
            case mb_middle:
            case mb_side1:
            case mb_side2:
            case mb_any:
            case mb_none:
                return mouse_check_button_pressed(_verb);
            default:
                return keyboard_check_pressed(_verb);
        }
    }
    
    static check = function(_verb) {
        switch(_verb) {
            case mb_left:
            case mb_right:
            case mb_middle:
            case mb_side1:
            case mb_side2:
            case mb_any:
            case mb_none:
                return mouse_check_button(_verb);
            default:
                return keyboard_check(_verb);
        }
    }
    
    
    static gamepadEnabled = function() {
        return false;
    }
}