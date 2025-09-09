/// @description Setup

movement = new Vector2();
target_pos = new Vector2(x, y);
anim_offset = new Vector2(0, 0);
anim_linear_offset = new Vector2();
anim_tilt = 0;
anim_height = 0;
anim_invalid = 0;
anim_xscale = 1;
anim_yscale = 1;
anim_master_scale = 1;

deactivated = false;

can_move = false;

slide_sound = noone;

kill = function() {
	
}

rewind_function = function() {
	
}

#region Grid Data

	grid_data = new ElementData(id);
	grid_data_set = function(_data) {
		if (grid_data.timer > 0) {
			return false
		}
		grid_data = _data;
		grid_data.action_start();
		
		return true;
	}
	grid_data_reset = function() {
		grid_data = new ElementData(id);
	}
	grid_data_restart = function() {
		var _data = variable_clone(grid_data);
		_data.timer = move_interval;
		grid_data_set(_data);
	}
	grid_data_update = function() {
		grid_data.timer -= (grid_data.timer > 0);
		
		if (grid_data.timer <= 0) {
			grid_data.action_end();
		}
		grid_data.action_update();
	}
	grid_data_reset();

#endregion

update_depth = function() {
	depth = -y;
}

update_depth();

//	Gambiarra Pro Max™
if !variable_instance_exists(id, "hp") {
	hp = 0;
}

draw_element = function() {
	draw_sprite_ext(
		sprite_index,
		image_index,
		x + X_OFFSET + anim_offset.x + anim_linear_offset.x,
		y + Y_OFFSET + anim_offset.y + anim_linear_offset.y + anim_height,
		image_xscale * (anim_xscale * anim_master_scale),
		image_yscale * (anim_yscale * anim_master_scale),
		image_angle + anim_tilt + anim_invalid * lengthdir_x(30, current_time * 2),
		image_blend,
		image_alpha
	)
}