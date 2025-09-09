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
		
		//switch(global.camera_target_size.mode) {
			
		//	case DYNAMIC_VIEW.PRESERVE_WIDTH: {
		//		var _scale = browser_width / DEF_CAMERA_WIDTH;
		//		global.camera_target_size.height = browser_height / _scale;
		//	} break;
		//	case DYNAMIC_VIEW.PRESERVE_HEIGHT: {
		//		var _scale = browser_height / DEF_CAMERA_HEIGHT;
		//		global.camera_target_size.width = browser_width / _scale;
		//	} break;
		//}
	}
	else {
		if !(FULLSCREEN || _force_fullscreen) {
			window_set_size(DEF_CAMERA_WIDTH * global.settings_data.graphic.resolution, DEF_CAMERA_HEIGHT * global.settings_data.graphic.resolution);
			global.camera_target_size.width = DEF_CAMERA_WIDTH;
			global.camera_target_size.height = DEF_CAMERA_HEIGHT;
		}
		else {
			if !FULLSCREEN window_set_size(DISPLAY_WIDTH, DISPLAY_HEIGHT);
		
			global.camera_target_size.width = DEF_CAMERA_WIDTH;
			global.camera_target_size.height = DEF_CAMERA_HEIGHT;
		
			//switch(global.camera_target_size.mode) {
			
			//	case DYNAMIC_VIEW.PRESERVE_WIDTH: {
			//		var _scale = DISPLAY_WIDTH / DEF_CAMERA_WIDTH;
			//		global.camera_target_size.height = DISPLAY_HEIGHT / _scale;
			//	} break;
			//	case DYNAMIC_VIEW.PRESERVE_HEIGHT: {
			//		var _scale = DISPLAY_HEIGHT / DEF_CAMERA_HEIGHT;
			//		global.camera_target_size.width = DISPLAY_WIDTH / _scale;
			//	} break;
			//}
		}
	}
	
	var _scale = WINDOW_HEIGHT / DEF_CAMERA_HEIGHT;
	var _width = DEF_CAMERA_WIDTH * _scale;
	
	view_set_wport(CURRENT_VIEWPORT, _width);
	view_set_hport(CURRENT_VIEWPORT, WINDOW_HEIGHT);
	
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