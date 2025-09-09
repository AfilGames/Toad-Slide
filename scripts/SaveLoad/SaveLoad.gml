/*
	Script destinado a funções de Save e Load, além das funções que leem e escrevem arquivos por meio de Buffers 
	
	Region SYSTEM FUNCTIONS - Funções e variaveis utilizadas pelo sistema, evite altera-las
	
	Region SAVE BUFFERS - Funções que controlam o sistema de SAVE utilizando buffers
	
	Region LOAD BUFFERS - Funções que controlam o sistema de LOAD utilizando buffers
	
	Region COMMAND FUNCTIONS - Funções relacionadas ao sistema de comandos e chamadas de salvamentos
	
	Region UTILS - Funções que serão utilizadas pelo projeto	
*/

#region System functions
enum SAVE_COMMANDS
{
	GAME_DATA,
	SETTINGS
}

// Struct used to control SaveLoad system 
global.__save_control = {};
with (global.__save_control)
{
	save_buffer = -1;
	load_buffer = -1;
	
	save_id = noone;
	load_id = noone;
	
	perform_save = false;
	
	is_saving = false;
	is_loading = false;
	save_locked = false;
	save_loaded = false;
	
	save_queue = [];
	save_delay = 5 * 60; //Tempo que o sistema ira esperar antes de fazer um novo save
	save_delay_next_call = false;
	ignore_delay = false;
	active_gamedata_slot = 0;
	
	achievements = {};
}

///@function			__save_convert_data_to_json()
///@description			Return the save struct as a json string
function __save_convert_data_to_json(_savedata = global.save_data)
{
	var _data = variable_clone(_savedata);
	var _json_data = json_stringify(_data);
	
	return _json_data;
}

#endregion

#region SAVE BUFFERS

///@function			__save_clean_save_buffer()
///@description			Clean save buffer from memory
function __save_clean_save_buffer()
{
	if (global.__save_control.save_buffer != -1)
	{
		buffer_delete(global.__save_control.save_buffer);
		global.__save_control.save_buffer = -1;
	}
}

///@function					__save_write_buffer()
///@description					Call functions that write the buffers for specific OS's
function __save_write_buffer()
{
	// Update versions
	global.save_data.game_version = global.project_settings.game_version;
	global.save_data.save_version = global.project_settings.save_version;
	
	// Call save functions for current OS
	// Convert data to a json string
	var _data_to_write = __save_convert_data_to_json();

	__save_write_buffer_windows(_data_to_write);
}

///@function					__save_write_buffer_windows(_data_to_write)
///@description					Write buffer for windows platform
///@param {string}				Json string data to be written
function __save_write_buffer_windows(_data_to_write)
{
	// Create buffer
	//var _data_size = string_byte_length(_data_to_write);
	//global.__save_control.save_buffer = buffer_create(_data_size + 1, buffer_fixed, 1);
	
	// Write buffer with json string
	//buffer_write(global.__save_control.save_buffer, buffer_string, _data_to_write);
	
	// Call save function async
	//var _buffer_size = buffer_get_size(global.__save_control.save_buffer);
	//var _path = __sys_get_savepath_windows();
	//global.__save_control.save_id =  buffer_save_async(global.__save_control.save_buffer,_path, 0, _buffer_size);	

	show_debug_message($"chegou aqui o save {_data_to_write}")
	global.Save(_data_to_write);
	__save_finish_saving_procedure();
}

///@function					__save_finish_saving_procedure()
///@description					Finish saving procedure, reset variables and clean buffers

function __save_finish_saving_procedure()
{
	show_debug_message("Finishing save procedure");
	global.__save_control.is_saving = false;
	global.__save_control.ignore_delay = false;
	global.__save_control.save_delay_next_call = true;
													 	
	global.save_data.achievements = global.achiev_data;
	__save_clean_save_buffer();
	global.settings_loaded = true;
}

#endregion

#region LOAD BUFFERS

///@function				__save_clean_load_buffer()
///@description				Clean load buffer from memory
function __save_clean_load_buffer()
{
	if (global.__save_control.load_buffer != -1)
	{
		buffer_delete(global.__save_control.load_buffer);
		global.__save_control.load_buffer = -1;
	}
}

///@function					__save_load_buffer()
///@description					Call functions that load the buffers for specific OS's
function __save_load_buffer()
{	
	var _loading = false;
	_loading = __save_load_buffer_windows();
	
	if (_loading)
	{
		global.__save_control.is_loading = true;
	}
}

///@function					__save_load_buffer_windows()
///@description					Load save buffer for windows platform
function __save_load_buffer_windows()
{
	var _async_called = false;
	// Create buffer
	//global.__save_control.load_buffer = buffer_create(1, buffer_grow, 1);
	obj_save_load.LoadGame();
	
	show_debug_message("! Finishing load procedure");
	global.__save_control.is_loading = false;
	global.__save_control.save_loaded = true;
	return true;
}

///@function                    __save_process_loaded_data()
///@description                    Process a loaded save data json string
function __save_process_loaded_data(_json_data)
{
    var _parsed_data = json_parse(_json_data);

    // Update data for missing variables
    _parsed_data = struct_update_missing_variables(global.save_data, _parsed_data);
    
    // Upate slots
    var _slots = _parsed_data.save_slots;
    var _slots_len = array_length(_slots);
    
    for (var _i = 0; _i < _slots_len; _i++)
    {
        _parsed_data.save_slots[_i] = __gamedata_parse_loaded_data(_slots[_i], _parsed_data.save_version);    
    }
    
    // Set global variables
    global.save_data = variable_clone(_parsed_data);
    global.settings_data = variable_clone(global.save_data.settings);
    global.achiev_data = variable_clone(global.save_data.achievements);
    // Load input maps // DESATIVADO POR NÃO ESTAR SENDO USADO
	//var _input_map_len = array_length(global.settings_data.gameplay.input_maps);
    //for (var _i = 0; _i < _input_map_len; _i++)
    //{        
    //    var _mode_maps = global.settings_data.gameplay.input_maps[_i];
    //    var _new_maps = [],
	//		_new_map_changed = false;
		
	//	var _mode_maps_len = array_length(_mode_maps);
    //    for (var _j = 0; _j < _mode_maps_len; _j++)
    //    {
	//		_new_map_changed = true;
			
    //        var _loaded_map = _mode_maps[_j];
    //        var _button_map = new BuildInputMapButtons();
    //        _button_map.simple = variable_clone(_loaded_map.simple);
    //        _button_map.complex = variable_clone(_loaded_map.complex);
        
    //        _new_maps[_j] = variable_clone(_button_map);            
    //    }
    //    if (_new_map_changed)
	//	{
	//		show_debug_message(_new_maps);
	//		global.settings_data.gameplay.input_maps[_i] = variable_clone(_new_maps);
	//	}
    //}
    //global.input_maps = variable_clone(global.settings_data.gameplay.input_maps);
    
    //global.input_profile.__rebuild_on_load();
	
	save_select_gamedata_slot(0);
	global.settings_loaded = true;
	global.load_finished = true;
	
    show_debug_message("Save File was loaded");
	
	if(global.save_data.achievements == {})
	{
		global.save_data.achievements = global.achiev_data;
	}
	else
	{
		global.achiev_data = global.save_data.achievements;
	}
}

///@function					__save_finish_loading_procedure()
///@description					Finish loading procedure, reset variables and clean buffers
function __save_finish_loading_procedure()
{
	show_debug_message("Finishing load procedure");
	global.__save_control.is_loading = false;
	global.__save_control.save_loaded = true;
	global.load_finished = true;
	__save_clean_load_buffer();
}

#endregion

#region Command Functions

///@function				BuildSaveCommand(_code, _index)
///@description				Save commands struct to be queued
///@param {real} _code		Code of the desired save command using enum SAVE_COMMANDS
///@param {real} _index		Used for GameData commands to differenciate between save slots
function BuildSaveCommand(_code, _index, _data) constructor
{
	code = _code;
	index = _index;
	data = _data;
}

///@function				__save_push_command_to_queue(_command)
///@description				Push a save command to the saving queue and check for repeated commands
///@param {struct}			Save command struct
function __save_push_command_to_queue(_command)
{
	var _queue = global.__save_control.save_queue;
	var _queue_size = array_length(_queue);
	
	var _can_push = true;
	for (var _i = 0; _i < _queue_size; _i++)
	{
		var _command_queue = _queue[_i];
		if (_command.code == _command_queue.code)
		{
			_can_push = false;
			switch (_command.code)
			{
				case SAVE_COMMANDS.GAME_DATA:
					show_debug_message($"GameData save call ignored, command already in queue for index {_command.index}");	
					break;
				case SAVE_COMMANDS.SETTINGS:
					show_debug_message($"Settings save call ignored, command already in queue");
					break;
			}
			break;
		}
	}
	
	if (_can_push)
	{
		array_push(global.__save_control.save_queue, variable_clone(_command));
	}
	global.__save_control.perform_save = true;
}

///@function				__save_perform_commands()
///@description				Perform commands stored on the save queue
function __save_perform_commands()
{
	global.__save_control.is_saving = true;
	var _queue = global.__save_control.save_queue;
	var _queue_size = array_length(_queue);
	
	show_debug_message("Performing save commands");
	for (var _i = 0; _i < _queue_size; _i++)
	{
		var _command = _queue[_i];
		switch (_command.code)
		{
			case SAVE_COMMANDS.GAME_DATA:
				__savedata_update_save_slot(global.game_data, _command.index);
				break;
			
			case SAVE_COMMANDS.SETTINGS:
				__savedata_update_settings();
				break;
		}
	}
	 global.__save_control.save_queue = [];
}

#endregion

#region UTILS
///@function					save_settings()
///@description					Chama o comando para salvar as configurações (settings)
///@param {bool} [_force_save]	Se o save deve ignorar o delay
///@param {struct} [_data]		Struct que será salvo, puxa o global.settings_data como default
function save_settings(_force_save = false, _data = global.settings_data)
{
	
	global.__save_control.ignore_delay = _force_save;
	var _command = new BuildSaveCommand(SAVE_COMMANDS.SETTINGS, 0, _data);
	__save_push_command_to_queue(_command);
}

///@function					save_game()
///@description					Chama o comando para salvar os dados do jogo
///@param {bool} [_force_save]	Se o save deve ignorar o delay
///@param {struct} [_data]		Struct que será salvo, puxa o global.gamedata como default
///@param {real} [_save_slot]	Slot do save sendo salvo
function save_game(_force_save = false, _data = global.game_data, _save_slot = global.__save_control.active_gamedata_slot)
{
	global.__save_control.ignore_delay = _force_save;
	var _command = new BuildSaveCommand(SAVE_COMMANDS.GAME_DATA, _save_slot, _data);
	__save_push_command_to_queue(_command);
}

///@function					save_select_gamedata_slot(_slot)
///@description					Seleciona o slot de save indicado
///@param {real} _slot			Indice do slot desejado
function save_select_gamedata_slot(_slot)
{
	var _len = array_length(global.save_data.save_slots);
	if (_slot < _len)
	{
		var _save_slot = global.save_data.save_slots[_slot];
		if (_save_slot != noone)
		{
			global.game_data = variable_clone(_save_slot);
			global.__save_control.gamedata_slot = _slot;
			show_debug_message($"Save slot was set to {_slot}");
		}
	}
}

///@function					save_create_gamedata_slot()
///@description					Cria um novo slot de save e retorna o index do mesmo
function save_create_gamedata_slot()
{
	var _gamedata = new BuildGameData();
	var _array_index = array_length(global.save_data.save_slots);
	
	array_push(global.save_data.save_slots, variable_clone(_gamedata));
	return _array_index;
}

#endregion

