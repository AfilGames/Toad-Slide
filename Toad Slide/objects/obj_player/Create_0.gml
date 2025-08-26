// Inherit the parent event
event_inherited();

can_move = true;

x_side = 1;
time_offset_celebration = 0;

continuous_movement = false;

input_buffer = new Vector2();

grid_data.move_direction.x = 1;

dead = false;

dead_timer = 0;

kill = function() {
	dead = true;
}

move_continuous = function() {
	with(grid_data) {
		timer = 0;
		pos_source = new Vector2(owner.x, owner.y);
		pos_target = new Vector2(owner.x + move_direction.x * UNIT, owner.y + move_direction.y * UNIT);
		action_modify = template_player_action_modify;
		action_start = template_player_action_start;
		action_update = template_player_action_update;
		action_end = template_player_action_end;
	}
	grid_data_restart();
}

#region Grid Data
	
	grid_data_function_move = function(_direction) {
		var _move = new ElementData(id);
		with(_move) {
			timer = owner.move_interval + 1;	//	Gambiarra trivial
			move_direction = variable_clone(_direction);
			pos_source = new Vector2(owner.x, owner.y);
			pos_target = new Vector2(owner.x + _direction.x * UNIT, owner.y + _direction.y * UNIT);
			action_modify = template_player_action_modify;
			action_start = template_player_action_start;
			action_update = template_player_action_update;
			action_end = template_player_action_end;
		}
		
		grid_data_set(_move);
	}

#endregion

call_later(5, time_source_units_frames, function() {
	rewind_save();
});

update_depth = function() {
	depth = -y - 2;
}

animate_interact = function(_x = grid_data.move_direction.x, _y = grid_data.move_direction.y) {
	var _kick_sprite = spr_player_kick_front;
	if (_x != 0) {
		_kick_sprite = spr_player_kick_site;
	}
	else if (_y < 0) {
		_kick_sprite = spr_player_kick_back;
	}
	
	anim_offset.x = grid_data.move_direction.x * 12;
	anim_offset.y = grid_data.move_direction.y * 12;
	
	sprite_index = _kick_sprite;
	image_index = 0;
}

#region Interactions
	
	push = function() {
		
		var _list = ds_list_create();
	
		var _pushing = noone;
	
		instance_position_list(x + grid_data.move_direction.x * UNIT, y + grid_data.move_direction.y * UNIT, obj_interactable, _list, false);
	
		for (var i = 0; i < ds_list_size(_list); i++) {
			var _element = _list[| i];
		
			if !_element.deactivated {
				_pushing = _element;
			}
		}
		ds_list_destroy(_list);
	
		if instance_exists(_pushing) {
			if (!_pushing.deactivated) {
				animate_interact();
			
				audio_play_sfx_random([snd_char_punch_hit1_stone, snd_char_punch_hit2_stone, snd_char_punch_hit3_stone]);
			
				var _valid = grid_data.check_pushable_valid(_pushing.x, _pushing.y, grid_data.move_direction.x, grid_data.move_direction.y);
			
				if _valid {
					rewind_save();
				}
			
				_pushing.action(id);
			
			}
		}
		else {
			audio_play_sfx_random([snd_char_punch2_air, snd_char_punch3_air]);
		}
	}
	
	grab_time = 15;
	grab_clock = 0;
	grab_object = noone;
	
	grab = function() {
		if !instance_exists(grab_object) {
		
			var _dx = grid_data.move_direction.x;
			var _dy = grid_data.move_direction.y;
		
			var _length = 0;
		
			while(true) {
				var _x = x + (_dx * _length * UNIT);
				var _y = y + (_dy * _length * UNIT);
			
				var _pushable = noone;
				var _pushables = ds_list_create();
			
				var _freespace = position_meeting(_x, _y, obj_free_space);
			
				instance_position_list(_x, _y, obj_pushable, _pushables, false);
			
				for (var i = 0; i < ds_list_size(_pushables); i++) {
					var _element = _pushables[| i];
				
					if !_element.deactivated {
						_pushable = _element;
						break;
					}
				}
			
				if (instance_exists(_pushable)) {
					grab_object = _pushable;
					grab_clock = grab_time;
					_element.anim_offset.x = _element.x - x;
					_element.anim_offset.y = _element.y - y;
					_element.x = x;
					_element.y = y;
					
					rewind_save();
				
					break;
				}
				else {
					if !_freespace break;
				
					_length++;
				}
			}
		}
		else {
			var _valid = grab_object.grid_data.check_pushable_valid(grab_object.x, grab_object.y, grid_data.move_direction.x, grid_data.move_direction.y);
			
			if _valid {
				rewind_save();
				grab_object.deactivated = false;
				animate_interact();

				audio_play_sfx_random([snd_char_punch_hit1_stone, snd_char_punch_hit2_stone, snd_char_punch_hit3_stone]);
				
				grab_object.action(id);
				
				grab_object = noone;
			}
		}
	}
	
	interact = function() {};
	
	switch(interaction) {
		case "push": interact = push break;
		case "grab": interact = grab break;
	}

#endregion

grid_data_reset = function() {
	var _movement = variable_clone(grid_data.move_direction);
	var _modify = grid_data.action_modify;
	var _flag = grid_data.invalid_flag;
	grid_data = new ElementData(id);
	grid_data.move_direction = _movement;
	grid_data.action_modify = _modify;
	grid_data.invalid_flag = _flag;
}

draw_element = function() {

	if dead gpu_set_fog(true, #ffffff, 0, 1);

	draw_sprite_ext(
		sprite_index,
		image_index,
		x + X_OFFSET + anim_linear_offset.x + anim_offset.x,
		y + Y_OFFSET + anim_linear_offset.y + anim_offset.y + anim_height,
		-image_xscale * x_side,
		image_yscale,
		image_angle + anim_tilt + anim_invalid * lengthdir_x(30, current_time * 3.3),
		image_blend,
		image_alpha
	)
	
	if dead gpu_set_fog(false, #ffffff, 1, 0);
}
	
death_sequence = function() {
	dead_timer += dead;
	
	if ((dead_timer >= 20) and !deactivated) {
		obj_camera_manager.shake(5, 110);
		
		var _number = 8;
		for (var i = 0; i < _number; i++) {
			var _segment = 360 / _number;
			var _rand = random_range(-_segment * .5, _segment * .5);
	
			var _angle = _segment * i + _rand;
			var _speed = random_range(4, 10);
	
			var _xsp = lengthdir_x(_speed, _angle);
			var _ysp = lengthdir_y(_speed, _angle);
	
			var _part = instance_create_depth(x + UNIT * .5, y + UNIT * .5, depth, obj_smoke);
	
			_part.spd.x = lengthdir_x(_speed, _angle);
			_part.spd.y = lengthdir_y(_speed, _angle);
	
			_part.image_index = random(.5);
		}
		
		deactivated = true;
	}
	
	if (dead_timer == 40) {
		obj_main.restart();
	}
}