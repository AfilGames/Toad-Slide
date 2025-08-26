/// @description Setup

// Inherit the parent event
event_inherited();

update_depth = function() {
	depth = .25;
}

update_depth();

#region Grid Data
	
	grid_data.action_modify = function(_instance) {
		_instance.move_continuous();
	}

#endregion