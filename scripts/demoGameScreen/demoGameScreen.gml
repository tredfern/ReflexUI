function demoGameScreen() {
	ReflexClear();
	objDemo.gameOn = true;
	Reflex(
		new ReflexBlock({ styles: "demoGameHUDPanel", onUnload: function() { objDemo.gameOn = false; } }, [
			new DemoLabelValue("Coins", objDemo, "coins"),
			new DemoLabelValue("Level", objDemo, "level"),
			new DemoXPBar(),
		])
	);
}

function DemoLabelValue(_label, _bindRef, _bindProp) : ReflexComponent({ label: _label, value: reflexCreateBind(_bindRef, _bindProp)}, [], "DemoLabelValue") constructor {
	static render = function() {
		return [
			new ReflexText({ text: label, styles: "label" }),
			new ReflexText({ text: "{value}", styles: "label_value" })	// ReflexText will pull templated values from their parent
		]
	}
}


function DemoXPBar() : ReflexComponent(,,"DemoXPBar") constructor {
	static render = function() {
		return new ReflexProgressBar({ styles: "xpBar", minValue: 0, value: bind(objDemo, "xp", 0), maxValue: bind(objDemo, "xpNextLevel", 0) });
	}
}