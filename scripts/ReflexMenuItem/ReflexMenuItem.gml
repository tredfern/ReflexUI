function ReflexMenuItem(_props, _children) : ReflexComponent(_props, _children, "ReflexMenuItem") constructor {
	text = "";
	
	static render = function() {
		return [
			new ReflexText({ text: text, styles: "ReflexMenuOptionText" })
		]
	}
}