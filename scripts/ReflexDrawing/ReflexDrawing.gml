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
		
	with(_component) {
		var _screenRect = boxModel.getScreenRect();
		var _contentRect = boxModel.getContentRect();
	
		_x += x;
		_y += y;
	
		if(_x != 0 || _y != 0) {
			_screenRect = _screenRect.copy();
			_contentRect = _contentRect.copy();
			_screenRect.move(_x, _y);
			_contentRect.move(_x, _y);
		}
	
		//	Painters draw 
		if(backgroundColor != ReflexProperty.off) {
			reflexDrawBackground(_screenRect);
		}
		
		if(borderColor != ReflexProperty.off) {
			reflexDrawBorder(_screenRect);
		}
		
		drawingColors.color = merge_color(drawingColors.color, reflexGetColor(color), colorChangeRate);
		if(is_callable(self[$ REFLEX_EVENT_ON_DRAW])) 
			onDraw(_contentRect, drawingColors);

		//	Draw children
		for(var _child = 0; _child < array_length(children); _child++) {
			reflexDraw(children[_child], _x, _y);	
		}
	}
}

function reflexDrawBackground(_screenRect) {
	drawingColors.backgroundColor = merge_color(drawingColors.backgroundColor, reflexGetColor(backgroundColor), colorChangeRate);
			
	if(sprite_exists(backgroundImage)) {
		draw_sprite_stretched_ext(backgroundImage, 0, _screenRect.left, _screenRect.top, _screenRect.width, _screenRect.height, drawingColors.backgroundColor, 1);
	} else {
		draw_set_color(drawingColors.backgroundColor);
		draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
	}
}

function reflexDrawBorder(_screenRect) {
	drawingColors.borderColor = merge_color(drawingColors.borderColor, reflexGetColor(borderColor), colorChangeRate);
	draw_set_color(drawingColors.borderColor);
	var _borderSizes = boxModel.border;
			
	draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.top + _borderSizes.top, false);
	draw_rectangle(_screenRect.left, _screenRect.bottom - _borderSizes.bottom, _screenRect.right, _screenRect.bottom, false);
	draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.left + _borderSizes.left, _screenRect.bottom, false);
	draw_rectangle(_screenRect.right - _borderSizes.right, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
}

function reflexGetColor(_color) {
	return is_string(_color) ? REFLEX_COLORS[$_color] : _color;
}