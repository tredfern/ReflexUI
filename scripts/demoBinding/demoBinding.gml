
function demoBindingProperties() {
	return new ReflexBlock({ styles: "panel" }, [
		new Description("This counter is bound to a property in an object instance. Reflex is transferring the data over"),
		new FrameCounter()
	]);
	
}

function FrameCounter() : ReflexComponent() constructor {
	frameNumber = 0;
	bind("frameNumber", objDemo, "counter");
	
	static render = function() {
		return new ReflexText({ text: "Frames: {frameNumber}" });	
	}	
}