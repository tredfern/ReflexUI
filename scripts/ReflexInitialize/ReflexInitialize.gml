reflexInitialize();

function reflexInitialize() {
	// Setup global states and root container

	REFLEX_GLOBAL = {};
	REFLEX_ROOTS = [];

	
	reflexCreateEngine()
	reflexFlagRefresh();
}


function reflexCreateEngine() {
	REFLEX_GLOBAL.engineTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function() {
		instance_create_depth(0, 0, 1024, ReflexEngine);
	});
	
	time_source_start(REFLEX_GLOBAL.engineTimeSource);
}