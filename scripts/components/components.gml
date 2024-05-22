function demoHeader() {
	return new ReflexBlock({ styles: "demo_header" }, [
		new ReflexButton({ styles: "demo_back_button", text: "Back", onClick: demoShowMenu })
	]);
}

function demoLayout() {
	return new ReflexBlock({}, [
		new ReflexBlock({ margin: 10, backgroundColor: c_blue, color: c_white }, [
			new ReflexText("Some text\n going to a new line"),
			new ReflexText("Another text segment"),
			new ReflexBlock({ margin: 10, backgroundColor: c_ltgray, color: c_black }, [
				new ReflexText("Some text inside this block")
			])
		])
	]);
	
}