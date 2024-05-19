function reflexStyleSheet(_styles = {}) {
	var _globalStyles = REFLEX_STYLESHEET;
	var _styleNames = struct_get_names(_styles);
	
	for(var _i = 0; _i < array_length(_styleNames); _i++) {
		var _sty = _styleNames[_i];
		
		// Merge the two structs together
		if(struct_exists(_globalStyles, _sty)) {
			reflexStructMergeValues(_globalStyles[$ _sty], _styles[$ _sty]);
		} else {
			_globalStyles[$ _sty] = _styles[$ _sty];	
		}
	}
}

function reflexApplyStyles(_component, _styleList) {
	var _styles = string_split(_styleList, " ", true);
	
	for(var _i = 0; _i < array_length(_styles); _i++) {
		reflexApplyStyle(_component, _styles[_i]);	
	}
}

function reflexApplyStyle(_component, _style) {
	var _s = REFLEX_STYLESHEET[$ _style];
	
	if(!is_undefined(_s)) {
		reflexStructMergeValues(_component, _s);	
	} else {
		show_debug_message($"Could not apply style: {_style}");	
	}
}

function reflexBaseStyle(_component, _styleTag) {
	array_push(_component.baseStyles, _styleTag);
}

function reflexApplyDefaultStyles(_component) {
	for(var _i = 0; _i < array_length(_component.baseStyles); _i++) {
		// go through available styles and see if we find one that 
		reflexApplyStyles(self, _component.baseStyles[_i]);	
	}
}

function reflexColors(_palette) {
	reflexStructMergeValues(REFLEX_COLORS, _palette);
}
