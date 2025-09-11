/// @description Update

fscreen_timer -= (fscreen_timer > 0);

if (keyboard_check_pressed(vk_f4) and (fscreen_timer <= 0)) {
	toggle_fulscreen();
	fscreen_timer = 15;
}

if fullscreen_toggle_var {
	global.settings_data.graphic.fullscreen = !FULLSCREEN;
	window_set_fullscreen(!FULLSCREEN);
	call_later(10, time_source_units_frames, function() {
		obj_window_manager.update(FULLSCREEN);
		window_center();
	});
	fullscreen_toggle_var = false;
}