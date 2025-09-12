/// @description Setup

winner_clock = -1;
check_valid_instances = false;

restart = function() {
	if obj_main.is_winning() exit;
	transition_function(function() {
		audio_play_sfx(snd_reset);
		rewind_clear();
		room_restart();
	})
};

next_level = function() {
	goto_level(global.level_index + 1);
}

goto_level = function(_index) {
	global.level_target = _index;
	transition_function(
		function() {
			//	Going to the next level
			rewind_clear();
			if (global.level_target > global.level_number) {
				global.credits_trigger = true;
				global.current_platform.porting_activity_update("End");
				scene_change_room(rm_main_menu);
				
				global.undos_level = 0;
				global.level_index = 1;
			}
			
			else {				
				global.level_index = wrap(global.level_target, 1, global.level_number);
				global.level_index = global.level_target;
				
				var _next_room = level_get_room(global.level_index);
			
				if (room_exists(_next_room)) {
					scene_change_room(_next_room);
				}
				else {
					show_debug_message($"[Levels][ERROR] Tried to go to level {global.level_target}. Level {global.level_target} does not exist");
				}
				global.undos_level = 0;
			
				//	Achievements
				if (global.level_target == 1){	
				global.current_platform.porting_activity_update("Start");
				}
			}
		}
	);
}

check_objectives = function() {
	var _passed = true;
	var _number = 0;
	
	with(obj_objective) {
		_number++;
		if (objective_type == "container") {
			if !position_meeting(x, y, obj_pushable) {
				_passed = false;
				break;
			}
		}
		else if (objective_type == "destructable") {
			if (hp > 0) {
				_passed = false;
				break;
			}
		}
		else {
			_passed = false;
		}
	}
	if (_passed && (winner_clock <= 0) && !is_transitioning()) {
		
		winner_clock = 90;
	}
}

win = function() {
	winner_clock = 60;
}

is_winning = function() {
	return (winner_clock >= 0);
}

is_dying = function() { 
	return obj_player.dead;
}

update_move = function() {
	check_objectives();
	check_valid_instances = true;
}

pause_game = function() {
	if !(is_winning() or is_dying()) {
		if (!global.paused) global.paused = true;
		with(obj_nodeui_ingame) {
			node_change_active_canvas(1);
		}
	}
}

reset_achievements = function() {
	achievement_reset_all();
}

log_achievements = function() {
	achievement_log();
}