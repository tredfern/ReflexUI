function ReflexAnimationManager() constructor {
	animationList = {};
	activeAnimations = [];
	
	static step = function() {
		for(var _i = 0; _i < array_length(activeAnimations); _i++) {
			var _a = activeAnimations[_i];
			
			_a.animation.step(_a);
		}
	}
}


function ReflexAnimationTrack(_component, _animationName,  _animation, _speed) constructor {
	component = _component;
	name = _animationName;
	speed = _speed;
	animation = _animation;
	position = 0;
}

function reflexAnimations(_animations) {
	reflexStructMergeValues(REFLEX_ANIMATIONS.animationList, _animations);	
}

function reflexRegisterAnimation(_component, _animationNames, _duration) {
	_animationNames = reflexEnsureArray(_animationNames);
	for(var _i = 0; _i < array_length(_animationNames); _i++) {
		var _name = _animationNames[_i];
		var _animation = REFLEX_ANIMATIONS.animationList[$ _name];
	
		var _track = new ReflexAnimationTrack(_component, _name, _animation, 1 / _duration);
		array_push(REFLEX_ANIMATIONS.activeAnimations, _track);
		_animation.start(_track);
	}
}

function reflexRemoveAnimation(_animation) {
	var _i = array_get_index(REFLEX_ANIMATIONS.activeAnimations, _animation);
	array_delete(REFLEX_ANIMATIONS.activeAnimations, _i, 1);
}

function reflexRemoveAllAnimations(_component) {
	for(var _i = array_length(REFLEX_ANIMATIONS.activeAnimations) - 1; _i > 0; _i--) {
		if(REFLEX_ANIMATIONS.activeAnimations[_i].component == _component) {
			array_delete(REFLEX_ANIMATIONS.activeAnimations, _i, 1);
		}	
	}
}

function reflexStopAnimations(_component, _animations) {
		_animations = reflexEnsureArray(_animations);
		for(var _i = array_length(REFLEX_ANIMATIONS.activeAnimations) - 1; _i > 0; _i--) {
			var _a = REFLEX_ANIMATIONS.activeAnimations[_i];
			if(_a.component == _component && array_contains(_animations, _a.name)) {
				_a.animation.stop(_a);
			}
		}	
	}