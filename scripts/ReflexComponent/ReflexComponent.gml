function ReflexComponent(_props = {}, _children = [], _baseStyle = "ReflexComponent") constructor {
	baseStyles = ["__default", _baseStyle];
	properties = _props;
	parent = undefined;
	children = _children;
	boxModel = new ReflexBoxModel(self);
	layout = ReflexLayout.block;
	isLoaded = false;
	styleCache = {};
	focusUp = undefined;
	focusDown = undefined;
	focusRight = undefined;
	focusLeft = undefined;
	dead = false;
	
	// Events
	static onClick =						undefined;					// Triggered when "click" verb is pressed while mouse is over control OR when focus is set and the "accept" verb is pressed
	static onDraw =							undefined;					// Triggered after drawing the background and border
	static onFocus =						undefined;					// Triggered when component receives focus
	static onFocusOut =						undefined;					// Triggered when component loses focus
	static onLayout =						undefined;					// Triggered when laying out component. IMPORTANT: This is an opportunity to define the content size for the component. See ReflexText or ReflexImage
	static onLoad =							undefined;					// Triggered after styles and loading properties are all set for the component before layout has triggered
	static onMouseEnter =					undefined;					// Triggered when mouse enter the screen boundary for the control
	static onMouseExit = 					undefined;					// Triggered when mouse exits the screen boundary for the control
	static onMouseOver =					undefined;					// Triggered while mouse is over the component
	static onStep =							undefined;					// Triggered each frame during the Step event
	static onUnload =						undefined;					// Triggered when the component is removed from the engine
	static onUpdate =						undefined;					// Triggered when values are changed via the "update" method on the component
	
	drawingColors = {
		color: c_white,
		backgroundColor: c_white,
		borderColor: c_white
	}

	static loadComponent = function() {
		// Apply default styles
		reflexApplyDefaultStyles(self);

		// Apply any styles first, properties should override the styles;
		if(struct_exists(properties, REFLEX_PROPERTY_STYLES)) {
			reflexApplyStyles(self, properties.styles);	
		}
		
		reflexStructMergeValues(self, properties);
		calculateInheritedPropertyValues();
		
		
		// Register hot verb
		if(self[$ REFLEX_PROPERTY_HOT_VERB] != undefined) {
			reflexRegisterHotVerb(self, self[$ REFLEX_PROPERTY_HOT_VERB]);		
		}
		
		if(self[$ REFLEX_EVENT_ON_STEP] != undefined) {
			reflexRegisterStepEvent(self);
		}
		checkAnimations();
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
	
	static ensureProperty = function(_propName, _default) {
		if(!struct_exists(self, _propName))
			self[$ _propName] = _default;
	}
	
	static bind = function(_propName, _fromObject, _fromProperty) {
		reflexBindProperty(self, _propName, _fromObject, _fromProperty);	
	}
	
	static checkAnimations = function() {
		if(self[$ "animation"] != undefined) {
			reflexRegisterAnimation(self, animation, animationDuration);
			
			// Remove animation properties as we have triggered the animation
			animation = undefined;
			animationDuration = undefined;
		}
	}

	static update = function(_changes) {
		reflexStructMergeValues(self, _changes);
		reflexSafeEvent(self, REFLEX_EVENT_ON_UPDATE, _changes);
	}
	
	static getX = function() {
		var _x = x;
		
		var _p = parent;
		while(_p != undefined) {
			_x += _p.x;
			_p = _p.parent;
		}
		
		return _x;
	}
	
	static getY = function() {
		var _y = y;
		
		var _p = parent;
		while(_p != undefined) {
			_y += _p.y;
			_p = _p.parent;
		}
		
		return _y;
	}
}