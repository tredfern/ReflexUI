function ReflexText(_props, _children) : ReflexComponent(_props, _children) constructor {
	reflexBaseStyle(self, "ReflexText");
	layout = ReflexLayout.inline;
	
	static onLayout = function(_contentSize) {
		_contentSize.contentWidth = string_width(text);
		_contentSize.contentHeight = string_height(text);
	}
	
	static onDraw = function(_drawArea) {
		
		draw_set_color(color);
		if(isTemplated()) {
			draw_text(_drawArea.left, _drawArea.top, reflexTemplatizeText(self, text));
		} else {
			draw_text(_drawArea.left, _drawArea.top, text);
		}
	}
	
	static isTemplated = function() {
		return string_pos("{", text) != 0;
	}
}