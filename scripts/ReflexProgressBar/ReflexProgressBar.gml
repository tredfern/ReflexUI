function ReflexProgressBar(_props, _children) : ReflexComponent(_props, _children, "ReflexProgressBar") constructor {	
	value = 0;
	minValue = 0;
	maxValue = 0;
	
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