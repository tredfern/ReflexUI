function demoShowMenu() {
	ReflexClear();
	Reflex(
		new ReflexMenu({}, [
			new ReflexMenuItem({ text: "Layout Demo", onClick: demoShowLayout }),
			new ReflexMenuItem({ text: "Binding Properties", onClick: demoShowBindingProperties }),
			new ReflexMenuItem({ text: "Gamepad Navigation", onClick: demoShowGamepadNavigation }),
			new ReflexMenuItem({ text: "Animations" }),
			new ReflexMenuItem({ text: "Game Screen" }),
			new ReflexMenuItem({ text: "An Options Screen" }),
			new ReflexMenuItem({ text: "Quit", onClick: game_end })
		])
	);
}

function demoShowLayout() {
	ReflexClear();
	Reflex(
		demoHeader(),
		demoLayout(),
	
	);
}

function demoShowBindingProperties() {
	ReflexClear();
	Reflex(
		demoHeader(),
		demoBindingProperties()
	)
}

function demoShowGamepadNavigation() {
	ReflexClear();
	Reflex(
		demoHeader(),
		demoGamepadNavigation()
	);
}