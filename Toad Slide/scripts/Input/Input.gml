/*
	Funções e structs para controle de Input
*/

enum INPUT_MODE {
	KEYBOARD,
	MOUSE,
	XBOX,
	PS4,
	PS5,
	SWITCH,
	LENGTH

}

enum INPUT_METHOD
{
	ACTIVE,
	PRESSED,
	RELEASED
}

global.input_profile = {};
global.input_maps = array_create(6, noone);

#region INPUT PROFILE

///@function	BuildInputProfileGamepadModule()
///@desc		Struct usado para controlar o gamepad
function BuildInputProfileGamepadModule() constructor
{
	connected = false;
	max_number = 8;
	pads = array_create(max_number, noone);
}

///@function		BuildInputProfile()
///@desc			Struct usado para controlar o sistema de input
function BuildInputProfile() constructor
{
	mode = INPUT_MODE.KEYBOARD;
	active_map = 0;
	map = new BuildInputMap();	
	gamepad = new BuildInputProfileGamepadModule();
	
	event_map = {};
	event_names = [];
	
	__mouse_kb_as_one = true;
	__lock_input = false;
	__hard_lock = false;
	
	static __rebuild_on_load = function()
	{
		active_map = global.settings_data.gameplay.default_mode_map[mode];
		input_swap_mode(mode);
	}	
}

#endregion

#region GAMEPAD CONTROL

///@function			input_get_main_gamepad()
///@description			Retorna o gamepad conectado no primeiro slot
function input_get_main_gamepad()
{
	var _pad = global.pad_by_player[0];
	return _pad;
}

///@function			__input_get_free_gamepad_ind()
///@description			Retorna o índice do primeiro slot livre de gamepad
function __input_get_free_gamepad_ind()
{
	var _gamepad_module = global.input_profile.gamepad;
	var _len = array_length(_gamepad_module.pads);
	var _pad_ind = -1;
	for (var _i = 0; _i < _len; _i++)
	{
		if (_gamepad_module.pads[_i] == noone)
		{
			_pad_ind = _i;
			break;
		}
	}
	
	return _pad_ind;
}

///@function			__input_connect_gamepad(_pad)
///@description			Conecta um gamepad no primeiro slot livre
///@param {real} _pad	Índice do gamepad a ser desconectado
function __input_connect_gamepad(_pad)
{
	var _gamepad_module = global.input_profile.gamepad;
	var _pad_ind = __input_get_free_gamepad_ind();
	
	if (_pad_ind != -1)
	{
		_gamepad_module.pads[_pad_ind] = variable_clone(_pad);
		_gamepad_module.connected = true;
		__input_set_gamepad_type();
	}
	else
	{
		show_debug_message("Max gamepad amount reached");	
	}
}

///@function			__input_disconnect_gamepad(_pad)
///@description			Desconecta um gamepad do sistema de input
///@param {real} _pad	Índice do gamepad a ser desconectado
function __input_disconnect_gamepad(_pad)
{
	var _gamepad_module = global.input_profile.gamepad;
	var _pad_connected = array_contains(_gamepad_module.pads, _pad);
	
	if (_pad_connected)
	{
		var _pad_array_ind = array_get_index(_gamepad_module.pads, _pad);
		_gamepad_module.pads[_pad_array_ind] = noone;
		//array_delete(_gamepad_module.pads, _pad_array_ind, 1);
		//if (array_length(_gamepad_module.pads) < _gamepad_module.max_number) array_push(_gamepad_module.pads, _pad);
		if (_pad_array_ind == 0)
		{
			_gamepad_module.connected = false;	
		}
		
		if (os_type == os_windows && _gamepad_module.pads[0] == noone)
		{
			input_swap_mode(INPUT_MODE.KEYBOARD);
		}
	}
}

///@function		__input_set_gamepad_type()
///@description		Define o tipo de input com base no gamepad conectado e o sistema atual
function __input_set_gamepad_type()
{
	var _gamepad = input_get_main_gamepad();
	var _gamepad_info = gamepad_get_description(_gamepad);

	switch (os_type)
	{	
		case os_ps4:
			input_swap_mode(INPUT_MODE.PS4);
			break;
			
		case os_ps5:
			input_swap_mode(INPUT_MODE.PS5);
			break;
			
		case os_switch:
			input_swap_mode(INPUT_MODE.SWITCH);
			break;
			
		case os_xboxone:
		case os_xboxseriesxs:
			input_swap_mode(INPUT_MODE.XBOX);
			break;
			
		default: //PC
			
			if (_gamepad != -1 && string_count("SONY",string_upper(_gamepad_info)) > 0)
			{
				input_swap_mode(INPUT_MODE.PS4);
			} else {
				input_swap_mode(INPUT_MODE.XBOX);
			}
		break;
	}	
}

#endregion

#region MAP FUNCTIONS

///@function		__input_define_new_default_map
///@description		Define um input map padrão quando não houver um para o modo atual
function __input_define_new_default_map(_mode = global.input_profile.mode)
{
	var _map = noone;
	if (global.input_maps[_mode] == noone) global.input_maps[_mode] = [];
	
	switch (_mode)
	{
		case INPUT_MODE.KEYBOARD:
			_map = build_default_input_map_keyboard();
			break;
		case INPUT_MODE.MOUSE:
			_map = build_default_input_map_mouse();
			break;
		case INPUT_MODE.PS4:
			_map = build_default_input_map_gamepad();
			break;
		case INPUT_MODE.PS5:
			_map = build_default_input_map_gamepad();
			break;
		case INPUT_MODE.XBOX:
			_map = build_default_input_map_gamepad();
			break;
		case INPUT_MODE.SWITCH:
			_map = build_default_input_map_gamepad();
			break;
	}
	
	array_push(global.input_maps[_mode], variable_clone(_map));
	
	return array_length(global.input_maps[_mode]) - 1;
}	

#endregion

#region INPUT EVENT

function InputEvent(_event_functions, _mode = noone) constructor
{
	mode = _mode;
	event_functions = _event_functions;
}

function input_bind_event(_input_name, _event_array, _mode = noone)
{
	if (!struct_exists(global.input_profile.event_map, _input_name))
	{
		global.input_profile.event_map[$ _input_name] = [];
		array_push(global.input_profile.event_names, _input_name);
	}
	array_push(global.input_profile.event_map[$ _input_name], new InputEvent(_event_array, _mode));	
}

function __input_execute_events(_input_name, _mode = global.input_profile.mode)
{
	var _event_names = global.input_profile.event_names,
		_event_map = global.input_profile.event_map;
		
	if (!array_contains(_event_names, _input_name))
	{
		return;	
	}
	
	var _input_events =_event_map[$ _input_name]; 
	for (var _i = 0; _i < array_length(_input_events); _i++)
	{
		var _event = _input_events[_i];
		for (var _j = 0; _j < array_length(_event.event_functions); _j++)
		{			
			var _event_funct = _event.event_functions[_j];
			if (_mode != _event.mode) break;
			
			if (is_callable(_event_funct)) _event_funct();
		}
	}
}

#endregion

#region UTILS

///@function			input_swap_mode(_mode)
///@description			Troca o modo de input atual
///@param {real} _mode	Modo a ser definido utilizando o enum INPUT_MODE
function input_swap_mode(_mode)
{
	global.input_profile.mode = _mode;
	global.input_profile.active_map = global.settings_data.gameplay.default_mode_map[_mode];
	
	if (global.input_maps[_mode] == noone)
	{
		__input_define_new_default_map(_mode);
	}	

	global.input_profile.map.button_map = global.input_maps[_mode][global.input_profile.active_map];

	node_update_all_canvas();
}

///@function			input_map_push_new_map(_mode)
///@description			Adiciona um novo mapa de botões para o modo atual
function input_map_push_new_map()
{
	var _map_ind = __input_define_new_default_map();
	var _mode = global.input_profile.mode;
	
	global.input_profile.active_map = _map_ind;
	global.input_profile.map.reload_active_button_map();

	if (instance_exists(obj_input_manager))
	{
		obj_input_manager.update_input_arrays();	
	}
	
	show_debug_message($"New input map pushed to index {_map_ind} for mode {_mode}");
}

///@function			input_swap_active_map(_mode)
///@description			Troca o mapa de inputs ativo dentro do modo atual de input
///@param {real} _ind	Index do mapa a ser utilizado
function input_map_swap_active(_ind)
{
	var _mode = global.input_profile.mode;
	if (array_length(global.input_maps[_mode]) < _ind)
	{
		show_debug_message($"Input map for mode {_mode} doesnt have an index {_ind}");
		exit;
	}
	
	global.input_profile.active_map = _ind;
	global.input_profile.map.reload_active_button_map();

	if (instance_exists(obj_input_manager))
	{
		obj_input_manager.update_input_arrays();	
	}
	
	show_debug_message($"Active map set to {_ind}");
}

///@function			input_map_alternate_active(_mode)
///@description			Alterna o mapa de inputs ativo dentro do modo atual de input
///@param {real} _dir	Direção que sera alternado, +1 ou -1
function input_map_alternate_active(_dir)
{
	var _mode = global.input_profile.mode;
	var _len = array_length(global.input_maps[_mode])
	
	global.input_profile.active_map += _dir;
	global.input_profile.active_map = qwrap(global.input_profile.active_map, 0, _len - 1);
	global.input_profile.map.reload_active_button_map();

	if (instance_exists(obj_input_manager))
	{
		obj_input_manager.update_input_arrays();	
	}
	
	show_debug_message($"Active map set to {global.input_profile.active_map}");
}

///@function				input_map_define_default_active(_mode)
///@description				Define um novo index padrão para o mapa de botões do modo atual
///@param {real} _ind		Index do mapa a ser utilizado
///@param {real} [_mode]	Index do modo
function input_map_define_default_active(_ind = global.input_profile.active_map, _mode = global.input_profile.mode)
{
	if (array_length(global.input_maps[_mode]) < _ind)
	{
		show_debug_message($"Input map for mode {_mode} doesnt have an index {_ind}");
		exit;
	}	
	global.settings_data.gameplay.default_mode_map[_mode] = _ind;
	
	show_debug_message($"Default active map for mode {_mode} set to {_ind}");
}

///@function				input_map_delete_index(_mode)
///@description				Deleta um index dos mapas do modo especificado
///@param {real} [_ind]		Index do mapa a ser deletado
///@param {real} [_mode]	Index do modo
function input_map_delete_index(_ind = global.input_profile.active_map, _mode = global.input_profile.mode)
{
	var _mode_maps_len = array_length(global.input_maps[_mode]);
	if (_mode_maps_len < _ind)
	{
		show_debug_message($"Input map for mode {_mode} doesnt have an index {_ind}");
		return;
	}	
	else if (_mode_maps_len <= 1)
	{
		show_debug_message($"You cant delete the last map");
		return;	
	}
	
	array_delete(global.input_maps[_mode], _ind, 1);
	var _mode_maps_len = array_length(global.input_maps[_mode]);
	
	if (global.input_profile.active_map == _ind && _ind > _mode_maps_len - 1)
	{
		global.input_profile.active_map -= 1;
		if (global.settings_data.gameplay.default_mode_map[_mode] == _ind)
		{
			input_define_default_active_map(global.input_profile.active_map, _mode);
		}
	}
	
	show_debug_message($"Map {_ind} was deleted for mode {_mode} and active map set to {global.input_profile.active_map}");
}

///@function			input_compare_mode(_mode)
///@description			Compara o modo recebido como parametro com o modo ativo e retorna verdadeiro ou falso
///@param {real} _mode	Índice do modo a ser comparado utilziando o enum INPUT_MODE
///@return {bool}		Se o modo recebido é igual ou não ao ativo
function input_compare_mode(_mode)
{
	return global.input_profile.mode == _mode;
}

///@function			input_is_gamepad_mode(_mode)
///@description			Checa se o modo de input está em algum gamepad
///@return {bool}		Retorna se o modo gamepad esta ativo ou não
function input_is_gamepad_mode()
{
	return input_compare_mode(INPUT_MODE.PS4) || input_compare_mode(INPUT_MODE.PS5) || input_compare_mode(INPUT_MODE.XBOX) || input_compare_mode(INPUT_MODE.SWITCH);
}

///@function						input_map_swap_button(_button, _new_input)
///@description						Tenta trocar o input de certo botão definido no input map ativo e retorna se foi possível
///@param {real} _button			Nome do botão a ser trocado em string
///@param {constant} _new_input		Novo input para substituir o antigo em Constant (vk, ord, gp)
///@return {bool}					Se a troca foi completa
function input_map_swap_button(_button, _new_input)
{
	var _swap = global.input_profile.map.set_input(_button, _new_input);
	
	if (instance_exists(obj_input_manager))
	{
		obj_input_manager.update_input_arrays();	
	}
	
	return _swap;
}

function input_get_map(_mode, _profile = global.settings_data.gameplay.default_mode_map[_mode])
{
	var _map = global.input_maps[_mode];	
	if (_map == noone)
	{
		__input_define_new_default_map(_mode);
		_map = global.input_maps[_mode];
	}
	
	return _map[_profile];
}

function input_lock_all(_hard_lock = false)
{
	if (_hard_lock) global.input_profile.__hard_lock = _hard_lock;
	global.input_profile.__lock_input = true;	
}

function input_unlock_all(_hard_lock = false)
{
	if (global.input_profile.__hard_lock && !_hard_lock) return;
	
	global.input_profile.__hard_lock = false;
	global.input_profile.__lock_input = false;	
}

#region INPUT CHECKERS

///@function					__input_internal_input_check(_button, _method)
///@description					Internal function to check an input from the input manager object
///@param {string} _button		Button name as a string
///@param {string} _method		Checking method to be used (Pressed, Active, Released)
function __input_internal_input_check(_button, _method)
{
	if (global.input_profile.__lock_input)
	{
		return 0;
	}
	var _input_check = 0;	
	
	var _input_manager = obj_input_manager;
	if (instance_exists(_input_manager))
	{
		_input_check = _input_manager.__check_input_manual(_method, _button);			
	}
	return _input_check;
}	

///@function					input_check(_button)
///@description					Check if an button is held down or not
///@param {string} _button		Button name as a string
function input_check(_button)
{
	var _input_check = __input_internal_input_check(_button, INPUT_METHOD.ACTIVE);
	return _input_check;
}

///@function					input_check_pressed(_button)
///@description					Check if an button has been pressed or not
///@param {string} _button		Button name as a string
function input_check_pressed(_button)
{
	var _input_check = __input_internal_input_check(_button, INPUT_METHOD.PRESSED);
	return _input_check;
}

///@function					input_check_released(_button)
///@description					Check if an button has been released or not
///@param {string} _button		Button name as a string
function input_check_released(_button)
{
	var _input_check = __input_internal_input_check(_button, INPUT_METHOD.RELEASED);
	return _input_check;
}

///@function					input_check_axis(_axis)
///@description					Check the input of the given axis and return its value as a Vector2
///@param {string} _axis		axis_left or axis_right
///@return {Struct}				Returns a Vector2
function input_check_axis(_axis)
{
	var _input_check = new Vector2();
	var _input_manager = obj_input_manager;
	if (instance_exists(_input_manager))
	{		
		_input_check = _input_manager.__check_axis_active(_axis);		
	}
	return variable_clone(_input_check);
}

///@function					input_check_axis_pressed(_axis)
///@description					Check the input of the given axis and return its value as a Vector2
///@param {string} _axis		axis_left or axis_right
///@return {Struct}				Returns a Vector2
function input_check_axis_pressed(_axis)
{
	var _input_check = new Vector2();
	var _input_manager = obj_input_manager;
	if (instance_exists(_input_manager))
	{
		_input_check = _input_manager.__check_axis_pressed(_axis);		
	}
	return variable_clone(_input_check);
}

///@function					input_check_axis_released(_axis)
///@description					Check the input of the given axis and return its value as a Vector2
///@param {string} _axis		axis_left or axis_right
///@return {Struct}				Returns a Vector2
function input_check_axis_released(_axis)
{
	var _input_check = new Vector2();
	var _input_manager = obj_input_manager;
	if (instance_exists(_input_manager))
	{
		_input_check = _input_manager.__check_axis_released(_axis);	
	}
	return variable_clone(_input_check);
}

///@function					input_check_dpad()
///@description					Check the input of the DPAD and return its value as a Vector2
///@return {Struct}				Returns a Vector2
function input_check_dpad()
{
	var _input_check = new Vector2();
	var _input_manager = obj_input_manager;
	if (instance_exists(_input_manager))
	{		
		_input_check = _input_manager.__check_dpad_active();		
	}
	return variable_clone(_input_check);
}

///@function					input_check_dpad_pressed()
///@description					Check the input of the DPAD and return its value as a Vector2
///@return {Struct}				Returns a Vector2
function input_check_dpad_pressed()
{
	var _input_check = new Vector2();
	var _input_manager = obj_input_manager;
	if (instance_exists(_input_manager))
	{		
		_input_check = _input_manager.__check_dpad_pressed();
	}
	return variable_clone(_input_check);
}

///@function					input_check_dpad_released()
///@description					Check the input of the DPAD and return its value as a Vector2
///@return {Struct}				Returns a Vector2
function input_check_dpad_released()
{
	var _input_check = new Vector2();
	var _input_manager = obj_input_manager;
	if (instance_exists(_input_manager))
	{		
		_input_check = _input_manager.__check_dpad_released();
	}
	return variable_clone(_input_check);
}

function input_check_movement()
{
	var _vec = new Vector2(0,0);
	_vec = input_check_axis("axis_left");
	if (_vec.x == 0 && _vec.y == 0)
	{		
		_vec = input_check_dpad();	
	}
	
	return _vec;
}

function input_check_movement_pressed()
{
	var _vec = new Vector2(0,0);
	_vec = input_check_axis_pressed("axis_left");
	if (_vec.x == 0 && _vec.y == 0)
	{
		_vec = input_check_dpad_pressed();	
	}
	
	return _vec;
}

function input_check_movement_released()
{
	var _vec = new Vector2(0,0);
	_vec = input_check_axis_released("axis_left");
	if (_vec.x == 0 && _vec.y == 0)
	{
		_vec = input_check_dpad_released();	
	}
	
	return _vec;
}

function input_check_accelerator(_input)
{
	var _input_check = input_check(_input);
	if (_input_check) _input_check = obj_input_manager.input_timer(_input_check);
	
	return _input_check;
}

function input_check_movement_accelerator()
{
	var _input_check = input_check_movement(),
		_any_press = ceil(_input_check.get_magnitude());
		
	var _accelerator_check = obj_input_manager.input_timer(_any_press);
	if (_accelerator_check == 0) 
	{
		_input_check.x = 0;
		_input_check.y = 0;
	}
	
	return _input_check;
}

///@function					input_check_mouse_wheel()
///@description					Check and return if the mouse wheel is being used (-1 UP, +1 DOWN)
function input_check_mouse_wheel()
{
	var _input_check = mouse_wheel_down() - mouse_wheel_up();
	return _input_check;
}

///@function					input_get_cursor()
///@description					Return the cursor position
function input_get_cursor()
{
	return obj_input_manager.cursor_pos;
}

///@function					input_set_cursor()
///@description					Set the cursor position
function input_set_cursor(_pos)
{
	obj_input_manager.cursor_pos = _pos;
}

///@function					input_block_call(_input)
///@description					Any input calls to the specific given input will be blocked for the remaining of this frame
///@param {string} _input		Input name to be blocked
///@param {real} _frames		The number of frames the input will be blocked
function input_block_call(_input, _frames = 1)
{
	var _input_manager = obj_input_manager;
	if (instance_exists(_input_manager))
	{	
		var _block = new _input_manager.BuildInputBlock(_input, _frames);		
		array_push_unique(_input_manager.blocked_inputs, _block);
		show_debug_message($"Input {_input} was blocked")
	}
}

function input_check_any()
{
	var _input_check =  false;
	if (input_is_gamepad_mode())
	{
		var _gamepad = input_get_main_gamepad();
		//Controller
		_input_check = (round(gamepad_axis_value(_gamepad, gp_axislv)) != 0) or (round(gamepad_axis_value(_gamepad, gp_axislh)) != 0)
		for (var i = gp_face1; i < gp_axisrv; i++)
		{
			if (_input_check) break;
			if gamepad_button_check_pressed(0, i) 
			{
				_input_check = true;
			}
		}		
	}
	else
	{
		if (input_compare_mode(INPUT_MODE.KEYBOARD)) _input_check = keyboard_check_pressed(vk_anykey);
		else _input_check = mouse_check_button(mb_any);
	}
	
	return _input_check;
}

#endregion

#endregion

global.input_profile = new BuildInputProfile();