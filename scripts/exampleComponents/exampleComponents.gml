function FrameCounter() : ReflexText({ text: "Frame: {frameCounter}" }) constructor {
	static onStep = function() {
		frameCounter = objDemo.counter;	
	}

}