function transition_function(_function = function(){}, _spd = .1) {
	if !instance_exists(obj_transition_function) {
		input_lock_all(true);
		instance_create_depth(0, 0, 0, obj_transition_function, {spd: _spd, action: _function});
	}
};

function is_transitioning() { return instance_exists(obj_transition_function) };