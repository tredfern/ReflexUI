function ReflexMenuItem(_props, _children) : ReflexComponent(_props, _children, "ReflexMenuItem") constructor {
	static onLoad = function() {
		if(struct_exists(self, "text")) {
			addChild(new ReflexText({ text: text, styles: "ReflexMenuOptionText" }));	
		}
	}
}