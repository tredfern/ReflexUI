/// @description Insert description here
// You can write your code in this editor

//show_debug_overlay(true);
counter = 0;

Reflex(
	new ReflexMenu({}, [
		new ReflexMenuItem({ text: "Menu 1" }),
		new ReflexMenuItem({ text: "Menu 2" }),
		new ReflexMenuItem({ text: "Menu 3" })
	]),
	new ReflexBlock({}, [
		new ReflexBlock({ styles: "pink" }, [
			new FrameCounter(),
			"Hello World2"
		]),
		new ReflexBlock({ styles: "big_blue"}, [
			new ReflexText({ text: "Hello World3" }),
			new ReflexText({ text: "Hello World4" })
		]),
		new ReflexBlock({ styles: "big_blue pink"}, [
			new ReflexText({ text: "Hello World5" }),
			new ReflexText({ text: "Hello World6" })
		]),
		new ReflexBlock({ margin: 10, height: 15, backgroundColor: c_fuchsia }),
		new ReflexBlock({ margin: 10, backgroundColor: c_navy}, [
			new ReflexBlock({ margin: 10, backgroundColor: c_fuchsia }, [
				new ReflexBlock({ margin: 10, height: 15, backgroundColor: c_green }),
				new ReflexBlock({ margin: 10, height: 15, backgroundColor: c_green }),
			]),
			new ReflexBlock({ margin: 10, height: 15, backgroundColor: c_fuchsia }),
			new ReflexBlock({ margin: 10, height: 15, backgroundColor: c_fuchsia })
		])
	]),
	
	
);