#region Variables

	global.rewind_queue = [];
	
	global.rewind_object_affected = [
		obj_player,
		obj_pushable,
		obj_destructable,
		obj_hole,
		obj_objective_destructable,
		obj_collectable,
		obj_barrier
	];
	
	global.rewind_variables_saved = [
		"x",
		"y",
		"deactivated",
		"hp"
	]
	
#endregion

#region Structures
	
	function RewindInstanceData(_instance) constructor {
		
		instance = _instance;
		
		//	Setting The Variables
		for (var i = 0; i < array_length(global.rewind_variables_saved); i++) {
			var _name = global.rewind_variables_saved[i];
			
			self[$ _name] = _instance[$ _name];
		}
		
		toString = function() {
			var _string = "\n==========\n";
			for (var i = 0; i < array_length(global.rewind_variables_saved); i++) {
				var _var_name = global.rewind_variables_saved[i];
				_string += $"({_var_name}: {instance[$ _var_name]})";
			}
			_string += $"\n==========";
			return _string;
		}
	}
	
	function rewind_point_create() {
		
		var _instances = [];
		
		//	Through all objects
		for (var i = 0; i < array_length(global.rewind_object_affected); i++) {
			var _obj = global.rewind_object_affected[i];
			
			with(_obj) {
				var _data = new RewindInstanceData(id);
				array_push(_instances, _data);
			}
		}
		
		return _instances;
	}
	
#endregion

#region Queue Functions
	
	function rewind_save(_rewind = rewind_point_create(), _force = false) {
		var _valid = true;
		with(obj_pushable) {
			if !grid_data.pos_source.compare(grid_data.pos_target) {
				_valid = false;
				break;
			}
		}
		
		if (_valid or _force) {
			array_push(global.rewind_queue, _rewind);
			if global.debug.log_rewind show_debug_message($"[Rewind] Pushed To Queue! Size: {array_length(global.rewind_queue)}");
		}
		else {
			if global.debug.log_rewind show_debug_message($"[Rewind][ERROR] Cannot save while the pushable is moving");
		}
	}
	
	function rewind_clear() {
		for (var i = 0; i < array_length(global.rewind_queue); i++) {
			delete global.rewind_queue[i];
		}
		delete global.rewind_queue;
		global.rewind_queue = [];
		
		if global.debug.log_rewind show_debug_message("[Rewind] Cleared");
	}
	
#endregion

#region Rewinding
	
	function rewind_instances() {
		if (obj_main.is_winning() or obj_main.is_dying()) exit;
		
		var _rewind = array_last(global.rewind_queue);
		var _same_values = true;
		
		for (var i = 0; i < array_length(_rewind); i++) {
			var _instance_data = _rewind[i];
		
			with(_instance_data.instance) {
				if (audio_exists(slide_sound) and audio_is_playing(slide_sound)) {
					audio_stop_sound(slide_sound);
				}
				
				for (var j = 0; j < array_length(global.rewind_variables_saved); j++) {
					var _var_name = global.rewind_variables_saved[j];
					
					//show_message($"{_var_name}: {_instance_data[$ _var_name]}");
					if _same_values {
						if (_instance_data.instance[$ _var_name] != _instance_data[$ _var_name]) {
							_same_values = false;
						}
					}
					
					_instance_data.instance[$ _var_name] = _instance_data[$ _var_name];
				}
				
				update_depth();
				
				var _oldpos = variable_clone(grid_data.pos_source);
				grid_data_reset();
				
				_oldpos.x -= x;
				_oldpos.y -= y;
				
				anim_offset.x = _oldpos.x;
				anim_offset.y = _oldpos.y;
				anim_invalid = .5;
			}
		}
		
		if (array_length(global.rewind_queue) > 1) {
			array_pop(global.rewind_queue);
			if global.debug.log_rewind show_debug_message($"[Rewind] Popped From Queue! Size: {array_length(global.rewind_queue)}");
			
			audio_play_sfx(snd_undo);
		}
		else {
			audio_play_sfx(snd_undo);
			if global.debug.log_rewind show_debug_message($"[Rewind][ERROR] Queue is empty!")
		};
	}

#endregion