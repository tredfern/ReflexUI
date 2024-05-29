function ReflexPropertyBinder(_from, _fromProp, _default = undefined) constructor {
	from = _from;
	fromProp = _fromProp;
	defaultValue = _default;
}

function reflexCreateBind(_from, _fromProp, _default = undefined) {
	return new ReflexPropertyBinder(_from, _fromProp, _default);	
}