function ReflexUIDefaultConfiguration() {
	REFLEXUI.drawBoxModel = false;		// Enable to draw boundaries around components for layout c_fushcia is content, c_red is visible, c_lime is the total area with margins
	REFLEXUI.audioHandler = reflexAudioDefault;		// Called when playing sound, pass a custom handler for your own sound library, e.g. FMOD
	
    ///
    /// INPUT CONFIGURATIONS
    ///
    
    REFLEXUI.inputDelay = 10;			// Sets how many frames to wait before triggering a focus change or other input event with the gamepad or keyboard
    REFLEXUI.hideMouseIfController = false;
    
    //REFLEXUI.inputAdapter = new ReflexInputLibAdapter();            // Adapter for https://github.com/offalynne/Input/
      //reflexInputVerbs({
		//// These are the critical verbs for reflex
		//// How to navigate the focus and what to check for "click" events
		//click: "click",	
		//accept: "accept",	        // Accept behaves similiar to a click by default
		//up: "up",							
		//down: "down",
		//right: "right",
		//left: "left",		
        //cancel: "cancel"
	//});
    
    REFLEXUI.inputAdapter = new ReflexBasicInputAdapter();        // Basic adapter that uses GML functions for input
    reflexInputVerbs({
        // These are the critical verbs for reflex
        // How to navigate the focus and what to check for "click" events
        click:  mb_left,	
        accept: vk_enter,	        // Accept behaves similiar to a click by default
        up:     vk_up,							
        down:   vk_down,
        right:  vk_right,
        left:   vk_left,	
        cancel: vk_escape,	
    })
	
    
    ///
    /// Styles and Colors
    /// 
    
	reflexColors({
		textDark: c_black,
		textLight: c_ltgray,
		lightShade: c_ltgray,
		lightAccent: c_yellow,
		darkShade: c_navy,
		darkAccent: c_olive,
		primary: c_purple,
		focus: c_lime
	});
		
	
	// Default styles for components
	reflexStyleSheet({
        
        // Default sets the basic properties for all components and ensures that all values are set to sensible defaults.
        // Not all components are dependent on these values, but these values ensure that layouts and drawing can work out of the box
		__default: {
			//	Position Properties
			position:						ReflexPosition.relative,	// Relative position means "relative to it's normal position", "absolute", this is the position in relation to the parent
			x:								0,							// X & Y will draw the component in an offset relative to it's normal position
			y:								0,
			
			//	Size Properties
			width:							ReflexProperty.auto,		// Auto properties will be calculated by the engine	
			height:							ReflexProperty.auto,		// Width/Height can accept percentage strings to specify a certain amount of width of the parent
			
			//	Layout Properties
			layout:							ReflexLayout.block,			// Block elements extend as far to the right as possible
			overflow:						ReflexOverflow.Constrain,	// Sets the sizes should be set 
			margin:							0,							// Margin defines space between this component and others
			border:							0,							// Border is for any drawing of a border around the content
			padding:						0,							// Padding is area within the component that has background but pushes any content away from the sides
			halign:							fa_left,					// How this component should layout within it's parent
			valign:							fa_top,						// ...
    			
			//	Visual Properties
			alpha:							ReflexProperty.inherit,							// Opacity for drawing commands			
			font:							ReflexProperty.inherit,		// Use the font set to your parent
			fontScale:						1,
			color:							ReflexProperty.inherit,		// Use the foreground color of your parent
			backgroundColor:				ReflexProperty.off,			// Disable background color
			backgroundImage:				undefined,					// Provides an image to be used for the background -> Color still must be set for drawing to occur
			backgroundShader:				undefined,					// Shader to use while drawing the background
			borderColor:					ReflexProperty.off,			// Disable border color
			borderImage:					undefined,					// Image to use drawing the border
			isVisible:						true,						// By default all components should be seen
			colorChangeRate:				1,							// Speed at which a color change will propogate between 0 and 1				shader:							undefined,					// Custom Shader to use while drawing
			shader:                         undefined,

			// Input Properties
			canFocus:						false,						// Whether this component can receive focus		
			focusOrder:						ReflexProperty.auto,		// Sets whether the layout should figure out how to navigate around controls. Set to off to disable
			focusUp:						undefined,					// The focus direction properties should only be set if focusOrder is set to off
			focusDown:						undefined,					// These will determine what control to navigate to if direction input is provided
			focusLeft:						undefined,
			focusRight:						undefined,
			focusOnHover:					false,
			
			// Animation Properties
			animation:						undefined,
			animationDuration:				0,
			
			// Audio Properties
			audioFocus:						undefined,
			audioClick:						undefined,
			audioMouseEnter:				undefined,
		
		},
		
		// Root is a container wrapped around any render
		// It can be used to set default properties that are inherited
		ReflexRoot: {
			alpha:	1,
			color: 	c_black,
			font:	fntReflexDefault,
			height:	"100%",
			width:	"100%",
		},
		
		ReflexBlock: {
				
		},
		
		ReflexButton: {
			layout: ReflexLayout.inline,
			padding: { left: 15, top: 10, bottom: 10, right: 15 },
			colorChangeRate: 0.1,
			ReflexText: {
				//halign: fa_center,
				valign: fa_middle
			}
		},
		
		ReflexImage: {
			layout: ReflexLayout.inline,
			color: c_white
		},
		
        ReflexInline: {
            layout: ReflexLayout.inline
        },
		
		ReflexMenu: {
			halign: fa_center,
			valign: fa_middle,
			width: "50%"
		},
		
		ReflexMenuItem: {
			colorChangeRate: 0.1,
			backgroundColor: "lightShade",
			margin: 5,
			border: 2,
			focusOnHover: true,
			hover: {
				backgroundColor: "lightAccent",
				color: "textDark"
			},
			focus: {
				borderColor: "focus",
				color: "textLight"
			},
			canFocus: true,
			ReflexText: {
				halign: fa_center,
				valign: fa_middle
			}
		},
		
		
		ReflexProgressBar: {
			
		},
		
		ReflexText: {
			layout:	ReflexLayout.inline,
			sdfEffects: {},
            textHAlign: fa_left,                // Specific to text aligning properties, aligns text within element
            textVAlign: fa_top,
		}
	});
}

function ReflexUserConfiguration(_configuration) {
	if(ReflexUIIsLoaded()) {
		reflexDebugMessage("Loading custom configuration");
		_configuration();
	} else {
		reflexDebugMessage("Setting custom configuration to load on initialization");
		REFLEXUI_USER_CONFIGURATION = _configuration;	
	}
}