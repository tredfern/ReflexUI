function reflexProcessStep() {
	//Trigger any step events
	for(var _i = 0; _i < array_length(REFLEX_ROOTS); _i++) {
		ReflexTreeOperator(REFLEX_ROOTS[_i], function(_c) {
			reflexSafeEvent(_c, REFLEX_EVENT_ON_STEP)	
		});
	}
	
	if(REFLEX_GLOBAL.needsRefresh) {
		array_foreach(REFLEX_ROOTS, reflexPerformLayout);
		REFLEX_GLOBAL.needsRefresh = false;
	}
}