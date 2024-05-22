function reflexRender(_components) {
	if(is_struct(_components)) {
		_components = [_components];	
	}
	var _root = new ReflexRoot(_components);
	// Convert any strings to ReflexText components
	ReflexTreeOperator(_root, reflexReplaceStringWithText);
	//ReflexTreeOperator(_root, reflexPerformRender);
	
	array_push(REFLEX_ROOTS, _root);
	reflexFlagRefresh();
}

function reflexFlagRefresh() {
	REFLEX_GLOBAL.needsRefresh = true;	
}

function reflexReplaceStringWithText(_component, _index, _parent) {
	if(is_string(_component)) {
		var _text = new ReflexText({ text: _component });
		_parent.children[_index] = _text;
	}
}

function reflexClearAll() {
	ReflexOperationOnAll(reflexRemove);	
	REFLEX_ROOTS = [];
}

function reflexRemove(_component) {
	reflexSafeEvent(_component, REFLEX_EVENT_UNLOAD);
	delete _component;
}

function reflexPerformRender(_component) {
	if(struct_exists(_component, "render")) {
		_component.children = _component.render();	
	}
}