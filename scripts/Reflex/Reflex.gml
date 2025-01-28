function Reflex() {
	var _components = [];
	for(var _c = 0; _c < argument_count; _c++) {
		array_push(_components, argument[_c]);
	}
	return reflexRender(_components);
}

function ReflexClear(_components = undefined) {
	if(is_array(_components)) {
		array_foreach(_components, reflexRemove);	
	} else if(is_struct(_components)) {
		reflexRemove(_components);		
	} else {
		reflexClearAll();
	}
	//REFLEXUI.inputManager.clear();
}