/// @description Setup

// Inherit the parent event
event_inherited();

draw_element = function() {
	draw_sprite_ext(
		sprite_index,
		deactivated,
		x + X_OFFSET + anim_offset.x + anim_linear_offset.x,
		y + Y_OFFSET + anim_offset.y + anim_linear_offset.y + anim_height,
		image_xscale * (anim_xscale * anim_master_scale),
		image_yscale * (anim_yscale * anim_master_scale),
		image_angle + anim_tilt + anim_invalid * lengthdir_x(30, current_time * 2),
		image_blend,
		image_alpha
	)
};