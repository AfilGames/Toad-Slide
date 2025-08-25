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

draw_element = function() {
	draw_sprite_ext(
		sprite_index,
		image_index,
		x + X_OFFSET + anim_offset.x,
		y + Y_OFFSET + anim_offset.y + anim_height,
		image_xscale,
		image_yscale,
		image_angle + anim_tilt + anim_invalid * lengthdir_x(30, current_time * 2),
		image_blend,
		image_alpha
	)
}