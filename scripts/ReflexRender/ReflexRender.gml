function reflexRender(_component) {
	// Convert any strings to ReflexText components
	ReflexTreeOperator(_component, reflexReplaceStringWithText);
	
	array_push(REFLEX_ROOTS, new ReflexRoot([_component]));
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