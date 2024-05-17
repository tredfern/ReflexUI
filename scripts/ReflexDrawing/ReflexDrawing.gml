function reflexDrawAll() {
	for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
		reflexDraw(REFLEX_ROOTS[_i]);	
	}
}

//
// Traverse the component hierarchy rendering each component
//
function reflexDraw(_component) {
	//	Painters draw component
	reflexDrawBackground(_component);
	reflexDrawBorder(_component);
	reflexSafeEvent(_component, EVENT_ON_DRAW, _component.boxModel.getScreenRect());

	//	Draw children
	array_foreach(_component.children, reflexDraw);
}

function reflexDrawBackground(_component) {
	
}

function reflexDrawBorder(_component) {
	
}