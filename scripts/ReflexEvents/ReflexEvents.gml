


function reflexSafeEvent(_component, _event, _params = REFLEX_EMPTY) {	
	if(!is_undefined(_component[$ _event])) {
		_component[$ _event](_params);		
	}
}

function reflexTriggerEvents(_componentList, _event, _params = REFLEX_EMPTY) {
	reflexAssert(is_array(_componentList), "Use reflexSafeEvent to trigger an event or a single component.");
	
	for(var _i = 0; _i < array_length(_componentList); _i++) {
		reflexSafeEvent(_componentList[_i], _event, _params);	
	}
}