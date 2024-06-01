function Description(_text) : ReflexComponent({ text: _text },, "Description") constructor {
	static render = function() {
		return new ReflexText({ text: text });	
	}
}
