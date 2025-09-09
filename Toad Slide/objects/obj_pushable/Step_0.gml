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
anim_offset.x = lerp(anim_offset.x, 0, .3);
anim_offset.y = lerp(anim_offset.y, 0, .3);
anim_tilt = lerp(anim_tilt, 0, .2);
anim_height = lerp(anim_height, 0, .17);
anim_invalid = lerp(anim_invalid, 0, .2);

anim_linear_offset.x = approach(anim_linear_offset.x, 0, UNIT / move_interval);
anim_linear_offset.y = approach(anim_linear_offset.y, 0, UNIT / move_interval);

grid_data_update();