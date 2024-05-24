function ReflexAnimation(_property, _curve, _lowValue, _highValue, _type = ReflexAnimationType.OneShot) constructor {
	property = _property;
	curve = _curve;
	low = _lowValue;
	high = _highValue;
	type = _type;
	channel = animcurve_get_channel(_curve, "magnitude");
	cascade = (property == "x" || property == "y");
	isColor = string_pos("color", string_lower(property)) > 0;

	
	static step = function(_params) {
		var _v = animcurve_channel_evaluate(channel, _params.position);
		var _update = {};
		
		if(isColor)
			_update[$ property] = merge_color(low, high, _v);
		else
			_update[$ property] = lerp(low, high, _v);
		
		_params.component.update(_update);
		
		//Do the delay after setting the property to make sure that the first frame is set
		_params.delay--;
		if(_params.delay > 0)
			return;
		
		_params.position += _params.speed;
		
		if(_params.position >= 1 || _params.position < 0) {
			switch(type) {
				case ReflexAnimationType.OneShot:
					stop(_params);
					break;
				case ReflexAnimationType.Loop:
					_params.position = 0;
					break;
				case ReflexAnimationType.PingPong:
					_params.speed = -_params.speed;
					break;
			}
			
		}
	}
	
	static start = function(_params) {
		_params.baseValue = _params.component[$ property];	
	}
	
	static stop = function(_animation) {
		var _update = {};
		_update[$ property] = _animation.baseValue;
		//Ensure we are at the end
		_animation.component.update(_update);
		
		// Remove animation from happening on the component
		reflexRemoveAnimation(_animation);
	}
	
}