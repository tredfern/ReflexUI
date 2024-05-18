function ReflexComponent(_props = {}, _children = [], _baseStyle = "ReflexComponent") constructor {
	baseStyles = ["__default", _baseStyle];
	properties = _props;
	parent = undefined;
	children = _children;
	boxModel = new ReflexBoxModel(self);
	layout = ReflexLayout.block;
	isLoaded = false;

	static loadComponent = function() {
		// Apply default styles
		reflexApplyDefaultStyles(self);

		// Apply any styles first, properties should override the styles;
		if(struct_exists(properties, REFLEX_PROPERTY_STYLES)) {
			reflexApplyStyles(self, properties.styles);	
		}
		
		reflexStructMergeValues(self, properties);
		calculateInheritedPropertyValues();
	
		//Connect children to parent in hierarchy
		setChildrenParent();
		
		reflexSafeEvent(self, REFLEX_EVENT_ON_LOAD);
		
		isLoaded = true;
	}
	
	static setChildrenParent = function() {
		for(var _i = 0; _i < array_length(children); _i++) {
			children[_i].parent = self;	
		}
	}
	
	static hasChildren = function() { return array_length(children) > 0; }
	
	static setParent = function(_parent) {
		self.parent = _parent;
		
	}
	
	static calculateInheritedPropertyValues = function() {
		//Inherit any property values	
		var _properties = struct_get_names(self);
		for(var _i = 0; _i < array_length(_properties); _i++) {
			var _property = _properties[_i];
			
			if(self[$ _property] == ReflexProperty.inherit) {
				self[$ _property] = parent[$ _property];
			}
		}
	}
	
	static addChild = function(_component) {
		_component.parent = self;
		array_push(children, _component);
	}
}