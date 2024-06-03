function LotsOfBlocks(_count = 50) : ReflexComponent() constructor {
	count = _count;
	
	static render = function() {
		return array_create_ext(count, function(_index) {
			var _sprites = [ sprOne, sprTwo, sprThree, sprFour, sprFive, sprSix, sprSeven, sprEight, sprNine ];
			var _pick = _index % array_length(_sprites);
			
			return new ReflexImage({ sprite: _sprites[_pick], styles: ["focus_enabled", "die_block"] });
		});
	}
}

function demoGamepadNavigation() {
	return new ReflexBlock({ styles: "panel" }, [
		new Description("This demo creates a bunch of controls with focus enabled turned on. Reflex automatically calculates the navigation and arrow keys or gamepad should work intuitively."),
		new LotsOfBlocks(),
		new ReflexBlock({ width: "50%" }, [
			new Description("A group of stuff over here"),
			new LotsOfBlocks(15)
		]),
		new ReflexBlock({ width: "50%" }, [
			new Description("A group of stuff over here"),
			new LotsOfBlocks(15)
		]),
		new Description("Stuff down here"),
		new LotsOfBlocks(),
		
		
	]);
}