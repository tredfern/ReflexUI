function reflexPerformLayout(_root) {
	// set up our root box model
	_root.boxModel.maximize();
	
	// Root is a special component with just one child
	// This allows the top level to be set to the full screen area
	// And the child components can use that to reference and align their size around
	reflexLayoutComponent(_root.children[0]);
}

///
/// Layout the component based on it's layout properties and child content
///
function reflexLayoutComponent(_component) {
	with(_component) {
		
		var _contentSize = { contentWidth: 0, contentHeight: 0 }
		
		// Let the component perform any layout calculations for content size
		reflexSafeEvent(_component, EVENT_ON_LAYOUT, _contentSize);
		boxModel.contentWidth = _contentSize.contentWidth;
		boxModel.contentHeight = _contentSize.contentHeight;
		
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
				
				// Set Child Position
				_child.boxModel.x = _x;
				_child.boxModel.y = _y;
				
				_x += _w;
				_lineHeight = max(_lineHeight, _h);
				
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
		switch(layout) {
			case ReflexLayout.inline:
				return boxModel.contentWidth;
			case ReflexLayout.block:
				return parent.boxModel.contentWidth;
		}
	}
}

function reflexCalculateHeight(_component) {
	return boxModel.contentHeight;
}