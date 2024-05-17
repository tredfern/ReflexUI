function reflexRender(_component) {
	array_push(REFLEX_ROOTS, new ReflexRoot([_component]));
	reflexFlagRefresh();
}

function reflexFlagRefresh() {
	REFLEX_GLOBAL.needsRefresh = true;	
}