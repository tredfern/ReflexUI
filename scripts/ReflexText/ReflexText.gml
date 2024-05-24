function ReflexText(_props) : ReflexComponent(_props, [], "ReflexText") constructor {
	textMgr = undefined;
	layout = ReflexLayout.inline;
	templateText = undefined;
	
	static onLayout = function(_contentSize) {
		if(textMgr != undefined) {
			_contentSize.width = textMgr.GetWidth();
			_contentSize.height = textMgr.GetHeight();
		} else {
			var _t = getFinalText();
			_contentSize.width = string_width(_t);
			_contentSize.height = string_height(_t);
		}
	}
	
	static onDraw = function(_drawArea, _colors) {
		if(isTemplated()) {
			ScribblejrDrawNative(_drawArea.left, _drawArea.top, getFinalText(), _colors.color);
		} else {
			textMgr.Draw(_drawArea.left, _drawArea.top, _colors.color);
		}
	}
	
	static onLoad = function() {
		if(!isTemplated()) {
			textMgr = Scribblejr(text, fa_left, fa_top, font);
		} else {
			templateText = text;
			text = getFinalText();
		}
	}
	
	static isTemplated = function() {
		return templateText != undefined || string_pos("{", text) != 0;
	}
	
	//TODO: This should be cleaned up 
	static onUpdate = function() {		
		//Check if our size changed, if so, we need to refresh the layout
		var _size = { width: 0, height: 0 };
		
		onLayout(_size);
		if(_size.width != boxModel.contentWidth || _size.height != boxModel.contentHeight)
			reflexFlagRefresh();
	}
	
	static getFinalText = function() { 
		var _text = templateText;
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
			_index = string_pos_ext("{", _text, _endPos);
		}
	
		return _text;
	}
}