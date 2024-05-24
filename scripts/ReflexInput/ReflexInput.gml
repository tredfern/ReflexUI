function ReflexInput() constructor {
	mouseOver = [];
	verbs = {};
	focus = undefined;
	mousePos = { x: 0, y: 0 };
	hotVerbs = ds_map_create();
	
	static step = function() {
		// Mouse Input
		mousePos.x = mouseX();
		mousePos.y = mouseY();
	
		var _currentMouseOver = reflexTreeFindAll(reflexIsPointInControl, mousePos, undefined, true);
		
		var _exiting = reflexArrayMissing(mouseOver, _currentMouseOver);
		var _entering = reflexArrayMissing(_currentMouseOver, mouseOver);
		
		//	Process Mouse Events
		reflexTriggerEvents(_exiting, REFLEX_EVENT_MOUSE_EXIT, mousePos);
		reflexRemoveTempStyle(_exiting, REFLEX_STYLE_HOVER);
		reflexTriggerEvents(_entering, REFLEX_EVENT_MOUSE_ENTER, mousePos);
		reflexApplyTempStyle(_entering, REFLEX_STYLE_HOVER);
		reflexTriggerEvents(_currentMouseOver, REFLEX_EVENT_MOUSE_OVER, mousePos);
		mouseOver = _currentMouseOver;
		
		//	Process clicks, mouse buttons
		if(checkVerbPressed(verbs.click)) {
			reflexTriggerEvents(mouseOver, REFLEX_EVENT_ON_CLICK);
		}
		
		// Keyboard / Gamepad input
		if(focus == undefined) {
			setFocus(findFirstFocusControl());	
		} else {
			if (checkVerbDelayed(verbs.up)) {
				changeFocus("focusUp");
			}
			
			if (checkVerbDelayed(verbs.down)) {
				changeFocus("focusDown");	
			}
			
			if (checkVerbDelayed(verbs.right)) {
				changeFocus("focusRight");	
			}
			
			if (checkVerbDelayed(verbs.left)) {
				changeFocus("focusLeft");	
			}
			
			if (checkVerbPressed(verbs.accept)) {
				reflexSafeEvent(focus, REFLEX_EVENT_ON_CLICK);	
			}
		}
		
		// Handle any "hotkey" verbs for controls that have special bindings
		var _verbs = ds_map_keys_to_array(hotVerbs);
		
		for(var _hv = 0; _hv < array_length(_verbs); _hv++) {
			if(checkVerbPressed(_verbs[_hv])) {
				reflexSafeEvent(hotVerbs[? _verbs[_hv]], REFLEX_EVENT_ON_CLICK);
			}
			
		}
	}
	
	static mouseX = function() {
		return input_mouse_x(INPUT_COORD_SPACE.GUI);
	}
	
	static mouseY = function() {
		return input_mouse_y(INPUT_COORD_SPACE.GUI);
	}
	
	static checkVerbPressed = function(_verb) {
		return input_check_pressed(_verb);
	}
	
	static checkVerbDelayed = function(_verb) {
		if(REFLEX_GLOBAL.__inputCooldown <= 0) {
			if(input_check(_verb)) {
				REFLEX_GLOBAL.__inputCooldown = REFLEX_GLOBAL.inputDelay;
				return true;
			}
		}
		return false;
	}
	
	static setFocus = function(_focusControl) {
		if(_focusControl == undefined)
			return;
			
		if(_focusControl.canFocus) {
			if(_focusControl.hasChildren()) {
				var _childFocus = reflexArrayFindFirst(_focusControl.children, canHaveFocus);
				if(!is_undefined(_childFocus)) {
					setFocus(_childFocus);
					return;
				}
			} 
			
			if (focus != undefined) {
				reflexSafeEvent(focus, REFLEX_EVENT_ON_FOCUS_OUT, { nextControl: _focusControl });
				reflexRemoveTempStyle(focus, REFLEX_STYLE_FOCUS);	
			}
				
			reflexApplyTempStyle(_focusControl, REFLEX_STYLE_FOCUS);
			reflexSafeEvent(_focusControl, REFLEX_EVENT_ON_FOCUS, { previousControl: focus }); 
				
			focus = _focusControl;
		}
	}
	
	static changeFocus = function(_direction) {
		if(is_undefined(focus))
			return;
		
		//First check direct navigation
		if(canHaveFocus(focus[$ _direction]) ) {
			setFocus(focus[$ _direction]);
		} else {
			//Bubble to parent to try....
			var _p = focus.parent;
			
			
			while(_p != undefined) {
				var _focusEnabledComp = findClosestFocusableComponent(_p, _direction);
				if(canHaveFocus(_focusEnabledComp)) {
					setFocus(_focusEnabledComp)
					break;
				}
				
				_p = _p.parent;
			}
			
			show_debug_message($"Cannot change focus {_direction}");
		}
		
	}
	
	static canHaveFocus = function(_component) {
		return !is_undefined(_component) && _component.canFocus;	
	}
	
	static findFirstFocusControl = function() {
		return reflexTreeFindFirst(canHaveFocus);
	}
	
	static findClosestFocusableComponent = function(_searchArea, _direction) {
		//If we are searching 
		
		var _candidates = reflexTreeFindAll(canHaveFocus);
		var _best = undefined;
		var _bestScore = infinity;
		
		var _xDir = 0;
		var _yDir = 0;
		switch(_direction) {
			case "focusUp":
				_yDir = -1;
				break;
			case "focusDown":
				_yDir = 1;
				break;
			case "focusRight":
				_xDir = 1;
				break;
			case "focusLeft":
				_xDir = -1;
				break;
		}
		
		var _fScreen = focus.boxModel.getScreenRect();
		
		
		for(var _i = 0; _i < array_length(_candidates); _i++) {
			var _c = _candidates[_i];
			var _cScreen = _c.boxModel.getScreenRect();
			
			// First ensure we are in the right direction
			var _x = sign(_cScreen.midX - _fScreen.midX);
			var _y = sign(_cScreen.midY - _fScreen.midY);
			
			if(_xDir == 0 || _x == _xDir) {
				if(_yDir == 0 || _y == _yDir) {
					var _score = point_distance(_cScreen.midX, _cScreen.midY , _fScreen.midX, _fScreen.midY);
					if(_score < _bestScore) {
						_bestScore = _score;
						_best = _c;
					}
				}
			}
		}
		
		return _best;
	}
}

function reflexIsPointInControl(_component, _params) {
	return _component.boxModel.inScreenRect(_params.x, _params.y);
}

function reflexInputVerbs(_verbs) {
	reflexStructMergeValues(REFLEX_INPUT.verbs, _verbs);
}

function reflexRegisterHotVerb(_component, _verb) {
	REFLEX_INPUT.hotVerbs[? _verb] = _component;
}