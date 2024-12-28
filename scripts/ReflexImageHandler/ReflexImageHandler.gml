function ReflexImageHandler(_sprite) constructor {
	sprite = _sprite;
	imageIndex = 0;
	info = sprite_get_info(sprite);
	framespeed = info.frame_speed;
	frameDuration =  framespeed / 1000;
	currentDuration = 0;
	maxFrame = info.num_subimages;
	lastFrameTime = current_time;
	
	static animateSprite = function() {
		var _time = current_time - lastFrameTime;
		if(_time > frameDuration) {
			imageIndex ++;
			lastFrameTime = current_time;
			if(imageIndex >= maxFrame)
				imageIndex = 0;
		}
	}
	
	static drawStretchedExt = function(_left, _top, _width, _height, _color, _alpha) {
		// should only trigger once per frame...
		animateSprite();
		
		draw_sprite_stretched_ext(sprite, imageIndex, _left, _top, _width, _height, _color, _alpha);
	}
}