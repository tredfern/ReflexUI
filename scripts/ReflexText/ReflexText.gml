function ReflexText(_props) : ReflexComponent(_props, [], "ReflexText") constructor {
	textMgr = undefined;
	layout = ReflexLayout.inline;
	templateText = undefined;
	isHTML5 = os_browser != browser_not_a_browser;	// Scribble JR does not support HTML5
	
	static onLayout = function(_contentSize) {
		if(!isTemplated()) {
			textMgr = ScribblejrFit(text, fa_left, fa_top, font, fontScale, _contentSize.maxWidth, _contentSize.maxHeight);
			_contentSize.width = textMgr.GetWidth();
			_contentSize.height = textMgr.GetHeight();
		} else {
			templateText = text;
			text = getFinalText();
			_contentSize.width = string_width(text);
			_contentSize.height = string_height(text);
		}
	}
	
	static onDraw = function(_drawArea, _colors) {
		if(isTemplated() || isHTML5) {
			ScribblejrDrawNative(_drawArea.left, _drawArea.top, getFinalText(), _colors.color, alpha,,,font);
		} else {
			textMgr.Draw(_drawArea.left, _drawArea.top, _colors.color, alpha, sdfEffects);
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
		if(!isTemplated()) {
			return text;	
		}
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
			_index = string_pos_ext("{", _text, 0);
		}
	
		return _text;
	}
}