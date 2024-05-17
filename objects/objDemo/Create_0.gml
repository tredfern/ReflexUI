/// @description Insert description here
// You can write your code in this editor

reflexRender(
	new ReflexBlock({}, [
		new ReflexBlock({}, [
			new ReflexText({ text: "Hello World" }),
			new ReflexText({ text: "Hello World2" })
		]),
		new ReflexBlock({}, [
			new ReflexText({ text: "Hello World3" }),
			new ReflexText({ text: "Hello World4" })
		]),
		new ReflexBlock({}, [
			new ReflexText({ text: "Hello World5" }),
			new ReflexText({ text: "Hello World6" })
		])
	])
);