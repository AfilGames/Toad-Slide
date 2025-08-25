/// @description Setup

event_inherited();

action = function() {
	with(target) {
		deactivated = true;
	}
	deactivated = true;
}

draw_element = function() {
	if !deactivated {
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
}