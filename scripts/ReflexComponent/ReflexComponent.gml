function ReflexComponent(_props = {}, _children = [], _type = "__reflexcomponent__") constructor {
	type = _type;
	baseStyles = ["__default", _type, "__parentCascade"];
	properties = _props;
	parent = undefined;
	children = _children;
	boxModel = new ReflexBoxModel(self);
	layout = ReflexLayout.block;
	isLoaded = false;
	isLayoutCompleted = false;
	styleCache = {};
	focusUp = undefined;
	focusDown = undefined;
	focusRight = undefined;
	focusLeft = undefined;
	dead = false;
	forceRefresh = false;
	rerender = false;
	fullStyleList = [];
	hasHover = false;
	hasFocus = false;
	backgroundImageHandler = undefined;
	borderImageHandler = undefined;
	
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
		// Only load once
		if(isLoaded) return;	
		
		fullStyleList = array_concat(baseStyles, reflexEnsureArray(properties[$ REFLEX_PROPERTY_STYLES]));
		// Apply default styles
		reflexApplyStyles(self, fullStyleList);
		
		reflexStructMergeValues(self, properties);
		finalizePropertyValues();
		
		// Register hot verb
		if(self[$ REFLEX_PROPERTY_HOT_VERB] != undefined) {
			reflexRegisterHotVerb(self, self[$ REFLEX_PROPERTY_HOT_VERB]);		
		}
		
		if(self[$ REFLEX_EVENT_ON_STEP] != undefined) {
			reflexRegisterStepEvent(self);
		}
		
		checkAnimations();
		
		if(backgroundImage != undefined && sprite_exists(backgroundImage))
			backgroundImageHandler = new ReflexImageHandler(backgroundImage);
			
		if(borderImage != undefined && sprite_exists(borderImage))
			borderImageHandler = new ReflexImageHandler(borderImage);
		
		reflexSafeEvent(self, REFLEX_EVENT_ON_LOAD);
		isLoaded = true;
	}
	
	static setChildrenParent = function() {
		for(var _i = 0; _i < array_length(children); _i++) {
			children[_i].parent = self;	
			if(children[_i][$ "id"] != undefined) {
				self[$ $"id:{children[_i].id}"] = children[_i];	
			}
		}
	}
	
	static hasChildren = function() { return array_length(children) > 0; }
	
	static setParent = function(_parent) {
		self.parent = _parent;
		
	}
	
	static finalizePropertyValues = function() {
		//Inherit any property values	
		var _properties = struct_get_names(self);
		for(var _i = 0; _i < array_length(_properties); _i++) {
			var _property = _properties[_i];
			
			var _v = self[$ _property];
			if(_v == ReflexProperty.inherit) {
				self[$ _property] = parent[$ _property];
			} else if(is_struct(_v) && is_instanceof(_v, ReflexPropertyBinder)) {
				var _currentValue = reflexBindProperty(self, _property, _v.from, _v.fromProp);	
				self[$ _property] = _currentValue ?? _v.defaultValue;
			}
		}
	}
	
	static addChild = function(_component) {
		_component.parent = self;
		array_push(children, _component);
	}
	
	static removeChild = function(_component) {
		reflexArrayRemove(children, _component);	
	}
	
	static ensureProperty = function(_propName, _default) {
		if(!struct_exists(self, _propName))
			self[$ _propName] = _default;
	}
	
	
	static checkAnimations = function() {
		if(self[$ "animation"] != undefined) {
			reflexRegisterAnimation(self, animation, animationDuration);
			
			// Remove animation properties as we have triggered the animation
			animation = undefined;
			animationDuration = undefined;
		}
	}
	
	
	static bind = function(_from, _fromProp, _default = undefined) {
		return new ReflexPropertyBinder(_from, _fromProp, _default);
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
	
	static getById = function(_id) {
		for(var _i = 0; _i < array_length(children); _i++) {
			if(children[_i][$ "id"] == _id)
				return children[_i];
			
			var _searchChild = children[_i].getById(_id);
			if(_searchChild != undefined)
				return _searchChild;
		}
		
		return undefined;
	}

	static refresh = function(_rerender = false) {
		forceRefresh = true;	
		rerender = _rerender;
	}
	
	static show = function() {
		update({ isVisible: true });
		refresh();
	}
	
	static hide = function() {
		update({ isVisible: false });
		refresh();
	}
	
	static setFocus = function() {
		REFLEXUI.inputManager.setFocus(self);	
	}
	
	static setAnimation = function(_animation, _animationDuration) {
		reflexRegisterAnimation(self, _animation, _animationDuration)
	}
}