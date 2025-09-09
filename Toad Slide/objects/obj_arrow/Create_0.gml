/// @description Setup

// Inherit the parent event
event_inherited();

//image_angle = wrap(image_angle, 0, 360);

if ((image_xscale != 1) or (image_yscale != 1)) {
	show_debug_message("SCALED ROTATOR ALERT, PLEASE REPORT TO DEV");
}

update_depth = function() {
	depth = -y + UNIT * 1.1;
}

image_angle = wrap(image_angle, 0, 360);

if ((round(image_angle / 90) * 90) == 180) {
	image_xscale = -1;
}
else if ((round(image_angle / 90) * 90) == 90) {
	sprite_index = spr_arrow_up;
}
else if ((round(image_angle / 90) * 90) == 270) {
	sprite_index = spr_arrow_down;
}

update_depth();

#region Grid Data
	
	grid_data.action_modify = function(_instance) {
		with(_instance.grid_data) {
			audio_play_sfx(snd_tile_flecha);
			
			move_direction.x = round(lengthdir_x(1, other.image_angle));
			move_direction.y = round(lengthdir_y(1, other.image_angle));
			
			pos_target = new Vector2(owner.x + move_direction.x * UNIT, owner.y + move_direction.y * UNIT);
			action_start = template_pushable_action_start;
			action_end = template_pushable_action_end;
		}
		
		_instance.grid_data_set(_instance.grid_data);
	}

#endregion
	
draw_element = function() {
	draw_sprite_ext(
		sprite_index,
		image_index,
		x + X_OFFSET + anim_offset.x,
		y + Y_OFFSET + anim_offset.y + anim_height,
		image_xscale * (anim_xscale * anim_master_scale),
		image_yscale * (anim_yscale * anim_master_scale),
		anim_tilt,
		image_blend,
		image_alpha
	);
}