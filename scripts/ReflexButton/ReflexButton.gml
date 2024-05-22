function ReflexButton(_props = {}, _children = []) : ReflexComponent(_props, _children, "ReflexButton") constructor {
	text = "";
	
	static render = function() {
		return new ReflexText(text, { styles: "ReflexButtonText" });
	}
}