function reflexDrawAll() {
	for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
		reflexDraw(REFLEX_ROOTS[_i]);	
	}
}

//
// Traverse the component hierarchy rendering each component
//
function reflexDraw(_component) {
	if(!_component.isLoaded)
		return;
		
	
		
	var _screenRect = _component.boxModel.getScreenRect();
	
	with(_component) {
		// Perform any color transitions
		drawingColors.color = merge_color(drawingColors.color, color, colorChangeRate);
	
		//	Painters draw component
		reflexDrawBackground(_component, _screenRect);
		reflexDrawBorder(_component, _screenRect);
		reflexSafeEvent(_component, REFLEX_EVENT_ON_DRAW, { location: _screenRect, colors: drawingColors });

		//	Draw children
		array_foreach(_component.children, reflexDraw);
	}
}

function reflexDrawBackground(_component, _screenRect) {
	with(_component) {
		if(reflexPropertyOn(_component, REFLEX_PROPERTY_BACKGROUNDCOLOR)) {
			drawingColors.backgroundColor = merge_color(drawingColors.backgroundColor, backgroundColor, colorChangeRate);
			draw_set_color(drawingColors.backgroundColor);
			draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
		}
	}
}

function reflexDrawBorder(_component, _screenRect) {
	with(_component) {
		if(reflexPropertyOn(_component, REFLEX_PROPERTY_BORDERCOLOR)) {
			drawingColors.borderColor = merge_color(drawingColors.borderColor, borderColor, colorChangeRate);
			draw_set_color(drawingColors.borderColor);
			draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, true);
		}
	}
}