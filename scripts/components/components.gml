function demoHeader() {
	return new ReflexBlock({ styles: "demo_header" }, [
		new ReflexButton({ styles: "demo_back_button", text: "Back", onClick: demoShowMenu })
	]);
}

function demoLayout() {
	return new ReflexBlock({}, [
		new ReflexBlock({ margin: 10, backgroundColor: c_blue, color: c_white }, [
			new ReflexText({ text: "Some text with a \n line break", styles: "outlined padded" }),
			new ReflexText({ text: "Another text segment", styles: "outlined padded" }),
			new ReflexText({ text: "I'm aligned middle", styles: "outlined padded", valign: fa_middle }),
			new ReflexText({ text: "I'm aligned bottom", styles: "outlined padded", valign: fa_bottom }),
		
			new ReflexBlock({ margin: 10, backgroundColor: c_ltgray, color: c_black }, [
				new ReflexText({ text: "Block inside a block", styles: "outlined padded" }),
				new ReflexText({ text: "Align Center", styles: "outlined padded", halign: fa_center }),
				new ReflexText({ text: "Pulled Right", styles: "outlined padded", halign: fa_right })
			])
		]),
	]);
}

function demoBindingProperties() {
	return new ReflexBlock({ styles: "panel" }, [
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

function Description(_text) : ReflexComponent() constructor {
	text = _text;
	
	static render = function() {
		return new ReflexText({ text: text, styles: "demo_description" });	
	}
}

function LotsOfBlocks() : ReflexComponent() constructor {
	static render = function() {
		return array_create_ext(50, function(_index) {
			var _sprites = [ sprOne, sprTwo, sprThree, sprFour, sprFive, sprSix, sprSeven, sprEight, sprNine ];
			var _pick = _index % array_length(_sprites);
			
			return new ReflexImage({ sprite: _sprites[_pick], styles: "focus_enabled outlined padded" });
		});
	}
}

function demoGamepadNavigation() {
	return new ReflexBlock({ styles: "panel" }, [
		new Description("This demo creates a bunch of controls with focus enabled turned on. Reflex automatically calculates the navigation and arrow keys or gamepad should work intuitively."),
		new LotsOfBlocks(),
		new LotsOfBlocks()
	]);
	
}