/// @description Setup

// Inherit the parent event
event_inherited();

objective_type = "container";

fog_alpha = 0;

grid_data.action_modify = function(_instance) {
	
	//	Stops Everything
	_instance.grid_data_reset();
	
}

update_depth = function() {
	depth = -y + UNIT * 1.5;
}

update_depth();

action = function(_instance) {
	if (objective_type == "interactable") obj_main.win();
}

collide = function(_instance) {
	if ((hp <= 0) or (objective_type != "destructable")) exit;
	_instance.deactivated = true;
	hp--;
}