global.game_data = {};

///@function		BuildGameData();
///@description		Constrói um novo struct de game data
function BuildGameData() constructor
{
	slot_name = "";
	
	level_unlock = 1;
}

///@function		__gamedata_parse_loaded_data();
///@description		Converte os dados recebidos pelo loading do save para a estrutura ingame
function __gamedata_parse_loaded_data(_data)
{
	var _empty_gamedata	= global.game_data;
	// Check the loaded data for missing variables using the empty data structure as reference
	_data = struct_update_missing_variables(_empty_gamedata, _data);
	
	return _data;
}

#region START
global.game_data = new BuildGameData();
#endregion

