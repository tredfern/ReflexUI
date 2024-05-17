function reflexAssert(_expression, _error) {
	if(!_expression)
		show_error(_error, true);
}

function reflexStructMergeValues(_base, _override) {
	var _names = struct_get_names(_override);
	for(var _i = 0; _i < array_length(_names); _i++) {
		var _name = _names[_i];
		
		_base[$ _name] = _override[$ _name];
	}
	return _base;
}