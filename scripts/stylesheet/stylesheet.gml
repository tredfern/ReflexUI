reflexColors({
	focus: c_yellow,
});

reflexAnimations({
	slideOn: new ReflexAnimation("x", reflexAnimBack, -1400, 0),
	bounceOn: new ReflexAnimation("y", reflexAnimBounce, -100, 0),
	colorPulse: new ReflexAnimation("backgroundColor", reflexAnimMidSlow, c_orange, c_yellow, ReflexAnimationType.PingPong),
});

reflexStyleSheet({
	ReflexMenu: {
		font: fntMenuButtons	
	},
	ReflexMenuItem: {
		padding: 10,	
		focus: {
			animation: "colorPulse",
			animationDuration: 45
		}

	},
	animate_in: {
		animation: ["slideOn", "bounceOn"],
		animationDelay: 0,
		animationDuration: 60,
	},
	demo_header: {
		backgroundColor: "lightShade"
	},
	demo_back_button: {
		border: 1,
		borderColor: "darkAccent",
		backgroundColor: "lightShade",
		hover: {
			backgroundColor: "lightAccent"	
		},
		margin: { top: 5, bottom: 5, right: 10 },
		halign: fa_right
	},
	die_block: {
		backgroundColor: c_white,
		backgroundImage: sprSquarePanel,
		color: c_ltgray,
		padding: 6
	},
	focus_enabled: {
		canFocus: true,
		focus: {
			backgroundColor: "focus",
			color: c_white
		}
	},
	outlined: {
		border: 1,
		borderColor: c_black
	},
	padded: {
		padding: 3
	},
	panel: {
		backgroundColor: c_white,
		backgroundImage: sprGrayPanel,
		padding: 10
	}
})
