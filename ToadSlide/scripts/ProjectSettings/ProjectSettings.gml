// Controle de versão, arquivos e outras definições do projeto

enum GAME_MODE 
{
	GAMEPLAY,
	LEVEL_MAKER,
	LEVEL_TESTER
}

global.project_settings = {};
with (global.project_settings)
{
	game_version = ""; // "1.0.0.4";
	save_version = "0.1";
	game_title = string_letters(game_display_name);
	
	// Save related
	save_file_name = $"{game_title}";
	save_folder_name = string_letters(game_display_name);
	
	menu_room = rm_main_menu;
	
	// Splash Screens
	splash_screen = [spr_afil_logo];
	
	resolution = new Vector2(640, 360);
	
	skip_splash = false;
	game_mode = GAME_MODE.GAMEPLAY;
}

global.system_initialized = false;

function __instantiate_system_objects()
{
	settings_set_language(__language_get_system_language());
	instance_create_depth(0,0,0,obj_save_load_manager);	
	instance_create_depth(0,0,0,obj_input_manager);	
	instance_create_depth(0,0,0,obj_audio_manager);	
	global.system_initialized = true;
}

function __sys_transition_first_scene()
{
	var _room = rm_splash_screen;
	switch (global.project_settings.game_mode)
	{
		case GAME_MODE.GAMEPLAY:
			_room = rm_splash_screen;
			if (global.project_settings.skip_splash)
			{
				_room = rm_main_menu;	
			}
			break;
	}
	
	room_goto(_room);
}

///@function		__sys_get_savepath_windows()
///@description		Return the savepath on windows
function __sys_get_savepath_windows()
{
	var _game_title = global.project_settings.game_title;
	var _file_name = global.project_settings.save_file_name;
	var _path = _file_name //$"C:\\Users\\{environment_get_variable("USERNAME")}\\AppData\\Local\\AfilGames\\{_game_title}\\{_file_name}";
	return _path;
}

