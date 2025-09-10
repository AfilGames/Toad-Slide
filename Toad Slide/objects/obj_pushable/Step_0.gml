/// @description Update

if global.paused {
	if audio_is_playing(slide_sound) {
		audio_pause_sound(slide_sound);
	}
}
else {
	if audio_is_paused(slide_sound) {
		audio_resume_sound(slide_sound);
	}
}

//	Timers
anim_offset.x = lerp(anim_offset.x, 0, .18);
anim_offset.y = lerp(anim_offset.y, 0, .18);
anim_tilt = lerp(anim_tilt, 0, .2);
anim_height = lerp(anim_height, 0, .17);
anim_invalid = lerp(anim_invalid, 0, .2);

anim_linear_offset.x = approach(anim_linear_offset.x, 0, UNIT / move_interval);
anim_linear_offset.y = approach(anim_linear_offset.y, 0, UNIT / move_interval);

grid_data_update();

image_index = sprite_get_animated_image_index(sprite_index, (x + y) * 5);

var _objective = instance_position(x, y, obj_objective);
var _player = position_meeting(x, y, obj_player);

var _offset_zero = point_distance(0, 0, anim_offset.x, anim_offset.y) < UNIT * .25;

if (((instance_exists(_objective) and (_objective.objective_type == "container") and !is_moving()) or _player) and _offset_zero) {
	image_alpha *= .66;
}
else {
	image_alpha = 1;
}