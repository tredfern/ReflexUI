function ReflexComponent(_props = {}, _children = []) constructor {
	properties = _props;
	parent = undefined;
	children = _children;
	boxModel = new ReflexBoxModel(self);
	layout = ReflexLayout.block;

	static loadComponent = function() {
		var _names = struct_get_names(properties);
	
		for(var _i = 0; _i < array_length(_names); _i++) {
			var _n = _names[_i];
			var _v = properties[$ _n];
		
			self[$ _n] = _v;
		}
		
		//Connect children to parent in hierarchy
		setChildrenParent();
	}
	
	static setChildrenParent = function() {
		for(var _i = 0; _i < array_length(children); _i++) {
			children[_i].parent = self;	
		}
	}
	
	static hasChildren = function() { return array_length(children) > 0; }
	
	loadComponent();
}