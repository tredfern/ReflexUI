
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
function reflexLayoutComponent(_component, _availableWidth = undefined, _availableHeight = undefined) {
	with(_component) {
        //Component has been destroyed and will be cleaned up. Ignore
        if(dead)
            return;

		reflexAssert(isLoaded, "Component must be loaded to perform layout");
		
		if(forceRefresh) {
			reflexPerformRender(_component, _component.parent);
			forceRefresh = false;
		}
		
		//Need to recompute the box model
		boxModel = new ReflexBoxModel(_component, _availableWidth, _availableHeight);
        
		var _contentSize = { width: 0, height: 0, maxWidth: boxModel.getMaxWidth(), maxHeight: boxModel.getMaxHeight()  }
		
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
			var _focusGrid = [[]];
			var _row = 0;
			var _vAlignLineHeight = height == ReflexProperty.auto;
			
		
			for(var _i = 0; _i < array_length(children); _i++) {
				var _child = children[_i];
				
				if(_child.isVisible) {
                    //Check if we are at the end of the line
                    if(_x >= _maxWidth && _x > 0) {
                        _x = 0;
                        _y += _lineHeight;
                        _lineHeight = 0;
                        _row++;
                        array_push(_focusGrid, []);
                    }
                    
					reflexLayoutComponent(_child, _maxWidth, _maxHeight - _y);	
				
					var _w = _child.boxModel.getFullWidth();
					var _h = _child.boxModel.getFullHeight();
				
					// Handle constrain overflow 
					if(_child.overflow == ReflexOverflow.Constrain) {
						if(_w > _maxWidth) {
							_child.boxModel.contentWidth = _maxWidth;
							_w = _maxWidth;
						}
				
						if(_h > _maxHeight) {
							_child.boxModel.contentHeight = _maxHeight;
							_h = _child.boxModel.contentHeight;
						}
					}
				
					if(_child.position == ReflexPosition.absolute) {
						// We are being told to put the control at this location, so put it there!
						_child.boxModel.x = _child.x;
						_child.boxModel.y = _child.y;
					
						_childContentWidth = max(_childContentWidth, _child.boxModel.x + _child.boxModel.contentWidth);
						_childContentHeight = max(_childContentHeight, _child.boxModel.y + _child.boxModel.contentHeight);
					} else {
						// This is the normal layout
						// Set up a new line
						if(_x + _w > _maxWidth && _x > 0) {
							_x = 0;
							_y += _lineHeight;
							_lineHeight = 0;
							_row++;
							array_push(_focusGrid, []);
						}
					
						// Stretching the height is a thing that should happen if configured
						if(_child.height == ReflexProperty.expand) {
                            _child.boxModel.expandHeight(_maxHeight - _y);
							_h = _child.boxModel.contentHeight;
						}
					
						_lineHeight = max(_lineHeight, _h);
				
						// Set Child Position
						_child.boxModel.x = reflexAlign(_child.halign, _x, _maxWidth, _w);
						_child.boxModel.y = reflexAlign(_child.valign, _y, _vAlignLineHeight ? _lineHeight : _maxHeight , _h);
				
				
						_x += _w;
				
						_childContentWidth = max(_childContentWidth, _x);
						_childContentHeight = max(_childContentHeight, _y + _lineHeight);
				
						//Assign component focus
						if(_child.focusOrder == ReflexProperty.auto) {
							var _col = array_length(_focusGrid[_row]);
							array_push(_focusGrid[_row], _child);
					
							if(_row > 0) {
								var _upControl = _focusGrid[_row - 1][min(_col, array_length(_focusGrid[_row - 1]) - 1)];
					
								_child.focusUp = _upControl;
								_upControl.focusDown = _child;
							}
					
							if(_col > 0) {
								var _leftControl = _focusGrid[_row][_col - 1];
								_child.focusLeft = _leftControl;
								_leftControl.focusRight = _child;
						
							}
						}
					}
				}
			}
			
			boxModel.contentWidth = _childContentWidth;
			boxModel.contentHeight = _childContentHeight;
		}
		
		// Finalize our size based on content size and any properties
		boxModel.contentWidth = reflexCalculateWidth(_component);
		boxModel.contentHeight = reflexCalculateHeight(_component);
		
		isLayoutCompleted = true;
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
		var _maxContentWidth = boxModel.availableWidth;
	
		//If we are not an "auto" width, we need to set our width to the settings provided
		if(width != ReflexProperty.auto && width >= 0) {
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
	with(_component) {
        var _maxContentHeight = boxModel.availableHeight;
        
        if(height != ReflexProperty.auto && height >= 0) {
            var _h = height;
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
}


function reflexAlign(_alignment, _min, _max, _size) {
	if (_alignment == fa_left || _alignment == fa_top)
		return _min;
	
	if (_alignment == fa_middle || _alignment == fa_center)
		return (_max - _min) / 2  - _size / 2;
		
	if (_alignment == fa_right || _alignment == fa_bottom)
		return _max - _size;
	
	return _min;
}