
function demoBindingProperties() {
	return new ReflexBlock({ styles: "panel" }, [
		new Description("This counter is bound to a property in an object instance. Reflex is transferring the data over"),
		new FrameCounter()
	]);
	
}

function FrameCounter() : ReflexComponent() constructor {
	frameNumber = bind(objDemo, "counter", 0);
	
	static render = function() {
		return new ReflexText({ text: "Frames: {frameNumber}" });	
	}	
}