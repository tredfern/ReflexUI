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

function reflexIsPercentageString(_stringValue) {
	return string_ends_with(_stringValue, "%");
}	

function reflexGetPercentage(_stringValue) {
	var _num = string_trim(_stringValue, ["%", " "]);
	_num = real(_num);
	
	reflexAssert(is_numeric(_num), $"Expected a numeric percentage string, got this instead: {_stringValue}");
	return 	_num / 100;
}

function reflexPropertyOn(_struct, _property) {
	return _struct[$ _property] != ReflexProperty.off;
}

function reflexTemplatizeText(_struct, _text) {
	var _index = string_pos("{", _text);
	while(_index != 0) {
		var _endPos = string_pos_ext("}", _text, _index);
		var _temp = string_copy(_text, _index, _endPos - _index + 1);
		var _prop = string_trim(_temp, ["{", "}"]);
		var _value = _struct[$ _prop];
		_text = string_replace(_text, _temp, _value);
		_index = string_pos_ext("{", _text, _endPos);
	}
	
	return _text;
}