function ReflexText(_props, _children) : ReflexComponent(_props, _children) constructor {
	layout = ReflexLayout.inline;
	
	static onLayout = function(_contentSize) {
		_contentSize.contentWidth = string_width(text);
		_contentSize.contentHeight = string_height(text);
	}
	
	static onDraw = function(_drawArea) {
		draw_text(_drawArea.left, _drawArea.top, text);
	}
}