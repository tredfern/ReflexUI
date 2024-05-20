function reflexMouseX() {
	return device_mouse_x_to_gui(REFLEX_MOUSE_DEVICE);
}

function reflexMouseY() {
	return device_mouse_y_to_gui(REFLEX_MOUSE_DEVICE);	
}

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
	focus = undefined;
	mousePos = { x: reflexMouseX(), y: reflexMouseY() };
	static step = function() {
		mousePos.x = reflexMouseX();
		mousePos.y = reflexMouseY();
	
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
		
		//	Process Mouse Enters
		
		
		//	Process Mouse Overs
		
		
		
		//	Process clicks, mouse buttons
		
		
		
		
		//	Process keyboard events
		
	}
}