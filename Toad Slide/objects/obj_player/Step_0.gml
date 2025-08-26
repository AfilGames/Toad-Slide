/// @description Update

if global.paused exit;

death_sequence();

anim_offset.x = lerp(anim_offset.x, 0, .2);
anim_offset.y = lerp(anim_offset.y, 0, .2);
anim_tilt = lerp(anim_tilt, 0, .2);
anim_height = lerp(anim_height, 0, .17);
anim_invalid = lerp(anim_invalid, 0, .2);

anim_linear_offset.x = approach(anim_linear_offset.x, 0, UNIT / move_interval);
anim_linear_offset.y = approach(anim_linear_offset.y, 0, UNIT / move_interval);

if instance_exists(grab_object) {
	grab_object.x = x;
	grab_object.y = y;
}

grab_clock -= (grab_clock > 0);

if ((grab_clock <= 0) and instance_exists(grab_object) and !grab_object.deactivated) {
	grab_object.deactivated = true;
}

var _input_dir = new Vector2(0, 0);
if (!is_transitioning() and (grab_clock <= 0)) {
	if !(obj_main.is_winning() or obj_main.is_dying()) {
		if (grid_data.timer <= 0) _input_dir = input_check_movement_pressed();
	}
	else if !obj_main.is_dying() {
		if (sprite_index != spr_player_happy) {
			sprite_index = spr_player_happy;
			time_offset_celebration = current_time;
			
			if (global.game_data.level_unlock <= global.level_index) global.game_data.level_unlock = global.level_index + 1;
			audio_play_sfx(snd_win);
			save_game();
		}
	}
}

if (abs(_input_dir.x) ^^ abs(_input_dir.y)) {
	input_buffer.x = _input_dir.x;
	input_buffer.y = _input_dir.y;
	grid_data_function_move(input_buffer);
}

var _idle_sprite = spr_player_idle_front;
if (grid_data.move_direction.x != 0) {
	_idle_sprite = spr_player_idle_side;
}
else if (grid_data.move_direction.y < 0) {
	_idle_sprite = spr_player_idle_back;
}

var _kick_sprite = spr_player_kick_front;
if (grid_data.move_direction.x != 0) {
	_kick_sprite = spr_player_kick_site;
}
else if (grid_data.move_direction.y < 0) {
	_kick_sprite = spr_player_kick_back;
}

var _kick = (input_check_pressed("game_kick") and !(obj_main.is_winning() or obj_main.is_dying() or (grab_clock > 0)) and array_contains(interact_type, "dedicated_input"));
if _kick {
	interact();
}

if ((sprite_index == _kick_sprite) and animation_has_ended()) {
	sprite_index = _idle_sprite;
	image_index = 0;
}

grid_data_update();