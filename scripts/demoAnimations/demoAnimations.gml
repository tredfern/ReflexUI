function demoAnimations() {
	// Animations are configured in stylesheet file
	return new ReflexBlock({ styles: "panel" }, [
		new Description("Animations can be performed on any of the controls properties including colors and position.\nThis does not change the layout of the components, it impacts how the component is drawn to the screen."),
		new ReflexBlock({ margin: { top: 100 } }, [
			new ReflexText({ text: "Bounce Fast!", styles: "padded outlined", animation: ["bounceCont", "colorPulse2"], animationDuration: 20, color: c_white, margin: { right: 10 } }),
			new ReflexText({ text: "Bounce Mid!", styles: "padded outlined", animation: ["bounceCont", "colorPulse3"], animationDuration: 60, color: c_white, margin: { right: 10 } }),
			new ReflexText({ text: "Bounce Slow!", styles: "padded outlined", animation: ["bounceCont", "colorPulse4"], animationDuration: 120, color: c_white }),
		])
	]);

}