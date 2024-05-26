function ReflexImage(_props) : ReflexComponent(_props, [], "ReflexImage") constructor {
	layout = ReflexLayout.inline;
	frameNumber = 0;
	
	static onLayout = function(_contentSize) {
		_contentSize.width = sprite_get_width(sprite);
		_contentSize.height = sprite_get_height(sprite);
	}
	
	static onDraw = function(_drawArea, _colors) {
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