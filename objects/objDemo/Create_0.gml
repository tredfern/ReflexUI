/// @description Insert description here
// You can write your code in this editor

//show_debug_overlay(true);
counter = 0;

Reflex(
	new ReflexMenu({}, [
		new ReflexMenuItem({ text: "Layout Demo" }),
		new ReflexMenuItem({ text: "Binding Properties" }),
		new ReflexMenuItem({ text: "Gamepad Navigation" }),
		new ReflexMenuItem({ text: "Animations" }),
		new ReflexMenuItem({ text: "Game Screen" }),
		new ReflexMenuItem({ text: "Quit", onClick: game_end })
	])
);