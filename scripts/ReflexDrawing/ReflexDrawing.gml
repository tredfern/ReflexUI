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
		
	reflexSetDrawingColors(_component);
		
	var _screenRect = _component.boxModel.getScreenRect();
	
	with(_component) {
		
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
		if(reflexPropertyOn(REFLEX_PROPERTY_BACKGROUNDCOLOR)) {
			draw_set_color(drawingColors.backgroundColor);
			draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
		}
	}
}

function reflexDrawBorder(_component, _screenRect) {
	with(_component) {
		if(reflexPropertyOn(REFLEX_PROPERTY_BORDERCOLOR)) {
			draw_set_color(drawingColors.borderColor);
			var _borderSizes = _component.boxModel.border;
			
			draw_line_width(_screenRect.left, _screenRect.top + _borderSizes.top / 2, _screenRect.right, _screenRect.top + _borderSizes.top / 2, _borderSizes.top);
			draw_line_width(_screenRect.left, _screenRect.bottom - _borderSizes.bottom / 2, _screenRect.right, _screenRect.bottom - _borderSizes.bottom / 2, _borderSizes.bottom);
			draw_line_width(_screenRect.left + _borderSizes.left / 2, _screenRect.top, _screenRect.left + _borderSizes.left / 2, _screenRect.bottom, _borderSizes.left);
			draw_line_width(_screenRect.right - _borderSizes.right / 2, _screenRect.top, _screenRect.right - _borderSizes.right / 2, _screenRect.bottom, _borderSizes.right);

		}
	}
}

function reflexSetDrawingColors(_component) {
	with(_component) {
		// Perform any color transitions
		if(reflexPropertyOn(color)) {
			drawingColors.color = merge_color(drawingColors.color, reflexGetColor(color), colorChangeRate);
		}
		
		if(reflexPropertyOn(backgroundColor)) {
			drawingColors.backgroundColor = merge_color(drawingColors.backgroundColor, reflexGetColor(backgroundColor), colorChangeRate);
		}
		
		if(reflexPropertyOn(borderColor)) {
			drawingColors.borderColor = merge_color(drawingColors.borderColor, reflexGetColor(borderColor), colorChangeRate);
		}
	}
}

function reflexGetColor(_color) {
	if(is_string(_color)) {
		return REFLEX_COLORS[$ _color];
	}
	
	return _color;
}