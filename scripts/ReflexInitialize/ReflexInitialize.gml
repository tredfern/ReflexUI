reflexInitialize();

function reflexInitialize() {
	// Setup global states and root container

	REFLEX_GLOBAL = {};
	REFLEX_ROOTS = [];
	REFLEX_STYLESHEET = {};
	REFLEX_EMPTY = {};
	REFLEX_GLOBAL.canCache = false;
	REFLEX_STATE = new ReflexStateManager();
	REFLEX_COLORS = {};
	REFLEX_MOUSE_DEVICE = 0;
	REFLEX_INPUT = new ReflexInput();
	REFLEX_GLOBAL.__inputCooldown = 0;
	REFLEX_GLOBAL.stepEvents = [];
	REFLEX_ANIMATIONS = new ReflexAnimationManager();
	
	//Load the configuration
	ReflexConfiguration();
	
	// Create the engine that will drive the GUI experience
	reflexCreateEngine();
}


function reflexCreateEngine() {
	REFLEX_GLOBAL.engineTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function() {
		instance_create_depth(0, 0, 1024, ReflexEngine);
	});
	
	time_source_start(REFLEX_GLOBAL.engineTimeSource);
}