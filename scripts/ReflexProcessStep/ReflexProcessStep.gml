function reflexProcessStep() {
	REFLEXUI.__inputCooldown--;
	
	// Load and perform any layouts
	if(REFLEXUI.needsRefresh) {
		// Perform layout of all components
		array_foreach(REFLEXUI.roots, reflexPerformLayout);
		REFLEXUI.needsRefresh = false;
		REFLEXUI.canCache = true;
	} else if(REFLEXUI.canCache) {
		//If we haven't needed to update, cache the layouts
		for(var _i = 0; _i < array_length(REFLEXUI.roots); _i++) {
			ReflexTreeOperator(REFLEXUI.roots[_i], reflexCacheLayouts);
		}
		REFLEXUI.canCache = false;
	}
	REFLEXUI.roots = array_filter(REFLEXUI.roots, function(_root) { return _root.hasChildren(); });
	
	// Update any state
	REFLEXUI.stateManager.step();
	
	// Process input commands
	REFLEXUI.inputManager.step();
	
	for(var _i = 0; _i < array_length(REFLEXUI.stepEvents); _i++) {
		var _c = REFLEXUI.stepEvents[_i];	
		reflexSafeEvent(_c, REFLEX_EVENT_ON_STEP);
	}
	
	REFLEXUI.animations.step();
}

function reflexCacheLayouts(_component) {
	_component.boxModel.cache();	
}

function reflexRegisterStepEvent() {
	
}