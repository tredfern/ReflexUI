Reflex(
    new ReflexBlock({ backgroundColor: c_ltgray }, [
        new ReflexText({ text: "I'm some text in a block", valign: fa_middle, margin: 10 }),
        new ReflexButton({ 
            margin: 10,
            padding: 15, 
            border: 1,
            borderColor: c_red,
            halign: fa_right,
            backgroundColor: c_green,
            text: "Push Me", 
            onClick: game_end })
    ])
);