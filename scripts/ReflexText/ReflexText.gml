function ReflexText(_text, _props) : ReflexComponent(_props, [], "ReflexText") constructor {
	text = _text;
	textMgr = undefined;
	layout = ReflexLayout.inline;
	templateText = undefined;
	
	static onLayout = function(_contentSize) {
		if(textMgr != undefined) {
			_contentSize.width = textMgr.GetWidth();
			_contentSize.height = textMgr.GetHeight();
		} else {
			var _t = reflexTemplatizeText(self, templateText);
			_contentSize.width = string_width(_t);
			_contentSize.height = string_height(_t);
		}
	}
	
	static onDraw = function(_params) {
		var _drawArea = _params.location;
		var _colors = _params.colors;
		
		if(isTemplated()) {
			ScribblejrDrawNative(_drawArea.left, _drawArea.top, reflexTemplatizeText(self, templateText), _colors.color);
		} else {
			textMgr.Draw(_drawArea.left, _drawArea.top, _colors.color);
		}
	}
	
	static onLoad = function() {
		if(!isTemplated()) {
			textMgr = Scribblejr(text, fa_left, fa_top, font);
		} else {
			templateText = text;
			text = reflexTemplatizeText(self, templateText);
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
}