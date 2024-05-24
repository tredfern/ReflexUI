function reflexDrawAll() {
	for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
		reflexDraw(REFLEX_ROOTS[_i]);	
	}
}

//
// Traverse the component hierarchy rendering each component
//
function reflexDraw(_component, _x = 0, _y = 0) {
	if(!_component.isLoaded)
		return;
		
	var _screenRect = _component.boxModel.getScreenRect();
	var _contentRect = _component.boxModel.getContentRect();
	
	_x += _component.x;
	_y += _component.y;
	
	if(_x != 0 || _y != 0) {
		_screenRect = _screenRect.copy();
		_contentRect = _contentRect.copy();
		_screenRect.move(_x, _y);
		_contentRect.move(_x, _y);
	}
	
	
	
	with(_component) {
		//	Painters draw component
		reflexDrawBackground(_component, _screenRect);
		reflexDrawBorder(_component, _screenRect);
		
		drawingColors.color = merge_color(drawingColors.color, reflexGetColor(color), colorChangeRate);
		if(is_callable(self[$ REFLEX_EVENT_ON_DRAW])) 
			self[$ REFLEX_EVENT_ON_DRAW]({ location: _contentRect, colors: drawingColors });

		//	Draw children
		for(var _child = 0; _child < array_length(_component.children); _child++) {
			reflexDraw(_component.children[_child], _x, _y);	
		}
		//array_foreach(_component.children, reflexDraw);
	}
}

function reflexDrawBackground(_component, _screenRect) {
	with(_component) {
		if(self[$ REFLEX_PROPERTY_BACKGROUNDCOLOR] != ReflexProperty.off) {
			drawingColors.backgroundColor = merge_color(drawingColors.backgroundColor, reflexGetColor(backgroundColor), colorChangeRate);
			
			if(sprite_exists(self[$ REFLEX_PROPERTY_BACKGROUND_IMAGE])) {
				draw_sprite_stretched_ext(self[$ REFLEX_PROPERTY_BACKGROUND_IMAGE], 0, _screenRect.left, _screenRect.top, _screenRect.width, _screenRect.height, drawingColors.backgroundColor, 1);
			} else {
				draw_set_color(drawingColors.backgroundColor);
				draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
			}
		}
	}
}

function reflexDrawBorder(_component, _screenRect) {
	with(_component) {
		if(self[$ REFLEX_PROPERTY_BORDERCOLOR] != ReflexProperty.off) {
			drawingColors.borderColor = merge_color(drawingColors.borderColor, reflexGetColor(borderColor), colorChangeRate);
			draw_set_color(drawingColors.borderColor);
			var _borderSizes = _component.boxModel.border;
			
			draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.top + _borderSizes.top, false);
			draw_rectangle(_screenRect.left, _screenRect.bottom - _borderSizes.bottom, _screenRect.right, _screenRect.bottom, false);
			draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.left + _borderSizes.left, _screenRect.bottom, false);
			draw_rectangle(_screenRect.right - _borderSizes.right, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
		}
	}
}

function reflexGetColor(_color) {
	return is_string(_color) ? REFLEX_COLORS[$_color] : _color;
}