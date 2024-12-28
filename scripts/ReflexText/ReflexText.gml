function ReflexText(_props) : ReflexComponent(_props, [], "ReflexText") constructor {
	static onLayout = function(_contentSize) {
        var _text = getFinalText();
        draw_set_font(font);
        _contentSize.width = string_width(_text);
        _contentSize.height = string_height(_text);
	}
	
	static onDraw = function(_drawArea, _colors) {
        draw_set_font(font);
        draw_set_color(_colors.color);
        draw_set_alpha(alpha);
        draw_set_halign(textHAlign);
        draw_set_valign(textVAlign);
        draw_text_ext(_drawArea.left, _drawArea.top, getFinalText(), -1, _drawArea.width);
	}
	
	static isTemplated = function() {
		return string_pos("{", text) != 0;
	}
	
	static onUpdate = function() {		
		//Check if our size changed, if so, we need to refresh the layout
		//var _size = { width: 0, height: 0 };
		//
		//onLayout(_size);
		//if(_size.width != boxModel.contentWidth || _size.height != boxModel.contentHeight) 
        refresh();
	}
	
	static getFinalText = function() { 
		if(!isTemplated()) {
			return text;	
		}
		var _text = text;
		var _index = string_pos("{", _text);
		
		while(_index != 0) {
			var _endPos = string_pos_ext("}", _text, _index);
			var _temp = string_copy(_text, _index, _endPos - _index + 1);
			var _prop = string_trim(_temp, ["{", "}"]);
			var _value = self[$ _prop];
			
			//If we can't find it in our component, look to the parent
			if(_value == undefined && parent != undefined)
				_value = parent[$ _prop];
				
			_text = string_replace(_text, _temp, _value);
			_index = string_pos_ext("{", _text, 0);
		}
	
		return _text;
	}
}