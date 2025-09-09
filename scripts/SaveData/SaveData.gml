global.save_data = {};

///@function					BuildInternalSaveData()
///@description					SaveData parent struct 
function BuildInternalSaveData() constructor
{ 
	game_version = "";
	save_version = "";	
	save_version_porting = 0;
	settings = {};
	achievements = {};
	
	save_slots = [];
}

///@function					__savedata_update_settings(_settings)
///@description					Update the settings struct on the SaveData with the ingame SettingsData
///@param {struct} [_settings]	Settings data struct
function __savedata_update_settings(_settings = global.settings_data)
{
	show_debug_message("Updating settings save");
	
	global.save_data.settings = variable_clone(_settings);
	
	// DESATIVADO POR NÃO ESTAR SENDO USADO
	//global.save_data.settings.gameplay.input_maps = variable_clone(global.input_maps);
}

///@function					__savedata_update_save_slot(_settings)
///@description					Update a save slot struct on the SaveData with the ingame GameData
///@param {struct} [_gamedata]	GameData struct
///@param {real} [_slot]		GameData slot index
function __savedata_update_save_slot(_gamedata = global.game_data, _slot = global.__save_control.gamedata_slot)
{
	show_debug_message("Updating game data save");
	game_version = global.project_settings.game_version;
	save_version = global.project_settings.save_version;
	global.save_data.save_version_porting +=1;
		
	global.save_data.save_slots[_slot] = variable_clone(_gamedata);
	global.save_data.achievements = variable_clone(global.achiev_data);
}

///@function					build_empty_save_data(_settings)
///@description					Retorna o struct de SaveData vazio
function build_empty_save_data()
{
	var _save_data = new BuildInternalSaveData();
	_save_data.settings = new BuildSettingsData();
	_save_data.achievements = new BuildAchievData();
	
	_save_data.game_version = variable_clone(global.project_settings.game_version);
	_save_data.save_version = variable_clone(global.project_settings.save_version);
	
	return variable_clone(_save_data);
}

#region START
global.save_data = build_empty_save_data();
#endregion

