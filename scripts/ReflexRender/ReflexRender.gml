function reflexRender(_components) {
	if(is_struct(_components)) {
		_components = [_components];	
	}
	var _root = new ReflexRoot(_components);
	
	ReflexTreeOperator(_root, reflexPerformRender, 0, undefined);
	
	array_push(REFLEX_ROOTS, _root);
	reflexFlagRefresh();
}

function reflexFlagRefresh() {
	REFLEX_GLOBAL.needsRefresh = true;	
}

function reflexClearAll() {
	ReflexOperationBottomUp(reflexRemove);	
	REFLEX_ROOTS = [];
}

function reflexRemove(_component) {
	reflexSafeEvent(_component, REFLEX_EVENT_UNLOAD);
	_component.parent = undefined;
	_component.children = undefined;
	_component.dead = true;
	
	if(_component == REFLEX_INPUT.focus)
		REFLEX_INPUT.focus = undefined;
		
	delete _component;
}

function reflexPerformRender(_component, _index, _parent) {
	// First off, swap out any strings with text elements
	_component.parent = _parent;
	
	// Load the component
	_component.loadComponent();
	
	//Render if necessary
	if(struct_exists(_component, "render")) {
		_component.children = reflexEnsureArray(_component.render());	
		_component.setChildrenParent();
	}
}