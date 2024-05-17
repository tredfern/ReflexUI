
///
///
/// Operation is a callback with these parameters (_component, _itsIndex, _parent)
///
///
function ReflexTreeOperator(_component, _operation) {
	if(!_component.hasChildren())
		return;
		
		
	for(var _i = 0; _i < array_length(_component.children); _i++) {
		_operation(_component.children[_i], _i, _component);
		
		ReflexTreeOperator(_component.children[_i], _operation);
	}
}