function reflexFindByID(_id) {
	return reflexTreeFindFirst(function(_component, _id) { return _component.id == _id; }, _id);
}