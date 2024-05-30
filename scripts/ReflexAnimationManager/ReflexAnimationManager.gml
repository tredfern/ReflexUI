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

function reflexAnimations(_animations) {
	reflexStructMergeValues(REFLEXUI.animations.animationList, _animations);	
}

function reflexRegisterAnimation(_component, _animationNames, _duration) {
	_animationNames = reflexEnsureArray(_animationNames);
	for(var _i = 0; _i < array_length(_animationNames); _i++) {
		var _name = _animationNames[_i];
		var _animation = REFLEXUI.animations.animationList[$ _name];
	
		var _track = new ReflexAnimationTrack(_component, _name, _animation, 1 / _duration, _component[$ REFLEX_PROPERTY_ANIMATION_DELAY]);
		array_push(REFLEXUI.animations.activeAnimations, _track);
		_animation.start(_track);
	}
}

function reflexRemoveAnimation(_animation) {
	var _i = array_get_index(REFLEXUI.animations.activeAnimations, _animation);
	array_delete(REFLEXUI.animations.activeAnimations, _i, 1);
}

function reflexRemoveAllAnimations(_component) {
	for(var _i = array_length(REFLEXUI.animations.activeAnimations) - 1; _i > 0; _i--) {
		if(REFLEXUI.animations.activeAnimations[_i].component == _component) {
			array_delete(REFLEXUI.animations.activeAnimations, _i, 1);
		}	
	}
}

function reflexStopAnimations(_component, _animations) {
		_animations = reflexEnsureArray(_animations);
		for(var _i = array_length(REFLEXUI.animations.activeAnimations) - 1; _i > 0; _i--) {
			var _a = REFLEXUI.animations.activeAnimations[_i];
			if(_a.component == _component && array_contains(_animations, _a.name)) {
				_a.animation.stop(_a);
			}
		}	
	}