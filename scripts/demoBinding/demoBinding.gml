
function demoBindingProperties() {
	return new ReflexBlock({ styles: "panel" }, [
		new Description("This counter is bound to a property in an object instance. Reflex is transferring the data over"),
		FrameCounter(),
		new Description("This is a list of items. The item list is defined in objDemo. To be honest, lists are a pain and still require a bit of manual love."),
		new ListOfItems(),
		new ReflexButton({ text: "Add Item", onClick: function() { array_push(objDemo.list, { image: sprEight, name: "new item" }); }, border: 1, borderColor: c_black })
	]);
	
}

function FrameCounter() {
	return {
		frameNumber: reflexCreateBind(objDemo, "counter", 0),
	
		render: function() {
			return new ReflexText({ text: "Frames: {frameNumber}" });	
		}	
	}
}

function ListOfItems() : ReflexComponent() constructor {
	list = bind(objDemo, "list");
	
	static render = function() {
		return array_map(list, function(_item) { return new Item(_item); });
	}
	
	static onUpdate = function(_updates) {
		//When we are updated, tell the view to refresh
		refresh();
	}
		
}

function Item(_item) : ReflexComponent({ item: _item },, "Item") constructor {
	static render = function() {
		return [
			new ReflexImage({ sprite: item.image }),
			new ReflexText({ text: item.name, valign: fa_middle }),
			new ReflexButton({ text: "X", onClick: method(self, removeItem), border: 1, borderColor: c_red })
		];
	}
	
	static removeItem = function() {
		reflexArrayRemove(objDemo.list, item);
	}
}