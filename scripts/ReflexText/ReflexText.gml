function ReflexText(_props, _children) : ReflexComponent(_props, _children) constructor {
	reflexBaseStyle(self, "ReflexText");
	textMgr = undefined;
	layout = ReflexLayout.inline;
	
	static onLayout = function(_contentSize) {
		if(textMgr != undefined) {
			_contentSize.width = textMgr.GetWidth();
			_contentSize.height = textMgr.GetHeight();
		} else {
			_contentSize.width = string_width(text);
			_contentSize.height = string_height(text);
		}
	}
	
	static onDraw = function(_drawArea) {
		
		draw_set_color(color);
		if(isTemplated()) {
			ScribblejrDrawNative(_drawArea.left, _drawArea.top, reflexTemplatizeText(self, text));
		} else {
			textMgr.Draw(_drawArea.left, _drawArea.top);
		}
	}
	
	static onLoad = function() {
		if(!isTemplated()) {
			textMgr = Scribblejr(text, fa_left, fa_top, font);
		}
	}
	
	static isTemplated = function() {
		return string_pos("{", text) != 0;
	}
}