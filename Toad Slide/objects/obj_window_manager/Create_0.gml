/// @description Setup

fscreen_timer = 15;

pixel_perfect = false;

update = function(_force_fullscreen = false) {
	
	if !view_get_visible(CURRENT_VIEWPORT)
		view_set_visible(CURRENT_VIEWPORT, true);
	
	global.settings_data.graphic.resolution = wrap(floor(global.settings_data.graphic.resolution), 1, (DISPLAY_HEIGHT div DEF_CAMERA_HEIGHT)); 
	
	if !view_enabled
		view_enabled = true;
	
	if ON_BROWSER {
		window_set_size(browser_width, browser_height);
		
		global.camera_target_size.width = DEF_CAMERA_WIDTH;
		global.camera_target_size.height = DEF_CAMERA_HEIGHT;
		
	}
	else {
		global.camera_target_size.width = DEF_CAMERA_WIDTH;
		global.camera_target_size.height = DEF_CAMERA_HEIGHT;
			
		if !(FULLSCREEN || _force_fullscreen) {
			window_set_size(DEF_CAMERA_WIDTH * global.settings_data.graphic.resolution, DEF_CAMERA_HEIGHT * global.settings_data.graphic.resolution);
		}
		else {
			var _scale = DISPLAY_HEIGHT / DEF_CAMERA_HEIGHT;
			var _width = DEF_CAMERA_WIDTH * _scale;
			var _height = DISPLAY_HEIGHT;
			
			window_set_size(_width, _height);
		}
	}
	
	var _scale = DISPLAY_HEIGHT / DEF_CAMERA_HEIGHT;
	var _width = DEF_CAMERA_WIDTH * _scale;
	var _height = DISPLAY_HEIGHT;
	
	if !FULLSCREEN {
		_width = WINDOW_WIDTH;
		_height = WINDOW_HEIGHT;
	}
	
	view_set_wport(CURRENT_VIEWPORT, _width);
	view_set_hport(CURRENT_VIEWPORT, _height);
	
	var _sw = CAMERA_WIDTH;
	var _sh = CAMERA_HEIGHT;
	
	if (!pixel_perfect and ((WINDOW_WIDTH > 0) && (WINDOW_WIDTH != infinity))) {
		_sw = WINDOW_WIDTH;
		_sh = WINDOW_HEIGHT;
	}
	
	surface_resize(application_surface, _sw, _sh);
	
	display_set_gui_size(global.camera_target_size.width * 1, global.camera_target_size.height * 1);
	
	call_later(1, time_source_units_frames, function() { window_center() });
}

fullscreen_toggle_var = false;

set_fullscreen = function(_set = noone) {
	
	if (_set == noone) _set = !FULLSCREEN;
	
	if (_set != FULLSCREEN) {
		fullscreen_toggle_var = true;
	}
}
	
toggle_fulscreen = function() {
	fullscreen_toggle_var = true;
}