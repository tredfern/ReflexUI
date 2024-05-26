function demoHeader(_title) {
	return new ReflexBlock({ styles: "demo_header" }, [
		new ReflexText({ styles: "header1", text: _title }),
		new ReflexButton({ styles: "demo_back_button", text: "Back", onClick: demoShowMenu, hotVerb: "cancel" })
	]);
}