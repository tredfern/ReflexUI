
function reflexTreeFindAll(_search, _params = {}, _startPoint = REFLEX_ROOTS, _shortCircuit = false) {
	_startPoint = reflexEnsureArray(_startPoint);
	_params.searchResults = [];

	//Trigger any step events
	for(var _i = 0; _i < array_length(_startPoint); _i++) {
		__reflexTreeFindAllImp(_startPoint[_i], _search, _params, _shortCircuit);
	}
	
	return _params.searchResults;
}

///
///
///
///
function __reflexTreeFindAllImp(_component, _search, _params, _shortCircuit) {
	if(_search(_component, _params)) {
		array_push(_params.searchResults, _component);
	} else if(_shortCircuit) {
		return;	
	}
		
	for(var _i = 0; _i < array_length(_component.children); _i++) {
		__reflexTreeFindAllImp(_component.children[_i], _search, _params, _shortCircuit);
	}
}
