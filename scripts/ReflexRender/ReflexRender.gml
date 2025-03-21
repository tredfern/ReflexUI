function reflexRender(_components) {
	if(is_struct(_components)) {
		_components = [_components];	
	}
	var _root = new ReflexRoot(_components);
	reflexPerformRender(_root);
	
	//ReflexTreeOperator(_root, reflexPerformRender, undefined);
	
	array_push(REFLEXUI.roots, _root);
	reflexFlagRefresh();
	
	return _root;
}

function reflexFlagRefresh() {
	REFLEXUI.needsRefresh = true;	
}

function reflexClearAll() {
	array_foreach(REFLEXUI.roots, reflexRemove);
	//ReflexOperationBottomUp(reflexRemove);	
	REFLEXUI.roots = [];
}

//TODO: Making a real house of Items operation on this clean up
function reflexRemove(_component) {	
	reflexSafeEvent(_component, REFLEX_EVENT_UNLOAD);
	_component.isLoaded = false;
	
	array_foreach(_component.children, reflexRemove);
	
	if(_component.parent != undefined && _component.parent.isLoaded)
		_component.parent.removeChild(_component);
	
	_component.parent = undefined;
	_component.children = undefined;
	_component.dead = true;
    _component.isLoaded = false;
	
	//Unregister step event if necessary
	if(_component[$ REFLEX_EVENT_ON_STEP] != undefined) {
		var _i = array_get_index(REFLEXUI.stepEvents, _component);
		array_delete(REFLEXUI.stepEvents, _i, 1);
	}
	
	if(_component == REFLEXUI.inputManager.focus)
		REFLEXUI.inputManager.focus = undefined;
		
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
		
		//Make sure all children are ReflexComponents
		
		for(var _i = 0; _i < array_length(children); _i++) {
			if(!is_instanceof(children[_i], ReflexComponent)) {
				
				var _child = children[_i];
				
				// Convert structs into components
				if(is_struct(_child)) {
					var _comp = new ReflexComponent(_child);
					_child = _comp;
				}
				
				//Convert strings into text
				if(is_string(_child)) {
					_child = new ReflexText({ text: _child }); 
				}
				
				if(is_array(_child)) {
					_child = new ReflexBlock({}, _child);
				}	
				
				
				reflexAssert(is_struct(_child), "Must have converted this to a component");
				
				children[_i] = _child;
			}
		}	
		
		setChildrenParent();
		array_foreach(children, reflexPerformRender);
	}
}