function demoShowMenu() {
	var _animInc = 5;
	ReflexClear();
	Reflex(
		new ReflexMenu({}, [
			new ReflexMenuItem({ text: "Layout Demo", onClick: demoShowLayout, styles: "animate_in", animationDelay: 0 }),
			new ReflexMenuItem({ text: "Binding Properties", onClick: demoShowBindingProperties, styles: "animate_in", animationDelay: _animInc * 1  }),
			new ReflexMenuItem({ text: "Gamepad Navigation", onClick: demoShowGamepadNavigation, styles: "animate_in", animationDelay: _animInc * 2  }),
			new ReflexMenuItem({ text: "Animations", styles: "animate_in", animationDelay: _animInc * 3, onClick: demoShowAnimations  }),
			new ReflexMenuItem({ text: "Game Screen", styles: "animate_in", animationDelay: _animInc * 4  }),
			new ReflexMenuItem({ text: "An Options Screen", styles: "animate_in", animationDelay: _animInc * 5  }),
			new ReflexMenuItem({ text: "Quit", onClick: game_end, styles: "animate_in", animationDelay: _animInc * 6  })
		])
	);
}

function demoShowLayout() {
	ReflexClear();
	Reflex(
		demoHeader("Layouts"),
		demoLayout(),
	
	);
}

function demoShowBindingProperties() {
	ReflexClear();
	Reflex(
		demoHeader("Binding Properties"),
		demoBindingProperties()
	)
}

function demoShowGamepadNavigation() {
	ReflexClear();
	Reflex(
		demoHeader("Gamepad Navigation"),
		demoGamepadNavigation()
	);
}

function demoShowAnimations() {
	ReflexClear();
	Reflex(
		demoHeader("Animations"),
		demoAnimations()
	);
}