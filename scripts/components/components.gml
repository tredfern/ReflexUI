function demoHeader() {
	return new ReflexBlock({ styles: "demo_header" }, [
		new ReflexButton({ styles: "demo_back_button", text: "Back", onClick: demoShowMenu })
	]);
}