function ElementData(
	_owner = id,
	_source = new Vector2(_owner.x, _owner.y),
	_target = new Vector2(_owner.x, _owner.y),
	_direction = new Vector2(),
	_action_start = function() {},
	_action_end = function() {},
	_action_update = function() {},
	_action_modify = function(_instance) {}
	) constructor {
	
	owner = _owner;
	
	pos_source = _source;
	pos_target = _target;
	move_direction = _direction;
	timer = 0;
	
	invalid_flag = false;
	
	action_start = _action_start;
	action_update = _action_update
	action_end = _action_end;
	action_modify = _action_modify;
	
	#region Utilitary
	
		//	Position to Owner - Sets the owner position (default arguments sets it to the element data target position)
		static position_to_owner = function(_x = pos_target.x, _y = pos_target.y) {												///	@func position_to_owner(x,y)
			owner.x = _x;
			owner.y = _y;
			
			owner.update_depth();
		}
		//	Position From Owner - Sets the element data target position (default arguments sets it to the owners position)
		static position_from_owner = function(_x = owner.x, _y = owner.y) {														///	@func position_from_owner(x,y)
			pos_target.x = _x;
			pos_target.y = _y;
			
			owner.update_depth();
		}
	
		//	Check For Modifier - Returns if there is a modifier in given position
		static check_modifier = function(_x = pos_target.x, _y = pos_target.y) {												///	@func check_modifier(x,y)
			var _result = noone;
			var _list = ds_list_create();
	
			instance_position_list(_x, _y, obj_modifier, _list, false);
	
			for (var i = 0; i < ds_list_size(_list); i++) {
				var _element = _list[| i];
	
				if !_element.deactivated {
					_result = _element;
				}
			}
			ds_list_destroy(_list);
	
			return _result;
		}	
		//	Check For Free Space - Returns if given position is inside the playing grid (checks if there is a free space there)
		static check_freespace = function(_x = pos_target.x, _y = pos_target.y) {												///	@func check_freespace(x,y)
			return position_meeting(_x, _y, obj_free_space);
		}
		//	Check For Obstacle - Returns if there is an obstacle in a given position
		static check_obstacle = function(_x = pos_target.x, _y = pos_target.y, _obstacle = obj_obstacle, _exceptions = []) {	///	@func check_obstacle(x,y,obstacle,exception)
			var _result = noone;
			var _list = ds_list_create();
		
			instance_position_list(_x, _y, _obstacle, _list, false);
		
			for (var i = 0; i < ds_list_size(_list); i++) {
				var _element = _list[| i];
			
				if (!_element.deactivated and !(element_is_objective(_element) and (_element.objective_type == "container"))) {	//	TODO: Remove
					_result = _element;
				}
			}
			ds_list_destroy(_list);
		
			return _result;
		}
		//	Check If Pushable Is Pushable - Returns if 
		static check_pushable_valid = function(_x, _y, _xdir, _ydir) {															///	@func check_pushable_valid(x,y,xdir,ydir)
			var _obstacle = instance_position(_x + _xdir * UNIT, _y + _ydir * UNIT, obj_obstacle);
			if (instance_exists(_obstacle) and (_obstacle.deactivated or (element_is_objective(_obstacle) and (_obstacle.objective_type == "container")))) {
				_obstacle = noone;
			}
			
			var _free_space = position_meeting(_x + _xdir * UNIT, _y + _ydir * UNIT, obj_free_space);
			
			return (!bool(_obstacle) and _free_space);
		}
		//	Check For Collectable
		static check_collectable = function(_x = pos_target.x, _y = pos_target.y) {												///	@func check_collectable(x,y)
			var _result = noone;
			var _list = ds_list_create();
		
			instance_position_list(_x, _y, obj_collectable, _list, false);
		
			for (var i = 0; i < ds_list_size(_list); i++) {
				var _element = _list[| i];
			
				if !_element.deactivated {
					_result = _element;
				}
			}
			ds_list_destroy(_list);
		
			return _result;
		}
		//	Check For Objective
		static check_objective = function(_x = pos_target.x, _y = pos_target.y) {												///	@func check_objective(x,y)
			var _result = noone;
			var _list = ds_list_create();
		
			instance_position_list(_x, _y, obj_objective, _list, false);
		
			for (var i = 0; i < ds_list_size(_list); i++) {
				var _element = _list[| i];
			
				if !_element.deactivated {
					_result = _element;
				}
			}
			ds_list_destroy(_list);
		
			return _result;
		}
		
		//	Check For Moving Pushable
		static check_moving_pushable = function() {																				///	@func check_moving_pushable()
			var _moving = false;
			
			with(obj_pushable) {
				_moving = ((grid_data.move_direction.x != 0) or (grid_data.move_direction.y != 0));
				
				if _moving break;
			}
			
			return _moving;
		}
		
		//	Animation Trigger - USED IN STEPPED MODE to set animation offsets.
		static animation_trigger = function(_offset_x, _offset_y, _invalid, _height, _tilt) {									///	@func animation_trigger(offsetx,offsety,invalid,height,tilt)
			owner.anim_offset.x = _offset_x;
			owner.anim_offset.y = _offset_y;
		
			owner.anim_height = _height;
			owner.anim_tilt = _tilt;
			owner.anim_invalid = _invalid;
		}	
		//	Animation Continuous - USED IN CONTINUOUS MODE to set animation offsets.
		static animation_continuous = function(_x, _y) {																		///	@func animation_continuous(x,y)
			owner.anim_linear_offset.x = _x;
			owner.anim_linear_offset.y = _y;
		}
		
	#endregion
	#region Template
		
		#region Pushable

			static template_pushable_valid_position = function() {																/// @func template_pushable_valid_position()
				var _xoff = -move_direction.x * UNIT;
				var _yoff = -move_direction.y * UNIT;
			
				if (!owner.continuous_animation) {
					animation_trigger(_xoff, _yoff, 0, -10, -move_direction.x * 30);
				}
				else {
					animation_continuous(_xoff, _yoff);
				}
			
				position_to_owner();
			}
			static template_pushable_invalid_position = function(_animated) {													///	@func template_pushable_invalid_position(animated)
				if _animated {
					var _xoff = -move_direction.x * 8;
					var _yoff = -move_direction.y * 8;
			
					animation_trigger(_xoff * 0, _yoff * 0, 1, 0, -move_direction.x * 30);
				}
			
				position_from_owner();
			
				owner.grid_data_reset();
			}
			static template_pushable_post_check_modifier = function() {															///	@func template_pushable_post_check_modifier()
				//	Check for container objective
				var _objective = check_objective(owner.x, owner.y);
				var _container = instance_exists(_objective) and (_objective.objective_type == "container");
				
				//	Check for Modifier
				var _modifier = check_modifier(owner.x, owner.y);
			
				if (instance_exists(_modifier) and (!_modifier.deactivated)) {
					_modifier.grid_data.action_modify(owner);
				}
				else if _container {
					_objective.grid_data.action_modify(owner);
				}
				else {
					if owner.continuous_movement {
						owner.move_continuous();
					}
					else {
						owner.grid_data_reset();
					}
				}
			}
		
			static template_pushable_action_start = function() {																///	@func template_pushable_action_start()
				timer = owner.move_interval;
			
				//if !audio_is_playing(owner.slide_sound) owner.slide_sound = audio_play_sound(snd_bloco_arrastando_loop, false, true);
			
				var _invalid_anim = false;
				var _valid = true;
			
				//	Checks
				var _exceptions = [];
				var _obstacles = owner.obstacles;
			
				if !owner.sink {
					array_push(_obstacles, obj_hole);
				}
			
				if owner.fit {
					array_push(_obstacles, obj_objective);
				}
			
				var _obstacle = check_obstacle(,, _obstacles, _exceptions);
				var _freespace = check_freespace();
				var _modifier = check_modifier(owner.x + move_direction.x * UNIT, owner.y + move_direction.y * UNIT);
			
				var _obstacle_check = (instance_exists(_obstacle) and !_obstacle.deactivated);
				var _modifier_check = (instance_exists(_modifier) and !_modifier.deactivated and !_modifier.check(owner.x, owner.y, move_direction.x, move_direction.y))
			
				if (_valid and (!_freespace or _obstacle_check or _modifier_check)) {
					_invalid_anim = true;
					_valid = false;
				
					if (instance_exists(_obstacle) and object_is_ancestor(_obstacle.object_index, obj_interactable)) {
						_obstacle.collide(owner);
					}
				}
			
				//	Valid
				if _valid template_pushable_valid_position();
	
				//	Invalid
				else template_pushable_invalid_position(_invalid_anim);
	
				obj_main.update_move();
			}
			static template_pushable_action_end = function() {																	///	@func template_pushable_action_end()
				template_pushable_post_check_modifier();
				
				//	Stop Over Objective
				if position_meeting(owner.x, owner.y, obj_objective) {		//	TODO: REMOVE WITH THIS WHACK ASS SOLUTION IF POSSIBLE
					owner.grid_data_reset();
				}
				
				invalid_flag = false;
			}
		
		#endregion
		
		#region Player
		
			static template_player_action_start = function() {																	///	@func template_player_action_start()
				if (move_direction.x != 0) owner.x_side = move_direction.x;
				
				var _invalid_anim = false;
	
				var _sprite = spr_player_idle_front;
				if (move_direction.x != 0) {
					_sprite = spr_player_idle_side;
				}
				else if (move_direction.y < 0) {
					_sprite = spr_player_idle_back;
				}
	
				owner.sprite_index = _sprite;
				owner.image_index = 0;
	
				//	Validating target position
				var _valid = true;
				var _obstacle = check_obstacle(pos_target.x, pos_target.y, owner.obstacles);
	
				if (_valid && (!position_meeting(pos_target.x, pos_target.y, obj_free_space) || instance_exists(_obstacle) and !_obstacle.deactivated)) {
					if !position_meeting(pos_target.x, pos_target.y, obj_free_space) _invalid_anim = true;
		
					_valid = false;
				}
	
				if (instance_exists(_obstacle) and !_obstacle.deactivated) {
					var _push_mode = array_contains(owner.interact_type, "movement_push");
		
					if (!_obstacle.deactivated and _push_mode or (element_is_objective(_obstacle) and (_obstacle.objective_type == "interactable"))) {
						var _clear_path = check_pushable_valid(_obstacle.x, _obstacle.y, move_direction.x, move_direction.y) or (!_obstacle.can_move);
			
						if (_clear_path and object_is_ancestor(_obstacle.object_index, obj_interactable)) {
							rewind_save();
				
							_obstacle.action(owner);
				
							owner.animate_interact();
						}
						else {
							_invalid_anim = true;
						}
					}
				}
				
				var _collectable = check_collectable(pos_target.x, pos_target.y);
				if instance_exists(_collectable) {
					_collectable.action();
				}
				
				//	Valid Player
				if _valid {
					
					invalid_flag = false;
					
					//	Continuous Rewind
					if owner.continuous_movement {
						var _input_dir = new Vector2(0, 0);
						if !is_transitioning() {
							if !(obj_main.is_winning() or obj_main.is_dying()) {
								_input_dir = input_check_movement_pressed();
							}
						}

						if (abs(_input_dir.x) ^^ abs(_input_dir.y)) {
							rewind_save();
						}
					}
					
					var _xoff = -move_direction.x * UNIT;
					var _yoff = -move_direction.y * UNIT;
					
					if owner.continuous_movement animation_continuous(_xoff, _yoff);
					else {
						owner.anim_offset.x = _xoff;
						owner.anim_offset.y = _yoff;
					}
		
					position_to_owner();
		
					audio_play_sfx_random([snd_steps_1, snd_steps_2, snd_steps_3])
	
					owner.update_depth();
				}
	
				//	Invalid
				else {
					if _invalid_anim {
						owner.anim_invalid = 1;
					}
					
					invalid_flag = true;
					
					if obj_camera_manager.rebound {
						var _xoff = -move_direction.x * UNIT * .125;
						var _yoff = -move_direction.y * UNIT * .125;
						
						obj_camera_manager.x += _xoff;
						obj_camera_manager.y += _yoff;
					}
					
					pos_target.x = owner.x;
					pos_target.y = owner.y;
					
					if owner.continuous_movement {
						var _input_dir = new Vector2(0, 0);
						if (invalid_flag) {
							if !is_transitioning() {
								if !(obj_main.is_winning() or obj_main.is_dying()) {
									_input_dir = input_check_movement();
								}
							}
							if ((abs(_input_dir.x) ^^ abs(_input_dir.y)) and !((move_direction.x == _input_dir.x) and (move_direction.y == _input_dir.y))) {
								owner.input_buffer.x = _input_dir.x;
								owner.input_buffer.y = _input_dir.y;
								move_direction = _input_dir;
							}
							else owner.grid_data_reset();
						}
					}
				}
				
				obj_main.update_move();
			}
			static template_player_action_update = function() {																	///	@func template_player_action_update()
				if !owner.continuous_movement {
					var _input_dir = new Vector2(0, 0);
					if (!is_transitioning() and (owner.grab_clock <= 0) and (owner.eat_clock < 0)) {
						if !(obj_main.is_winning() or obj_main.is_dying()) {
							_input_dir = input_check_movement();
						}
					}
					if (!check_moving_pushable() or owner.move_while_pushable_moving) {
						if (abs(_input_dir.x) ^^ abs(_input_dir.y)) {
							if (!(instance_exists(owner.grab_object) and !owner.move_while_grab) and !owner.is_aiming()) {
								if (timer <= 5) {
									owner.input_buffer.x = _input_dir.x;
									owner.input_buffer.y = _input_dir.y;
								}
								if ((move_direction.get_direction() != _input_dir.get_direction())) {
									owner.input_buffer.x = _input_dir.x;
									owner.input_buffer.y = _input_dir.y;
									timer = 1;
									owner.grid_data_function_move(owner.input_buffer);
								}
							}
							else {
								move_direction.x = _input_dir.x;
								move_direction.y = _input_dir.y;
							}
						}
						else {
							owner.input_buffer.x = 0;
							owner.input_buffer.y = 0;
						}
					}
				}
			}
			static template_player_action_modify = function(_instance) {														///	@func template_player_action_modify(instance)
				var _rewind = false;
				
				var _instance_push = new ElementData(_instance);
				with(_instance_push) {
					move_direction = variable_clone(other.move_direction);
					pos_source = new Vector2(owner.x, owner.y);
					pos_target = new Vector2(owner.x + move_direction.x * UNIT, owner.y + move_direction.y * UNIT);
					
					action_start = template_pushable_action_start;
					action_end = template_pushable_action_end;
				}
				
				_instance.grid_data_set(_instance_push);
			}
			static template_player_action_end = function() {																	///	@func template_player_action_end()
				if (!check_moving_pushable() or owner.move_while_pushable_moving) {
					if (!owner.continuous_movement and (abs(owner.input_buffer.x) ^^ abs(owner.input_buffer.y))) {
						if (!(instance_exists(owner.grab_object) and !owner.move_while_grab) and !owner.is_aiming()) {
							owner.grid_data_function_move(owner.input_buffer);
						}
						else {
							move_direction.x = owner.input_buffer.x;
							move_direction.y = owner.input_buffer.y;
						}
		
					}
				}
				owner.input_buffer.x = 0;
				owner.input_buffer.y = 0;
				
				if owner.continuous_movement owner.move_continuous();
				
				invalid_flag = false;
			}
			
		#endregion
		
	#endregion
}

function element_is_objective(_instance) {
	return ((_instance.object_index == obj_objective) or object_is_ancestor(_instance.object_index, obj_objective))
}