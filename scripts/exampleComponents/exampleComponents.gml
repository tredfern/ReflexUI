
//
// A simple control that hooks into the ReflexText template language and displays a count of frames
//
function FrameCounter() : ReflexText({ text: "Frame: {frameCounter}" }) constructor {
	reflexBindProperty(self, "frameCounter", objDemo, "counter");
}