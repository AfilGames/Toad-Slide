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
	depth = -y + 1.5;
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

draw_element = function() {
	draw_sprite_ext(
		sprite_index,
		image_index,
		x + X_OFFSET + anim_offset.x + anim_linear_offset.x,
		y + Y_OFFSET + anim_offset.y + anim_linear_offset.y + anim_height,
		image_xscale,
		image_yscale,
		image_angle + anim_tilt + anim_invalid * lengthdir_x(30, current_time * 2),
		image_blend,
		image_alpha
	)
}