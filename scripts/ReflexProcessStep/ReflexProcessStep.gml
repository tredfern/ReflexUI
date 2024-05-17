function reflexProcessStep(){
	if(REFLEX_GLOBAL.needsRefresh) {
		array_foreach(REFLEX_ROOTS, reflexPerformLayout);
		REFLEX_GLOBAL.needsRefresh = false;
	}
}