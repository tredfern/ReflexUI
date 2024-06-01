reflexInitialize();

function reflexInitialize() {
	// Setup global states and root container
	REFLEXUI = {};
	REFLEXUI.roots = [];
	REFLEXUI.stylesheet = {};
	REFLEX_EMPTY = {};
	REFLEXUI.canCache = false;
	REFLEXUI.needsRefresh = false;
	REFLEXUI.stateManager = new ReflexStateManager();
	REFLEXUI.colors = {};
	REFLEXUI.mouseDevice = 0;
	REFLEXUI.inputManager = new ReflexInput();
	REFLEXUI.__inputCooldown = 0;
	REFLEXUI.stepEvents = [];
	REFLEXUI.animations = new ReflexAnimationManager();
	REFLEXUI.drawBoxModel = false;
	REFLEXUI.components = {
		__definitions: {}
	};
	
	//Load the configuration
	ReflexUIDefaultConfiguration();
	
	// Create the engine that will drive the GUI experience
	REFLEXUI.engineTimeSource = time_source_create(time_source_global, 1, time_source_units_frames, function() {
		instance_create_depth(0, 0, 1024, ReflexUI);
	});
	
	time_source_start(REFLEXUI.engineTimeSource);
	
	REFLEXUI.isLoaded = true;
	
	if(struct_exists(global, "__reflexUserConfiguration")) {
		REFLEXUI_USER_CONFIGURATION();	
	}
	show_debug_message("ReflexUI is loaded and ready for use");
}

function ReflexUIIsLoaded() {
	try {
		return REFLEXUI.isLoaded;	
	}
}