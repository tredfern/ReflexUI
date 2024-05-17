function ReflexBoxModel(_component) constructor {
	component = _component;
	
	x = 0;
	y = 0;
	contentWidth = 0;
	contentHeight = 0;
	padding = reflexBoundaryRect(component[$ REFLEX_PROPERTY_PADDING]);
	margin = reflexBoundaryRect(component[$ REFLEX_PROPERTY_MARGIN]);
	border = reflexBoundaryRect(component[$ REFLEX_PROPERTY_BORDER]);
	
	static maximize = function() {
		var _wMargin = margin.totalLR - border.totalLR - padding.totalLR;
		var _hMargin = margin.totalTB - border.totalTB - padding.totalTB;
		
		if(!is_undefined(component.parent)) {
			//Take up as much room as our parent will let us
			contentWidth = component.parent.boxModel.contentWidth - _wMargin;
			contentHeight = component.parent.boxModel.contentHeight - _hMargin;
		} else {
			// We have no parent, get the whole screen!
			contentWidth = display_get_gui_width() - _wMargin;
			contentHeight = display_get_gui_height() - _hMargin;
		}
	}
	
	static getFullWidth = function() {
		return contentWidth + margin.totalLR + border.totalLR + padding.totalLR;	
	}
	
	static getFullHeight = function() {
		return contentHeight + margin.totalTB + border.totalTB + padding.totalTB;	
	}
	
	///
	/// FullRects represent the entire space in the UI the component is occupying
	/// This is all the margin, padding, border, and content
	static getFullRect = function() {
		var width = margin.totalLR + border.totalLR + padding.totalLR + contentWidth;
		var height = margin.totalTB + border.totalTB + padding.totalTB + contentHeight;
		
		if(!is_undefined(component.parent)) {
			var _pRect = component.parent.boxModel.getContentRect();
			return new ReflexLayoutRect(_pRect.left + x, _pRect.top + y, width, height);
		}
		
		return new ReflexLayoutRect(x, y, width, height);	
	}
	
	///
	/// Screen Rects are p
	static getScreenRect = function() {
		var _x = x + margin.left;
		var _y = y + margin.top;
		var _w = border.totalLR + padding.totalLR + contentWidth;
		var _h = border.totalTB + padding.totalTB + contentHeight;
		
		if(!is_undefined(component.parent)) {
			var _pRect = component.parent.boxModel.getContentRect();
			
			return new ReflexLayoutRect(
				_pRect.left + _x, _pRect.top + _y, _w, _h);
		} else {
			return new ReflexLayoutRect(_x, _y, _w, _h);	
		}
	}
	
	static getContentRect = function() {
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
	
	totalLR = left + right;
	totalTB = top + bottom;
}

function reflexBoundaryRect(_value) {
	if(is_undefined(_value))
		return new ReflexBoundaryRect(0, 0, 0, 0);
		
	if(is_numeric(_value))
		return new ReflexBoundaryRect(_value, _value, _value, _value);
	
	if(is_struct(_value))
		return reflexStructMergeValues(new ReflexBoundaryRect(0, 0, 0, 0), _value);
}