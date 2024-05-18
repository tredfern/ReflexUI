function reflexProcessStep() {
	// Update any state
	REFLEX_STATE.step();
	
	
	//Trigger any step events
	for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
		ReflexTreeOperator(REFLEX_ROOTS[_i], reflexTreeStepEvent);
	}
	
	if(REFLEX_GLOBAL.needsRefresh) {
		array_foreach(REFLEX_ROOTS, reflexPerformLayout);
		REFLEX_GLOBAL.needsRefresh = false;
		REFLEX_GLOBAL.canCache = true;
	} else if(REFLEX_GLOBAL.canCache) {
		//If we haven't needed to update, cache the layouts
		for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
			ReflexTreeOperator(REFLEX_ROOTS[_i], reflexCacheLayouts);
		}
		REFLEX_GLOBAL.canCache = false;
	}
}

function reflexTreeStepEvent(_component) {
	if(_component.isLoaded) {
		reflexSafeEvent(_component, REFLEX_EVENT_ON_STEP);
	}
}

function reflexCacheLayouts(_component) {
	_component.boxModel.cache();	
}