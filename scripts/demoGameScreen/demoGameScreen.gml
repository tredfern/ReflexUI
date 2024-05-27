function demoGameScreen() {
	ReflexClear();
	objDemo.gameOn = true;
	Reflex(
		new ReflexBlock({ styles: "demoGameHUDPanel", onUnload: function() { objDemo.gameOn = false; } }, [
			new DemoLabelValue("Coins", 0, objDemo, "coins"),
			new DemoLabelValue("Level", 0, objDemo, "level"),
			new DemoXPBar(),
		])
	);
}

function DemoLabelValue(_label, _value, _bindRef, _bindProp) : ReflexComponent() constructor {
	reflexBaseStyle(self, "DemoLabelValue");
	label = _label;
	value = bind(_bindRef, _bindProp);
	
	static render = function() {
		return [
			new ReflexText({ text: label, styles: "label" }),
			new ReflexText({ text: "{value}", styles: "label_value" })	// ReflexText will pull templated values from their parent
		]
	}
}


function DemoXPBar() : ReflexComponent() constructor {
	static render = function() {
		return new ReflexProgressBar({ styles: "xpBar", minValue: 0, value: bind(objDemo, "xp", 0), maxValue: bind(objDemo, "xpNextLevel", 0) });
	}
}