#macro EVENT_ON_DRAW		"onDraw"
#macro EVENT_ON_LAYOUT		"onLayout"

function reflexSafeEvent(_component, _event, _params = {}) {
	if(struct_exists(_component, _event)) {
		with(_component) {
			_component[$ _event](_params);	
		}
	}
}