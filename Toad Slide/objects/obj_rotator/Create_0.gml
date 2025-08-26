/// @description Setup

// Inherit the parent event
event_inherited();

//image_angle = wrap(image_angle, 0, 360);

update_depth = function() {
	depth = -y + UNIT * 1.1;
}

image_angle = wrap(image_angle, 0, 360);

dir_right = new Vector2(lengthdir_x(image_xscale, 0), lengthdir_y(image_yscale, 0));
dir_up = new Vector2(lengthdir_x(image_xscale, 90), lengthdir_y(image_yscale, 90));

tile_right = new Vector2(x + dir_right.x * UNIT, y + dir_right.y * UNIT);
tile_up = new Vector2(x + dir_up.x * UNIT, y + dir_up.y * UNIT);

check_valid_pos = function(_x, _y) {
	return ((point_distance(tile_right.x, tile_right.y, _x, _y) <= 5) * 1 + (point_distance(tile_up.x, tile_up.y, _x, _y) <= 5) * 2);
}

check = function(_x, _y, _spdx = 0, _spdy = 0) {
	var _cx = x;
	var _cy = y;
	
	if (point_distance(_x, _y, tile_right.x, tile_right.y) <= 5) {
		_cx = tile_up.x;
		_cy = tile_up.y;
		
		_spdx = dir_up.x;
		_spdy = dir_up.y;
		
	}
	else if (point_distance(_x, _y, tile_up.x, tile_up.y) <= 5) {
		_cx = tile_right.x;
		_cy = tile_right.y;
		
		_spdx = dir_right.x;
		_spdy = dir_right.y;
	}
	else return false;
	
	var _obstacle = grid_data.check_obstacle(_cx, _cy);
	var _freespace = grid_data.check_freespace(_cx, _cy);
	var _modifier = grid_data.check_modifier(_cx, _cy);
	
	var _valid_pos = bool(check_valid_pos(_x, _y));
	var _valid_space = instance_exists(_freespace);
	var _valid_obstacle = !(instance_exists(_obstacle) and !_obstacle.deactivated);
	var _valid_modifier = (instance_exists(_modifier) and !_modifier.deactivated and _modifier.check(x, y, _spdx, _spdy)) or !instance_exists(_modifier);
	
	return _valid_pos and _valid_space and _valid_obstacle and _valid_modifier;
}

update_depth();

#region Grid Data
	
	grid_data.action_modify = function(_instance) {
		with(_instance.grid_data) {
			audio_play_sfx(snd_tile_flecha);
			
			//move_direction.x = round(lengthdir_x(1, owner.image_angle));
			//move_direction.y = round(lengthdir_y(1, owner.image_angle));
			
			var _check = other.check_valid_pos(owner.x - move_direction.x * UNIT, owner.y - move_direction.y * UNIT);
			
			if (_check == 1) {
				move_direction = variable_clone(other.dir_up);
			}
			else if (_check == 2) {
				move_direction = variable_clone(other.dir_right);
			}
			
			if bool(_check) {
				pos_target = new Vector2(owner.x + move_direction.x * UNIT, owner.y + move_direction.y * UNIT);
				action_start = template_pushable_action_start;
				action_end = template_pushable_action_end;
			}
			else {
				template_pushable_invalid_position(true);
			}
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
		image_xscale,
		image_yscale,
		image_angle + anim_tilt,
		image_blend,
		image_alpha
	);
}