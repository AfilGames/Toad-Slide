/// @description Inserir descrição aqui

// Only one should exist
if (instance_number(obj_input_manager) > 1)
{
	instance_destroy(id);	
}

__input_sys_run_at_init();

debug_inputs = false;
draw_cursor = true;

// Control variables (DONT CHANGE)
past_mouse = new Vector2(0,0);
blocked_inputs = [];
cursor_pos = new Vector2(0,0);

// TIMER
acc_timer_total = 0.2;
acc_decrease = 0;
acc_timer = 0;
acc_timer_checking = false;
acc_timer_return = true;

axis_pressed = false;

axis_released_check = false;
axis_released_last = false;

block_input_event = [];

input_timer = function(_input)
{	
	if (_input != 0) acc_timer_checking = true;
				
	if (acc_timer_checking && acc_timer_return)
	{	
		return true;
	}
	else return false;
}

#region Sys

///@function				detect_active_mode()
///@desc					Detecta o ultimo modo de input utilizado e atualiza o sistema
detect_active_mode = function()
{
	//	Keyboard
	if (!input_compare_mode(INPUT_MODE.KEYBOARD))
	{		
		if (keyboard_check_pressed(vk_anykey)) 
		{
			input_swap_mode(INPUT_MODE.KEYBOARD);
			past_mouse.x = device_mouse_x_to_gui(0);
			past_mouse.y = device_mouse_y_to_gui(0);
		}
	}
	
		// MOUSE
	if (!input_compare_mode(INPUT_MODE.MOUSE))
	{
		if (past_mouse.x != device_mouse_x_to_gui(0) || past_mouse.y != device_mouse_y_to_gui(0)) 
		{
			input_swap_mode(INPUT_MODE.MOUSE);
		}
	}
	
	// GAMEPAD
	if (!input_is_gamepad_mode())
	{
		var _gamepad = input_get_main_gamepad();
		//Controller
		var _controller_pressed = false;
		_controller_pressed = (round(gamepad_axis_value(_gamepad, gp_axislv)) != 0) or (round(gamepad_axis_value(_gamepad, gp_axislh)) != 0)
		for (var i = gp_face1; i < gp_axisrv; i++)
		{
			if (_controller_pressed) break;
			if gamepad_button_check_pressed(0, i) 
			{
				_controller_pressed = true;
		    }
		}
		if (_controller_pressed)
		{
			__input_set_gamepad_type()
			past_mouse.x = device_mouse_x_to_gui(0);
			past_mouse.y = device_mouse_y_to_gui(0);
		}	
	}
	
}

///@function				BuildInputBlock()
///@desc					Struct utilizado para o controle de inputs bloqueados
///@param {string} _name	Nome do input a ser bloqueado
///@param {real} _frames	Quantidade de frames que o input será bloqueado
BuildInputBlock = function(_name, _frames) constructor
{
	name = _name;
	frames = _frames;
}

///@function				block_input_calls_manager()
///@desc					Controle dos inputs bloqueados
block_input_calls_manager = function()
{
	var _len = array_length(blocked_inputs); 
	var _delete_ind = [];;
	for (var i = 0; i < _len; i++)
	{
		var _block = blocked_inputs[i];
		_block.frames--;
		if (_block.frames <= 0)
		{
			array_push(_delete_ind, i);
			show_debug_message($"{_block.name} was unlocked")
		}
	}
	
	for (var i = 0; i < array_length(_delete_ind); i++)
	{
		array_delete(blocked_inputs, _delete_ind[i], 1);
		
	}
}	

///@function				block_input_find()
///@desc					Checa se o input passado como parametro está bloqueado
///@param {string} _name	Nome do input em string
block_input_find = function(_name)
{
	var _found = false;
	var _len = array_length(blocked_inputs); 
	for (var i = 0; i < _len; i++)
	{
		var _block = blocked_inputs[i];
		if (_block.name == _name){
			_found = true;
			break;
		}
	}
	return _found;
}

#endregion

#region EVENT

event_check_action = function(_input_check, _method, _name)
{
	if (_method == INPUT_METHOD.ACTIVE)
	{
		var _event_ind = array_get_index(block_input_event, _name);		
		if (_input_check)
		{
			if (_event_ind == -1)
			{
				array_push(block_input_event, _name);
				__input_execute_events(_name);	
			}
		}
		else if (_event_ind != -1)
		{
			array_delete(block_input_event, _event_ind, 1);	
		}	
	}
	else
	{
		if (_input_check)
		{
			__input_execute_events(_name);				
		}	
	}	
}

event_check_input = function(_input_check, _method, _input)
{
	if (_method == INPUT_METHOD.ACTIVE)
	{
		var _event_ind = array_get_index(block_input_event, _input);		
		if (_input_check)
		{
			if (_event_ind == -1)
			{
				array_push(block_input_event, _input);
				__input_execute_events(_input);	
			}
		}
		else if (_event_ind != -1)
		{
			array_delete(block_input_event, _event_ind, 1);	
		}	
	}
	else
	{
		if (_input_check)
		{
			__input_execute_events(_input);				
		}	
	}	
}

#endregion

#region Input Checker

///@function					__check_input_manual(_input, _method)
///@desc						Check an given input (constant) using the correct method function for keyboards
///@param {string} _method		Method name (pressed, active, released) as a string
///@param {string} _name		Input name to be checked
__check_input_manual = function(_method, _name, _mode = global.input_profile.mode, _recursive = true)
{	
	var _map = input_get_map(_mode, global.settings_data.gameplay.default_mode_map[_mode]);
	
	var _input_check = false,
		_input_ind = _map.get_input(_name);
		
	if (_input_ind != noone && !block_input_find(_name))
	{		
		_input_check = __check_input(_input_ind, _method, _name, _mode);	
	}
	
	if (global.input_profile.__mouse_kb_as_one && _input_check == false && _recursive)
	{			
		var _new_mode = input_compare_mode(INPUT_MODE.KEYBOARD) ? INPUT_MODE.MOUSE : INPUT_MODE.KEYBOARD;		
		_input_check = __check_input_manual(_method, _name, _new_mode, false);
		
	}
	
	event_check_action(_input_check, _method, _name);
	event_check_input(_input_check, _method, _input_ind);
	
	return _input_check;
}	

///@function					__check_input(_input, _method)
///@desc						Check an given input (constant) using the correct method function for keyboards
///@param {constant} _input		Input constant to be checked
///@param {string} _method		Method name (pressed, active, released) as a string
///@param {string} _name		Input name to be checked
__check_input = function(_input, _method, _name, _mode = global.input_profile.mode)
{
	var _input_check = false;
	var _check_len = 1;
	if (is_array(_input)) _check_len = array_length(_input);
	for (var i = 0; i <_check_len; i++)
	{
		var _input_to_check = is_array(_input) ? _input[i] : _input;
		switch (_mode)
		{
			case INPUT_MODE.KEYBOARD:
				_input_check = __check_input_keyboard(_input_to_check, _method, _name);
				break;
			case INPUT_MODE.MOUSE:
				_input_check = __check_input_mouse(_input_to_check, _method, _name);
				break;
			case INPUT_MODE.PS4:
			case INPUT_MODE.PS5:
			case INPUT_MODE.XBOX:
			case INPUT_MODE.SWITCH:
				_input_check = __check_input_gamepad(_input_to_check, _method, _name);
				break;
		}
		if (_input_check) break;
	}
	
	
	
	return _input_check;
}	

///@function					__check_input_keyboard(_input, _method)
///@desc						Check an given input (constant) using the correct method function for keyboards
///@param {constant} _input		Input constant to be checked
///@param {string} _method		Method name (pressed, active, released) as a string
__check_input_keyboard = function(_input, _method, _name)
{
	var _input_check = false;

	switch (_method)
	{
		case INPUT_METHOD.PRESSED:
			_input_check = keyboard_check_pressed(_input);
			break;
		case INPUT_METHOD.ACTIVE:
			_input_check = keyboard_check(_input);
			break;
		case INPUT_METHOD.RELEASED:
			_input_check = keyboard_check_released(_input);
			break;
	}	
	
	return _input_check;
}

///@function					__check_input_gamepad(_input, _method)
///@desc						Check an given input (constant) using the correct method function for keyboards
///@param {constant} _input		Input constant to be checked
///@param {string} _method		Method name (pressed, active, released) as a string
///@param {real} _gamepad		Gamepad index
__check_input_gamepad = function(_input, _method, _name)
{
	var _gamepad = input_get_main_gamepad();
	var _input_check = false;	
	switch (_method)
	{
		case INPUT_METHOD.PRESSED:
			_input_check = gamepad_button_check_pressed(_gamepad, _input);
			break;
		case INPUT_METHOD.ACTIVE:
			_input_check = gamepad_button_check(_gamepad, _input);
			break;
		case INPUT_METHOD.RELEASED:
			_input_check = gamepad_button_check_released(_gamepad,_input);
			break;
	}

	return _input_check;
}

///@function					__check_input_mouse(_input, _method)
///@desc						Check an given input (constant) using the correct method function for keyboards
///@param {constant} _input		Input constant to be checked
///@param {string} _method		Method name (pressed, active, released) as a string
__check_input_mouse = function(_input, _method, _name)
{
	var _input_check = false;

	switch (_method)
	{
		case INPUT_METHOD.PRESSED:
			_input_check = mouse_check_button_pressed(_input);
			break;
		case INPUT_METHOD.ACTIVE:
			_input_check = mouse_check_button(_input);
			break;
		case INPUT_METHOD.RELEASED:
			_input_check = mouse_check_button_released(_input);
			break;
	}	
	
	return _input_check;
}

///@function					__check_axis_pressed(_axis, _mode)
///@description					Check for axis input using the pressed behaviour
///@param {string} _axis		Axis to be checked (axis_left or axis_right)
///@param {struct} _mode		Input Mode
__check_axis_pressed = function(_axis, _mode = global.input_profile.mode)
{
	var _map = input_get_map(_mode, global.input_profile.active_map);
	var _axis_vector = new Vector2();
	
	if (input_is_gamepad_mode())
	{
		var _gamepad = input_get_main_gamepad();
		
		// Complex
		var _h_axis_input = _map.get_input($"{_axis}_h");
		var _v_axis_input =  _map.get_input($"{_axis}_v");	
		
		_axis_vector.x = round(gamepad_axis_value(_gamepad, _h_axis_input));
		_axis_vector.y = round(gamepad_axis_value(_gamepad, _v_axis_input));
				
		var _axis_mag = _axis_vector.get_magnitude();
		if (_axis_mag != 0)
		{
			if (!axis_pressed)
			{
				axis_pressed = true;				
			}
			else
			{
				_axis_vector.x = 0;
				_axis_vector.y = 0;
			}	
		}
		else
		{
			axis_pressed = false;
		}	
	}
	else if (input_compare_mode(INPUT_MODE.KEYBOARD))
	{
		_map = input_get_map(INPUT_MODE.KEYBOARD, global.settings_data.gameplay.default_mode_map[INPUT_MODE.KEYBOARD]);
		var _l_axis_input = _map.get_input($"axis_left");
		var _r_axis_input = _map.get_input($"axis_right");
		var _u_axis_input = _map.get_input($"axis_up");
		var _d_axis_input = _map.get_input($"axis_down");
		
		var _laxis = __check_input(_l_axis_input, INPUT_METHOD.PRESSED, $"axis_left");
		var _raxis = __check_input(_r_axis_input, INPUT_METHOD.PRESSED, $"axis_right");
		var _uaxis = __check_input(_u_axis_input, INPUT_METHOD.PRESSED, $"axis_up");
		var _daxis = __check_input(_d_axis_input, INPUT_METHOD.PRESSED, $"axis_down");
		
		_axis_vector.x = _raxis - _laxis;
		_axis_vector.y = _daxis - _uaxis;
		
	}
	return _axis_vector;
}

__check_dpad_pressed =	function(_axis, _mode = global.input_profile.mode)
{	
	var _map = input_get_map(_mode);
	var _axis_vector = new Vector2();
	
	var _l_axis_input = _map.get_input($"dpad_left");
	var _r_axis_input = _map.get_input($"dpad_right");
	var _u_axis_input = _map.get_input($"dpad_up");
	var _d_axis_input = _map.get_input($"dpad_down");
		
	var _ldpad = __check_input(_l_axis_input, INPUT_METHOD.PRESSED, $"dpad_left");
	var _rdpad = __check_input(_r_axis_input, INPUT_METHOD.PRESSED, $"dpad_right");
	var _udpad = __check_input(_u_axis_input, INPUT_METHOD.PRESSED, $"dpad_up");
	var _ddpad = __check_input(_d_axis_input, INPUT_METHOD.PRESSED, $"dpad_down");
		
	_axis_vector.x = _rdpad - _ldpad;
	_axis_vector.y = _ddpad - _udpad;	
	
	return _axis_vector;
}

///@function					__check_axis_active(_axis, _mode)
///@description					Check for axis input using the active behaviour
///@param {string} _axis		Axis to be checked (axis_left or axis_right)
__check_axis_active = function(_axis, _mode = global.input_profile.mode)
{
	var _map = input_get_map(_mode, global.input_profile.active_map);
	var _axis_vector = new Vector2();

	if (input_is_gamepad_mode())
	{
		var _gamepad = input_get_main_gamepad();
		var _h_axis_input = _map.get_input($"{_axis}_h");
		var _v_axis_input =  _map.get_input($"{_axis}_v");	
		
		_axis_vector.x = round(gamepad_axis_value(_gamepad, _h_axis_input));
		_axis_vector.y = round(gamepad_axis_value(_gamepad, _v_axis_input));

	}
	else
	{
		_map = input_get_map(INPUT_MODE.KEYBOARD, global.settings_data.gameplay.default_mode_map[INPUT_MODE.KEYBOARD]);
		
		var _l_axis_input = _map.get_input($"axis_left");
		var _r_axis_input = _map.get_input($"axis_right");
		var _u_axis_input = _map.get_input($"axis_up");
		var _d_axis_input = _map.get_input($"axis_down");
		
		var _laxis = __check_input(_l_axis_input, INPUT_METHOD.ACTIVE, $"axis_left");
		var _raxis = __check_input(_r_axis_input, INPUT_METHOD.ACTIVE, $"axis_right");
		var _uaxis = __check_input(_u_axis_input, INPUT_METHOD.ACTIVE, $"axis_up");
		var _daxis = __check_input(_d_axis_input, INPUT_METHOD.ACTIVE, $"axis_down");
		
		_axis_vector.x = _raxis - _laxis;
		_axis_vector.y = _daxis - _uaxis;
	}
	
	return _axis_vector;
}

__check_dpad_active = function(_mode = global.input_profile.mode)
{
	var _map = input_get_map(_mode);
	var _axis_vector = new Vector2();
	
	var _l_dpad_input = _map.get_input($"dpad_left");
	var _r_dpad_input = _map.get_input($"dpad_right");
	var _u_dpad_input = _map.get_input($"dpad_up");
	var _d_dpad_input = _map.get_input($"dpad_down");
		
	var _ldpad = __check_input(_l_dpad_input, INPUT_METHOD.ACTIVE, $"dpad_left");
	var _rdpad = __check_input(_r_dpad_input, INPUT_METHOD.ACTIVE, $"dpad_right");
	var _udpad = __check_input(_u_dpad_input, INPUT_METHOD.ACTIVE, $"dpad_up");
	var _ddpad = __check_input(_d_dpad_input, INPUT_METHOD.ACTIVE, $"dpad_down");
		
	_axis_vector.x = _rdpad - _ldpad;
	_axis_vector.y = _ddpad - _udpad;
	
	return _axis_vector;
}

///@function					__check_axis_released(_axis, _mode)
///@description					Check for axis input using the released behaviour
///@param {string} _axis		Axis to be checked (axis_left or axis_right)
///@param {struct} _mode		Input Mode
__check_axis_released = function(_axis, _mode = global.input_profile.mode)
{
	var _map = input_get_map(_mode, global.input_profile.active_map);
	var _axis_vector = new Vector2();
	
	if (input_is_gamepad_mode())
	{
		var _gamepad = input_get_main_gamepad();
		var _h_axis_input = _map.get_input($"{_axis}_h");
		var _v_axis_input =  _map.get_input($"{_axis}_v");	
		
		_axis_vector.x = round(gamepad_axis_value(_gamepad, _h_axis_input));
		_axis_vector.y = round(gamepad_axis_value(_gamepad, _v_axis_input));
		
		if (!axis_released_check && _axis_vector.get_magnitude() != 0)
		{
			axis_released_check = true;
			axis_released_last = variable_clone(_axis_vector);
		} 
		else
		{
			if (_axis_vector.get_magnitude() == 0)
			{
				_axis_vector = variable_clone(axis_released_last);
				axis_released_last = new Vector2(0,0);
			}
			_axis_vector.x = 0;
			_axis_vector.y = 0;
		}
	}
	else if (input_compare_mode(INPUT_MODE.KEYBOARD))
	{
		_map = input_get_map(INPUT_MODE.KEYBOARD, global.settings_data.gameplay.default_mode_map[INPUT_MODE.KEYBOARD]);
		var _l_axis_input = _map.get_input($"axis_left");
		var _r_axis_input = _map.get_input($"axis_right");
		var _u_axis_input = _map.get_input($"axis_up");
		var _d_axis_input = _map.get_input($"axis_down");
		
		var _laxis = __check_input(_l_axis_input, INPUT_METHOD.RELEASED, $"axis_left");
		var _raxis = __check_input(_r_axis_input, INPUT_METHOD.RELEASED, $"axis_right");
		var _uaxis = __check_input(_u_axis_input, INPUT_METHOD.RELEASED, $"axis_up");
		var _daxis = __check_input(_d_axis_input, INPUT_METHOD.RELEASED, $"axis_down");
		
		_axis_vector.x = _raxis - _laxis;
		_axis_vector.y = _daxis - _uaxis;
	}
	return _axis_vector;
}

__check_dpad_released = function(_mode = global.input_profile.mode)
{
	var _map = input_get_map(_mode);
	var _axis_vector = new Vector2();
	
	var _l_axis_input = _map.get_input($"dpad_left");
	var _r_axis_input = _map.get_input($"dpad_right");
	var _u_axis_input = _map.get_input($"dpad_up");
	var _d_axis_input = _map.get_input($"dpad_down");
		
	var _ldpad = __check_input(_l_axis_input, INPUT_METHOD.RELEASED, $"dpad_left");
	var _rdpad = __check_input(_r_axis_input, INPUT_METHOD.RELEASED, $"dpad_right");
	var _udpad = __check_input(_u_axis_input, INPUT_METHOD.RELEASED, $"dpad_up");
	var _ddpad = __check_input(_d_axis_input, INPUT_METHOD.RELEASED, $"dpad_down");
		
	_axis_vector.x = _rdpad - _ldpad;
	_axis_vector.y = _ddpad - _udpad;
	
	return _axis_vector;
}

check_cursor_pos = function()
{
	if (!input_is_gamepad_mode())
	{
		cursor_pos.x = device_mouse_x_to_gui(0);
		cursor_pos.y = device_mouse_y_to_gui(0);
	}
	else
	{
		var _axis = input_check_movement();

		_axis.normalize()
		
		var _speed = global.settings_data.gameplay.cursor_speed;
		
		cursor_pos.x += _axis.x * (_speed * delta_time_seconds());
		cursor_pos.y += _axis.y * (_speed * delta_time_seconds());
	}
}

#endregion

#region DEBUG

draw_debug_inputs = function()
{	
}

#endregion


