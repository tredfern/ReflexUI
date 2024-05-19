function reflexPerformLayout(_root) {
	// set up our root box model
	_root.boxModel.maximize();
	
	// Root is a special component with just one child
	// This allows the top level to be set to the full screen area
	// And the child components can use that to reference and align their size around
	reflexLayoutComponent(_root);
}

///
/// Layout the component based on it's layout properties and child content
///
function reflexLayoutComponent(_component) {
	with(_component) {
		if(!isLoaded) {
			_component.loadComponent();	
		}
		
		//Need to recompute the box model
		boxModel = new ReflexBoxModel(_component);
		
		var _contentSize = { width: 0, height: 0 }
		
		// Let the component perform any layout calculations for content size
		reflexSafeEvent(_component, REFLEX_EVENT_ON_LAYOUT, _contentSize);
		boxModel.contentWidth = _contentSize.width;
		boxModel.contentHeight = _contentSize.height;
		
		//Perform children layout	
		if(hasChildren()) {			
			//Take up as much area as we can
			boxModel.maximize();
			
			var _x = 0;
			var _y = 0;
			var _lineHeight = 0;
			var _maxWidth = boxModel.contentWidth;
			var _maxHeight = boxModel.contentHeight;
			var _childContentWidth = 0;
			var _childContentHeight = 0;
			
		
			for(var _i = 0; _i < array_length(children); _i++) {
				var _child = children[_i];
				
				reflexLayoutComponent(_child);	
				
				var _w = _child.boxModel.getFullWidth();
				var _h = _child.boxModel.getFullHeight();
				
				// Set up a new line
				if(_x + _w > _maxWidth && _x > 0) {
					_x = 0;
					_y += _lineHeight;
					_lineHeight = 0;
				}
				_lineHeight = max(_lineHeight, _h);
				
				// Set Child Position
				_child.boxModel.x = reflexAlign(_child.halign, _x, _maxWidth, _w);
				_child.boxModel.y = reflexAlign(_child.valign, _y, _lineHeight, _h);
				
				_x += _w;
				
				
				_childContentWidth = max(_childContentWidth, _x);
				_childContentHeight = max(_childContentHeight, _y + _lineHeight);
				
			}
			
			boxModel.contentWidth = _childContentWidth;
			boxModel.contentHeight = _childContentHeight;
		}
		
		// Finalize our size based on content size and any properties
		boxModel.contentWidth = reflexCalculateWidth(_component);
		boxModel.contentHeight = reflexCalculateHeight(_component);
	}
}

///
/// Calculate the maximum with available to the component
///
function reflexMaxWidth(_component) {
	return _component.parent.boxModel.contentWidth;
}

function reflexCalculateWidth(_component) {
	with(_component) {
		var _maxContentWidth = display_get_gui_width();
		if(!is_undefined(parent))
			_maxContentWidth = parent.boxModel.contentWidth;
	
		_maxContentWidth = _maxContentWidth - boxModel.margin.totalLR - boxModel.border.totalLR - boxModel.padding.totalLR;
	
		//If we are not an "auto" width, we need to set our width to the settings provided
		if(width != ReflexProperty.auto) {
			var _w = _component.width;
		
			// If we are a percentage, than eat up a percentage of your parent
			if(reflexIsPercentageString(_w)) {
				_w = reflexGetPercentage(_w);
				return _maxContentWidth * _w;
			}
		
			// Otherwise, your size is your size
			return _w; //min(_w, _maxContentWidth); <-- could consider setting to the smaller value
		}
	
	
		switch(layout) {
			case ReflexLayout.inline:
				return boxModel.contentWidth;
			case ReflexLayout.block:
				return _maxContentWidth;
		}
		
	}
}

function reflexCalculateHeight(_component) {
	var _maxContentHeight = display_get_gui_height();
	if(!is_undefined(parent))
		_maxContentHeight = parent.boxModel.contentHeight;
	
	if(_component.height != ReflexProperty.auto) {
		var _h = _component.height;
			// If we are a percentage, than eat up a percentage of your parent
		if(reflexIsPercentageString(_h)) {
			_h = reflexGetPercentage(_h);
			return _maxContentHeight * _h;
		}
		
		// Otherwise, your size is your size
		return _h; //min(_h, _maxContentHeight); <-- could consider setting to the smaller value
	}
	
	return boxModel.contentHeight;
}


function reflexAlign(_alignment, _min, _max, _size) {
	if (_alignment == fa_left || _alignment == fa_top)
		return _min;
	
	if (_alignment == fa_middle || _alignment == fa_center)
		return (_max - _min - _size) / 2;
		
	if (_alignment == fa_right || _alignment == fa_bottom)
		return _max - _size;
	
	return _min;
}