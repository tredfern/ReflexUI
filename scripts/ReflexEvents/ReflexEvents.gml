#macro REFLEX_EVENT_ON_CLICK	"onClick"
#macro REFLEX_EVENT_ON_DRAW		"onDraw"
#macro REFLEX_EVENT_ON_LAYOUT	"onLayout"
#macro REFLEX_EVENT_ON_LOAD		"onLoad"
#macro REFLEX_EVENT_MOUSE_ENTER	"onMouseEnter"
#macro REFLEX_EVENT_MOUSE_EXIT	"onMouseExit"
#macro REFLEX_EVENT_MOUSE_OVER	"onMouseOver"
#macro REFLEX_EVENT_ON_STEP		"onStep"
#macro REFLEX_EVENT_ON_UPDATE	"onUpdate"


function reflexSafeEvent(_component, _event, _params = REFLEX_EMPTY) {	
	if(struct_exists(_component, _event)) {
		with(_component) {
			_component[$ _event](_params);	
		}
	}
}

function reflexTriggerEvents(_componentList, _event, _params = REFLEX_EMPTY) {
	for(var _i = 0; _i < array_length(_componentList); _i++) {
		reflexSafeEvent(_componentList[_i], _event, _params);	
	}
}