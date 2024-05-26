function ReflexStateManager() constructor {
	mappings = [];
	
	static bind = function(_to, _toProp, _from, _fromProp) {
		array_push(mappings, {
			to: reflexWeakRef(_to),
			toProp: _toProp,
			from: reflexWeakRef(_from),
			fromProp: _fromProp,
			value: undefined
		});
	}
	
	static step = function() {
		var deleteList = [];
		var _updates = ds_map_create();
		
		for(var _mapIndex = 0; _mapIndex < array_length(mappings); _mapIndex++) {
			var _binding = mappings[_mapIndex];
			if(!reflexCheckWeakRef(_binding.to) || !reflexCheckWeakRef(_binding.from)) {
				array_push(deleteList, _mapIndex);	
			} else {
				var _comp = _binding.to.ref;
				if(_comp.isLoaded) {
					var _v = _binding.from[$ _binding.fromProp];
				
					if(_v != _binding.value) {
						_comp[$ _binding.toProp] = _v;
					
						//Track updated components
						if(_updates[? _comp] == undefined) {
							_updates[? _comp] = {};	
						}

						_updates[? _comp][$ _binding.toProp] = _v;
					}
				}
			}
		}
		
		// Clean up dead entries in bindings
		for(var _i = array_length(deleteList) - 1; _i >= 0; _i--) {
			array_delete(mappings, deleteList[_i], 1);
		}
		
		//Trigger updates
		var _keys = ds_map_keys_to_array(_updates);
		for(var _i = 0; _i < array_length(_keys); _i++) {
			reflexSafeEvent(_keys[_i], REFLEX_EVENT_ON_UPDATE, _updates[? _keys[_i]]);
		}
		
		ds_map_destroy(_updates);
	}
}


function reflexBindProperty(_structTo, _toPropName, _from, _fromPropName) {
	REFLEX_STATE.bind(_structTo, _toPropName, _from, _fromPropName);
}