/// @description Setup

// Inherit the parent event
event_inherited();

action = function() {
	deactivated = true;
	
	audio_play_sfx(snd_bloco_quebrar);
}

update_depth = function() {
	if deactivated {
		depth = -y + UNIT * 1.1;
	}
	else {
		depth = -y;
	}
}

update_depth();

draw_element = function() {
	draw_sprite_ext(
		sprite_index,
		deactivated,
		x + X_OFFSET + anim_offset.x + anim_linear_offset.x,
		y + Y_OFFSET + anim_offset.y + anim_linear_offset.y + anim_height,
		image_xscale,
		image_yscale,
		image_angle + anim_tilt + anim_invalid * lengthdir_x(30, current_time * 2),
		image_blend,
		image_alpha
	)
}