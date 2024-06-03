

function demoLayout() {
	return new ReflexBlock({}, [
		new ReflexBlock({ margin: 10, backgroundColor: c_blue, color: c_white }, [
			new ReflexText({ text: "Some text with a \n line break", styles: ["outlined", "padded"] }),
			new ReflexText({ text: "Another text segment", styles: ["outlined", "padded"] }),
			new ReflexText({ text: "I'm aligned middle", styles: ["outlined", "padded"], valign: fa_middle }),
			new ReflexText({ text: "I'm aligned bottom", styles: ["outlined", "padded"], valign: fa_bottom }),
		
			new ReflexBlock({ margin: 10, backgroundColor: c_ltgray, color: c_black }, [
				new ReflexText({ text: "Block inside a block", styles: ["outlined", "padded"] }),
				new ReflexText({ text: "Align Center", styles: ["outlined", "padded"], halign: fa_center }),
				new ReflexText({ text: "Pulled Right", styles: ["outlined", "padded"], halign: fa_right })
			])
		]),
		new ReflexBlock({ styles: ["panel", "padded"] }, [
			new Description("You can manually set the size of images"),
			new ReflexImage({ sprite: sprOne, width: 120, height: 120 })
		])
	]);
}