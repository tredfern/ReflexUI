function reflexDrawAll() {
	for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
		reflexDraw(REFLEX_ROOTS[_i]);	
	}
}

//
// Traverse the component hierarchy rendering each component
//
function reflexDraw(_component) {
	if(!_component.isLoaded)
		return;
		
	var _screenRect = _component.boxModel.getScreenRect();
	//	Painters draw component
	reflexDrawBackground(_component, _screenRect);
	reflexDrawBorder(_component, _screenRect);
	reflexSafeEvent(_component, EVENT_ON_DRAW, _screenRect);

	//	Draw children
	array_foreach(_component.children, reflexDraw);
}

function reflexDrawBackground(_component, _screenRect) {
	if(reflexPropertyOn(_component, REFLEX_PROPERTY_BACKGROUNDCOLOR)) {
		draw_set_color(_component.backgroundColor);
		draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, false);
	}
}

function reflexDrawBorder(_component, _screenRect) {
	if(reflexPropertyOn(_component, REFLEX_PROPERTY_BORDERCOLOR)) {
		draw_set_color(_component.borderColor);
		draw_rectangle(_screenRect.left, _screenRect.top, _screenRect.right, _screenRect.bottom, true);
	}
}