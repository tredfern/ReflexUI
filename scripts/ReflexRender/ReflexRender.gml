function reflexRender(_components) {
	if(is_struct(_components)) {
		_components = [_components];	
	}
	var _root = new ReflexRoot(_components);
	reflexPerformRender(_root);
	
	//ReflexTreeOperator(_root, reflexPerformRender, undefined);
	
	array_push(REFLEX_ROOTS, _root);
	reflexFlagRefresh();
}

function reflexFlagRefresh() {
	REFLEX_GLOBAL.needsRefresh = true;	
}

function reflexClearAll() {
	array_foreach(REFLEX_ROOTS, reflexRemove);
	//ReflexOperationBottomUp(reflexRemove);	
	REFLEX_ROOTS = [];
}

//TODO: Making a real house of cards operation on this clean up
function reflexRemove(_component) {
	reflexSafeEvent(_component, REFLEX_EVENT_UNLOAD);
	_component.isLoaded = false;
	
	array_foreach(_component.children, reflexRemove);
	
	if(_component.parent != undefined && _component.parent.isLoaded)
		_component.parent.removeChild(_component);
	
	_component.parent = undefined;
	_component.children = undefined;
	_component.dead = true;
	
	//Unregister step event if necessary
	if(_component[$ REFLEX_EVENT_ON_STEP] != undefined) {
		var _i = array_get_index(REFLEX_GLOBAL.stepEvents, _component);
		array_delete(REFLEX_GLOBAL.stepEVents, _i, 1);
	}
	
	if(_component == REFLEX_INPUT.focus)
		REFLEX_INPUT.focus = undefined;
		
	delete _component;
}

function reflexPerformRender(_component) {
	with(_component) {
		// First off, swap out any strings with text elements
		//parent = _parent;
	
		// Load the component
		loadComponent();
	
		//Render if necessary
		if(is_callable(_component[$ "render"])) {
			children = reflexEnsureArray(render());
		}
		
		setChildrenParent();
		array_foreach(children, reflexPerformRender);
	}
}