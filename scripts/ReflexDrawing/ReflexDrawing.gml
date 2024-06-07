function reflexDrawAll() {
	for(var _i = 0; _i < array_length(REFLEXUI.roots); _i++) {
		reflexDraw(REFLEXUI.roots[_i]);	
	}
}

//
// Traverse the component hierarchy rendering each component
//
function reflexDraw(_component, _x = 0, _y = 0) {
	if(!_component.isLoaded || !_component.isVisible)
		return;
		
	with(_component) {
		if(_component.forceRefresh)
			reflexFlagRefresh();
			
		var _screenRect = boxModel.getLayoutRect();
		var _contentRect = boxModel.getContentRect();
	
		if(position == ReflexPosition.relative) {
			_x += x;
			_y += y;
		}
	
		if(_x != 0 || _y != 0) {
			_screenRect = _screenRect.copy();
			_contentRect = _contentRect.copy();
			_screenRect.move(_x, _y);
			_contentRect.move(_x, _y);
		}
		
		boxModel.setScreenRect(_screenRect);
	
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
		
		if(REFLEXUI.drawBoxModel) {
			draw_set_color(c_fuchsia);
			draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, true);
			draw_set_color(c_red);
			draw_rectangle(_contentRect.left, _contentRect.top, _contentRect.right, _contentRect.bottom, true);
			
			var _fullRect = boxModel.getFullRect();
			draw_set_color(c_lime);
			draw_rectangle(_fullRect.left, _fullRect.top, _fullRect.right, _fullRect.bottom, true);
			
		}
	}
}

function reflexDrawBackground(_screenRect) {
	drawingColors.backgroundColor = merge_color(drawingColors.backgroundColor, reflexGetColor(backgroundColor), colorChangeRate);
	
	var _showShader = !is_undefined(backgroundShader);
	if(_showShader)
		shader_set(backgroundShader);
			
	if(!is_undefined(backgroundImage) && sprite_exists(backgroundImage)) {
		draw_sprite_stretched_ext(backgroundImage, 0, _screenRect.left, _screenRect.top, _screenRect.width, _screenRect.height, drawingColors.backgroundColor, alpha);
	} else {
		draw_set_color(drawingColors.backgroundColor);
		draw_set_alpha(alpha);
		draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
	}
	
	if(_showShader)
		shader_reset();
}

function reflexDrawBorder(_screenRect) {
	drawingColors.borderColor = merge_color(drawingColors.borderColor, reflexGetColor(borderColor), colorChangeRate);
	draw_set_color(drawingColors.borderColor);
	draw_set_alpha(alpha);
	var _borderSizes = boxModel.border;
			
	draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.top + _borderSizes.top, false);
	draw_rectangle(_screenRect.left, _screenRect.bottom - _borderSizes.bottom, _screenRect.right, _screenRect.bottom, false);
	draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.left + _borderSizes.left, _screenRect.bottom, false);
	draw_rectangle(_screenRect.right - _borderSizes.right, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
}

function reflexGetColor(_color) {
	return is_string(_color) ? REFLEXUI.colors[$_color] : _color;
}