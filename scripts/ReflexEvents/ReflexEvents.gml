


function reflexSafeEvent(_component, _event, _params = {}) {
	with(_component) {
		if(!is_undefined(self[$ _event])) {
			self[$ _event](_params);		
		}
	}
}

function reflexTriggerEvents(_componentList, _event, _params = {}) {
	reflexAssert(is_array(_componentList), "Use reflexSafeEvent to trigger an event or a single component.");
	
	for(var _i = 0; _i < array_length(_componentList); _i++) {
		reflexSafeEvent(_componentList[_i], _event, _params);	
	}
}