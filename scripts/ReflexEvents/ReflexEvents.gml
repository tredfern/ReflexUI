#macro REFLEX_EVENT_ON_DRAW		"onDraw"
#macro REFLEX_EVENT_ON_LAYOUT	"onLayout"
#macro REFLEX_EVENT_ON_LOAD		"onLoad"
#macro REFLEX_EVENT_ON_STEP		"onStep"


function reflexSafeEvent(_component, _event, _params = REFLEX_EMPTY) {
	if(struct_exists(_component, _event)) {
		with(_component) {
			_component[$ _event](_params);	
		}
	}
}
