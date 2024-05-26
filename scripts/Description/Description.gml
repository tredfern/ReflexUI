function Description(_text) : ReflexComponent() constructor {
	text = _text;
	
	static render = function() {
		return new ReflexText({ text: text, styles: "demo_description" });	
	}
}