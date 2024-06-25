function ReflexImage(_props) : ReflexComponent(_props, [], "ReflexImage") constructor {
	frameNumber = 0;
	
	
	static onLayout = function(_contentSize) {
		if(!sprite_exists(sprite))
			return;
			
		_contentSize.width = sprite_get_width(sprite);
		_contentSize.height = sprite_get_height(sprite);
	}
	
	static onDraw = function(_drawArea, _colors) {
		if(!sprite_exists(sprite))
			return;
		
		draw_sprite_stretched_ext(
			sprite, 
			frameNumber, 
			_drawArea.left, 
			_drawArea.top, 
			_drawArea.width, 
			_drawArea.height, 
			_colors.color, 
			alpha
		);
	}
}