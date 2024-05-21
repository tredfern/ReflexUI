function reflexProcessStep() {
	REFLEX_GLOBAL.__inputCooldown--;
	
	// Load and perform any layouts
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
	
	// Update any state
	REFLEX_STATE.step();
	
	// Process input commands
	REFLEX_INPUT.step();
	
	// Trigger any component custom step events
	ReflexOperationOnAll(reflexTreeStepEvent)
}

function reflexTreeStepEvent(_component) {
	if(_component.isLoaded) {
		reflexSafeEvent(_component, REFLEX_EVENT_ON_STEP);
	}
}

function reflexCacheLayouts(_component) {
	_component.boxModel.cache();	
}