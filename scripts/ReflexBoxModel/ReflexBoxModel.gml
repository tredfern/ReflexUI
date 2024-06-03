function ReflexBoxModel(_component) constructor {
	component = _component;
	x = 0;
	y = 0;
	contentWidth = 0;
	contentHeight = 0;
	padding = getBoundaryRect(component[$ REFLEX_PROPERTY_PADDING]);
	margin = getBoundaryRect(component[$ REFLEX_PROPERTY_MARGIN]);
	border = getBoundaryRect(component[$ REFLEX_PROPERTY_BORDER]);
	cached = undefined;
	
	static maximize = function() {
		var _wMargin = margin.totalLR() + border.totalLR() + padding.totalLR();
		var _hMargin = margin.totalTB() + border.totalTB() + padding.totalTB();
		
		if(!is_undefined(component.parent)) {
			var _w = component.parent.boxModel.contentWidth;
			var _h = component.parent.boxModel.contentHeight;
		
			contentWidth = calcMaxSize(component.width, _w - _wMargin);
			contentHeight = calcMaxSize(component.height, _h - _hMargin);
		} else {
			// We have no parent, get the whole screen!
			contentWidth = display_get_gui_width() - _wMargin;
			contentHeight = display_get_gui_height() - _hMargin;
		}
	}
	
	static getFullWidth = function() {
		return contentWidth + margin.totalLR() + border.totalLR() + padding.totalLR();
	}
	
	static getFullHeight = function() {
		return contentHeight + margin.totalTB() + border.totalTB() + padding.totalTB();
	}
	
	///
	/// FullRects represent the entire space in the UI the component is occupying
	/// This is all the margin, padding, border, and content
	static getFullRect = function() {
		if(!is_undefined(cached))
			return cached.full;
			
		var _width = margin.totalLR() + border.totalLR() + padding.totalLR() + contentWidth;
		var _height = margin.totalTB() + border.totalTB() + padding.totalTB() + contentHeight;
		
		if(!is_undefined(component.parent)) {
			var _pRect = component.parent.boxModel.getContentRect();
			return new ReflexLayoutRect(_pRect.left + x, _pRect.top + y, _width, _height);
		}
		
		return new ReflexLayoutRect(x, y, _width, _height);
	}
	
	///
	/// This is the position as defined by the layout
	//
	static getLayoutRect = function() {
		if(!is_undefined(cached))
			return cached.layout;
			
		var _x = x + margin.left;
		var _y = y + margin.top;
		var _w = border.totalLR() + padding.totalLR() + contentWidth;
		var _h = border.totalTB() + padding.totalTB() + contentHeight;
		
		if(!is_undefined(component.parent)) {
			var _pRect = component.parent.boxModel.getContentRect();
			
			return new ReflexLayoutRect(
				_pRect.left + _x, _pRect.top + _y, _w, _h);
		} else {
			return new ReflexLayoutRect(_x, _y, _w, _h);
		}
	}
	
	static getContentRect = function() {
		if(!is_undefined(cached))
			return cached.content;
			
		var _x = x + margin.left + border.left + padding.left;
		var _y = y + margin.top + border.top + padding.top;
		var _w = contentWidth;
		var _h = contentHeight;
		
		if(!is_undefined(component.parent)) {
			var _pRect = component.parent.boxModel.getContentRect();
			
			return new ReflexLayoutRect(
				_pRect.left + _x, _pRect.top + _y, _w, _h);
		} else {
			return new ReflexLayoutRect(_x, _y, _w, _h);
		}	
	}
	
	static getScreenRect = function() {
		if(!is_undefined(cached))
			return cached.screen;
		
		return getLayoutRect();
	}
	
	static setScreenRect = function(_screen) {
		if(!is_undefined(cached))
			cached.screen = _screen;
	}
	
	static cache = function() {
		cached = {
			full: getFullRect(),
			layout: getLayoutRect(),
			content: getContentRect(),
			screen: getLayoutRect()
		}
	}
	
	static inScreenRect = function(_x, _y) {
		var _sr = getScreenRect();
		return _sr.left < _x && _x < _sr.right && _sr.top < _y && _y < _sr.bottom;
	}
	
	static calcMaxSize = function(_value, _parentSize) {
		if(_value == ReflexProperty.auto) {
			return _parentSize;	
		}
	
		if(reflexIsPercentageString(_value))
			return reflexGetPercentage(_value) * _parentSize;
		
		return _value;
	}
	
	static getBoundaryRect  = function(_value) {
		var _default = new ReflexBoundaryRect(0, 0, 0, 0);
	
		if(is_undefined(_value))
			return _default;
		
		if(is_numeric(_value))
			return new ReflexBoundaryRect(_value, _value, _value, _value);
	
		if(is_struct(_value)) {
			reflexStructMergeValues(_default, _value);
			
			return _default; 	
		}
	}
}

///
/// LayoutRects are for defining the boundaries of control rectangles
///
function ReflexLayoutRect(_left, _top, _width, _height) constructor {
	left = _left;
	top = _top;
	width = _width;
	height = _height;
	right = _left + _width;
	bottom = _top + _height;
	midX = _left + _width / 2;
	midY = _top + _height / 2;
	
	static copy = function() {
		return new ReflexLayoutRect(left, top, width, height);
	}
	
	static move = function(_x, _y) {
		left += _x;
		right += _x;
		top += _y;
		bottom += _y;
		midX += _x;
		midY += _y;
	}
}

///
/// BoundaryRects are for assisting with properties like margin, padding, border
/// These are measuring the depth of each side of the rectangel
///
function ReflexBoundaryRect(_left, _top, _right, _bottom) constructor {
	left = _left;
	top = _top;
	right = _right;
	bottom = _bottom;
	
	static totalLR = function() { return left + right; }
	static totalTB = function() { return top + bottom; }
}


