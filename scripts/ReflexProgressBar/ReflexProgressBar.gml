function ReflexProgressBar(_props, _children) : ReflexComponent(_props, _children) constructor {	
	static onLayout = function(_contentSize)  {
		// If we have a fill image set the content size to that image
		if(sprite_exists(self[$ "fillImage"])) {
			_contentSize.height = sprite_get_height(self[$ "fillImage"]);
		}
	}
	
	static onDraw = function(_drawArea, _colors) {
		//calculate fill percentage
		var _fill = (value - minValue) / (maxValue - minValue);
		var _width = _drawArea.width * _fill;
		
		if(sprite_exists(self[$ "fillImage"])) {
			draw_sprite_stretched_ext(self[$ "fillImage"], 0, _drawArea.left, _drawArea.top, _width, _drawArea.height, _colors.color, alpha);
		} else {
			// just draw a rectangle
			draw_set_color(_colors.color);
			draw_set_alpha(alpha);
			draw_rectangle(_drawArea.left, _drawArea.top, _drawArea.left + _width, _drawArea.bottom, false);
		}
	}
}