function ReflexInputActionIcon(_props) : ReflexComponent(_props,,"ReflexInputActionIcon") constructor {
    
    static onLoad = function() {
        binding = input_binding_get(action);
        buttonIcon = input_binding_get_icon(binding);
    }
    
    static render = function() {
        if(is_string(buttonIcon)) {
            return new ReflexText({ text: buttonIcon });
        } else {
            return new ReflexImage({ sprite: buttonIcon, styles: "ButtonIconImage" })
        }
    }
    
    static onInputModeChanged = function() {
        binding = input_binding_get(action);
        buttonIcon = input_binding_get_icon(binding);
        refresh(true);
    }
}