function ReflexConfiguration() {
	
	// Default styles for components
	
	reflexStyleSheet({
		__default: {
			// Position Properties
			position:						ReflexPosition.relative,	// Relative positions will use X/Y to move component in specified direction.
			x:								0,							// X & Y will move the component 
			y:								0,
			width:							ReflexProperty.auto,		// Auto properties will be calculated by the engine	
			height:							ReflexProperty.auto,		// Width/Height can accept percentage strings to specify a certain amount of width of the parent
			
			//Layout Properties
			layout:							ReflexLayout.block,			// Block elements extend as far to the right as possible
			margin:							0,							// Margin defines space between this component and others
			border:							0,							// Border is for any drawing of a border around the content
			padding:						0,							// Padding is area within the component that has background but pushes any content away from the sides
			halign:							fa_left,					// How this component should layout within it's parent
			valign:							fa_top,						// ...
				
			//Visual Properties
			alpha:							1,							// Opacity for drawing commands			
			font:							ReflexProperty.inherit,		// Use the font set to your parent
			color:							ReflexProperty.inherit,		// Use the foreground color of your parent
			backgroundColor:				ReflexProperty.off,			// Disable background color
			borderColor:					ReflexProperty.off,			// Disable border color
			isVisible:						true						// By default all components should be seen
		},
		
		// Root is a container wrapped around any render
		// It can be used to set default properties that are inherited
		ReflexRoot: {
			color: 	c_black,
			font: fntReflexDefault,
		},
		
		ReflexBlock: {
				
		},
		
		ReflexMenu: {
			width: "50%",
			halign: fa_center,
			valign: fa_middle
		},
		
		ReflexMenuItem: {
		
		},
		
		ReflexMenuOptionText: {
			halign: fa_center,
			valign: fa_middle
		},
		
		ReflexText: {
			layout:							ReflexLayout.inline
		}
	});
}

function Reflex() {
	var _components = [];
	for(var _c = 0; _c < argument_count; _c++) {
		array_push(_components, argument[_c]);
	}
	reflexRender(_components);
}