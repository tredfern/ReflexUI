
function reflexTreeFindFirst(_search, _params = {}, _startPoint = REFLEXUI.roots) {
	_startPoint = reflexEnsureArray(_startPoint);
	var _out = undefined;
	//Trigger any step events
	for(var _i = 0; _i < array_length(_startPoint); _i++) {
		_out = __reflexTreeFindFirstImp(_startPoint[_i], _search, _params);
		
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
