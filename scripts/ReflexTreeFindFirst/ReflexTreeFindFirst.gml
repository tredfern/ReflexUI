
function reflexTreeFindFirst(_search, _params = REFLEX_EMPTY) {
	var _out = undefined;
	//Trigger any step events
	for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
		_out = __reflexTreeFindFirstImp(REFLEX_ROOTS[_i], _search, _params);
		
		if(_out != undefined)
			return _out;
	}
}

///
///
/// Operation is a callback with these parameters (_component, _itsIndex, _parent)
///
///
function __reflexTreeFindFirstImp(_component, _search, _params) {
	if(_search(_component, _params))
		return _component;
			
	for(var _i = 0; _i < array_length(_component.children); _i++) {
		var _out = __reflexTreeFindFirstImp(_component.children[_i], _search, _params);
		
		if(_out != undefined)
			return _out;
	}
}
