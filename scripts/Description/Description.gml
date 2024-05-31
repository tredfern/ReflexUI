function Description(_text) : ReflexComponent() constructor {
	baseStyle("demo_description");
	text = _text;
	
	static render = function() {
		return new ReflexText({ text: text });	
	}
}
