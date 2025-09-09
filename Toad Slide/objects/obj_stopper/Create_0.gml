/// @description Setup

// Inherit the parent event
event_inherited();

fog_alpha = 0;

update_depth = function() {
	depth = -y + UNIT * 1.1;
}

update_depth();

grid_data.action_modify = function(_instance) {
	
	//	Stops Everything
	_instance.grid_data_reset();
}