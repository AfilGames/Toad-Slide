global.settings_data = {};

///@function		BuildSettingsData();
///@description		Constrói um novo struct de configurações vazio
function BuildSettingsData() constructor
{
	audio = {};
	with (audio)
	{
		volume_main = 1;
		volume_sfx = 1;
		volume_music = 1;
	}
	
	graphic = {};
	with (graphic)
	{
		resolution = 2;
		fullscreen = false;
	}
	
	gameplay = {};
	with (gameplay)
	{
		language = LANGUAGES.ENGLISH;
		screenshake = true;
		cursor_speed = 200;
		input_maps = array_create(INPUT_MODE.LENGTH, noone);
		default_mode_map = array_create(INPUT_MODE.LENGTH, 0);
	}
}

function __settings_process_data()
{	
	settings_set_resolution(global.settings_data.graphic.resolution);
	window_set_fullscreen(global.settings_data.graphic.fullscreen);	
}

#region Cursor Speed


#endregion

#region Utility

// LANGUAGE
function settings_get_language()
{
	return global.settings_data.gameplay.language;
}

function settings_set_language(_language)
{
	global.settings_data.gameplay.language = _language;
	node_update_all_canvas();
	
	save_settings();
}

function settings_alternate_language(_dir = 1)
{
	global.settings_data.gameplay.language += _dir;
	global.settings_data.gameplay.language = qwrap(global.settings_data.gameplay.language, 0, LANGUAGES.LENGTH -1);
	save_settings();
}

// WINDOW
function settings_set_fullscreen()
{
	global.settings_data.graphic.fullscreen = !global.settings_data.graphic.fullscreen;
	if (global.settings_data.graphic.fullscreen)
	{
		window_set_fullscreen(true);
	}
	else
	{
		window_set_fullscreen(false);
		settings_set_resolution(global.settings_data.graphic.resolution);
	}
	save_settings();
}

function settings_set_resolution(_ind)
{
	global.settings_data.graphic.resolution = _ind;
	var _res = new Vector2(DEF_CAMERA_WIDTH * global.settings_data.graphic.resolution, DEF_CAMERA_HEIGHT * global.settings_data.graphic.resolution);
	
	window_set_size(_res.x, _res.y);
	view_set_wport(0, WINDOW_WIDTH);
	view_set_hport(0, WINDOW_HEIGHT);	
		
	window_center();	
	
	save_settings();
}

function settings_alternate_resolution(_dir = 1)
{
	global.settings_data.graphic.resolution += _dir;
	global.settings_data.graphic.resolution = qwrap(global.settings_data.graphic.resolution, 0, array_length(global.window_manager.resolutions) -1);
	settings_set_resolution(global.settings_data.graphic.resolution);
}

// Cursor
function settings_set_cursor_speed(_speed)
{
	global.settings_data.gameplay.cursor_speed = _speed;	
	global.settings_data.gameplay.cursor_speed = clamp(global.settings_data.gameplay.cursor_speed, 100, 400);
	
	save_settings();
}

#endregion

#region START
global.settings_data = new BuildSettingsData();
#endregion


