
function ReflexOperationOnAll(_operation) {
	//Trigger any step events
	for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
		ReflexTreeOperator(REFLEX_ROOTS[_i], _operation);
	}
}

///
///
/// Operation is a callback with these parameters (_component, _itsIndex, _parent)
///
///
function ReflexTreeOperator(_component, _operation) {
	for(var _i = 0; _i < array_length(_component.children); _i++) {
		// Run the operation, check response code
		_operation(_component.children[_i], _i, _component);
		
		//Cascade to children
		if(_component.children[_i].hasChildren())
			ReflexTreeOperator(_component.children[_i], _operation);
	}
}
