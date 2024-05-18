function reflexRender(_components) {
	if(is_struct(_components)) {
		_components = [_components];	
	}
	var _root = new ReflexRoot(_components);
	// Convert any strings to ReflexText components
	ReflexTreeOperator(_root, reflexReplaceStringWithText);
	
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