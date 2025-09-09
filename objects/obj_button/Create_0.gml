/// @description Setup

// Inherit the parent event
event_inherited();

update_depth = function() {
	depth = -y + UNIT;
}

update_depth();

grid_data.action_modify = function(_instance) {
	//with(_instance.grid_data) {			
	//	pos_source = variable_clone(pos_target);
	//}
};