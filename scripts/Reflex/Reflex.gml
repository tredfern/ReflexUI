function Reflex() {
	var _components = [];
	for(var _c = 0; _c < argument_count; _c++) {
		array_push(_components, argument[_c]);
	}
	reflexRender(_components);
}

function ReflexClear() {
	reflexClearAll();
}