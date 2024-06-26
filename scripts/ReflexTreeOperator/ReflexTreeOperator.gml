
function ReflexOperationOnAll(_operation) {
	//Trigger any step events
	for(var _i = 0; _i < array_length(REFLEXUI.roots); _i++) {
		ReflexTreeOperator(REFLEXUI.roots[_i], _operation);
	}
}

///
///
/// Operation is a callback with these parameters (_component, _itsIndex, _parent)
///
///
function ReflexTreeOperator(_component, _operation, _parent) {
	_operation(_component, _parent);
	
	for(var _i = 0; _i < array_length(_component.children); _i++) {
		ReflexTreeOperator(_component.children[_i], _operation, _component);
	}
}
