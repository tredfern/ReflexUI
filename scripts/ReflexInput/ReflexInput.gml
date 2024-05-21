function reflexIsPointInControl(_component, _params) {
	return _component.boxModel.inScreenRect(_params.x, _params.y);
}

function ReflexCoordinateSearch(_searchOp, _params) constructor {
	params = _params;
	matches = [];
	searchOp = _searchOp;
	
	static runSearch = function() {
		ReflexOperationOnAll(self.performSearchOp);
		return matches;
	}
	
	static performSearchOp = function(_component) {
		if(searchOp(_component, params))
			array_push(matches, _component);
	}
}

function ReflexInput() constructor {
	mouseOver = [];
	verbs = {};
	focus = undefined;
	mousePos = { x: 0, y: 0 };
	
	static step = function() {
		// Mouse Input
		mousePos.x = mouseX();
		mousePos.y = mouseY();
	
		var _mouseSearch = new ReflexCoordinateSearch(reflexIsPointInControl, mousePos);
		var _currentMouseOver = _mouseSearch.runSearch();
		
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
			
		if(!is_undefined(focus[$ _direction])) {
			setFocus(focus[$ _direction]);
		} else {
			show_debug_message($"Cannot change focus {_direction}");
		}
		
	}
	
	static canHaveFocus = function(_component) {
		return _component.canFocus;	
	}
	
	static findFirstFocusControl = function() {
		return reflexTreeFindFirst(canHaveFocus);
	}
}

function reflexInputVerbs(_verbs) {
	reflexStructMergeValues(REFLEX_INPUT.verbs, _verbs);
}