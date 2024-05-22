function demoShowMenu() {
	ReflexClear();
	Reflex(
		new ReflexMenu({}, [
			new ReflexMenuItem({ text: "Layout Demo", onClick: demoShowLayout }),
			new ReflexMenuItem({ text: "Binding Properties" }),
			new ReflexMenuItem({ text: "Gamepad Navigation" }),
			new ReflexMenuItem({ text: "Animations" }),
			new ReflexMenuItem({ text: "Game Screen" }),
			new ReflexMenuItem({ text: "Quit", onClick: game_end })
		])
	);
}

function demoShowLayout() {
	ReflexClear();
	Reflex(
		demoHeader(),
	);
}