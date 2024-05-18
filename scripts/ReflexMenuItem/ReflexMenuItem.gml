function ReflexMenuItem(_props, _children) : ReflexComponent(_props, _children) constructor {
	reflexBaseStyle(self, "ReflexMenuItem")
	
	static onLoad = function() {
		if(struct_exists(self, "text")) {
			addChild(new ReflexText({ text: text }));	
		}
	}
}