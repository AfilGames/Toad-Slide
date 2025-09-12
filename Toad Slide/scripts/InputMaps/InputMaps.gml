#region INPUT MAP STRUCTS

///@function		BuildInputMapButtons() 
///@description		Constrói o struct do mapa de inputs para botões
function BuildInputMapButtons() constructor
{	
	simple = {};
	with (simple){
		// Face
		north = noone;
		south = noone;
		east = noone;
		west = noone;	
		// Bumpers and Triggers
		left_shoulder = noone;
		right_shoulder = noone;
		left_trigger = noone;
		right_trigger = noone;
		// MISC
		start = noone;
		select = noone;	
		// Stick press
		left_stick_button = noone;
		right_stick_button = noone;	
		// D-PAD
		dpad_up = noone;
		dpad_down = noone;
		dpad_left = noone;
		dpad_right = noone;	
		// Axis (KEYBOARD)
		axis_up = noone;
		axis_down = noone;
		axis_left = noone;
		axis_right = noone;		
		// MOUSE
		mouse_click_right = noone;
		mouse_click_left = noone;	
		
		//actions
		act_accept = noone;
		act_return = noone;
		act_cancel = noone;
		act_confirm = noone;
		act_pause  = noone;
	}	
	complex = {};
	with (complex)
	{
		// AXIS
		axis_left_h = noone;
		axis_left_v = noone;
		axis_right_h = noone;
		axis_right_v = noone;	
	}
		
	///@function								get_input(_button, _simple)
	///@description								Função utilizada para retornar a constante de um input para um botão
	///@param {string} _button					Nome da botão em string
	static get_input = function(_button, _simple = true)
	{
		var _input = noone;
		if (_simple && struct_exists(simple, _button))
		{
			_input = simple[$ _button];
		}
		else if (struct_exists(complex, _button))
		{
			_input = complex[$ _button];
		}
		
		return _input;
	}
}

///@function		BuildInputMap() 
///@description		Constrói o struct do mapa de inputs geral
function BuildInputMap() constructor
{
	button_map = new BuildInputMapButtons();
		
	///@function								__update_internal_input(_map, _input_name, _input)
	///@description								Internal function to set a new input on a map
	///@param {struct} _map						Input map that contains the desired input
	///@param {string} _input_name				Name of the desired input in a string
	///@param {constant} _input					New input constant to be set or array with multiple inputs
	static __update_internal_input = function(_map, _input_name, _input)
	{
		var _success = false;
		if (struct_exists(_map, _input_name))
		{
			_map[$ _input_name] = _input;
			_success = true;
		} 
		else
		{
			struct_add_variable_once(_map, _input_name, _input);
			_success = true;
		}
		
		return _success;
	}
		
	///@function								set_input(_button, _input)
	///@description								Função utilizada para definir a constante de um input para um botão
	///@param {string} _button					Nome da botão em string
	///@param {constant} _input					Constante do input a ser definido ou array com multiplos inputs
	static set_input = function(_button, _input, _simple = true)
	{
		var _success = 0;
		if (_simple)
		{
			_success = __update_internal_input(button_map.simple, _button, _input);
		}
		else
		{
			_success = __update_internal_input(button_map.complex, _button, _input);
		}
		
		return _success;
	}
	
	///@function								get_input(_button, _simple)
	///@description								Função utilizada para retornar a constante de um input para um botão
	///@param {string} _button					Nome da botão em string
	static get_input = function(_button, _simple = true)
	{
		var _input = noone;
		if (_simple && struct_exists(button_map.simple, _button))
		{
			_input = button_map.simple[$ _button];
		}
		else if (struct_exists(button_map.complex, _button))
		{
			_input = button_map.complex[$ _button];
		}
		
		return _input;
	}
	
	///@function								load_button_map(_map)
	///@description								Carrega um mapa de botões no struct
	///@param {struct} _mode_maps				Struct do mapa de botões
	static load_button_map = function(_mode_maps)
	{
		var _index = global.input_profile.active_map;
		button_map = _mode_maps[_index];		
		return self;
	}
	
	///@function								reload_active_button_map(_map)
	///@description								Recarrega o mapa de botões para o index ativo
	static reload_active_button_map = function()
	{
		var _index = global.input_profile.active_map;
		var _mode = global.input_profile.mode;
		button_map = global.input_maps[_mode][_index];		
		return self;
	}
}	

#endregion

#region	BUTTON AND ACTION MACROS

// Face
#macro BT_NORTH "north"
#macro BT_SOUTH "south"
#macro BT_EAST "east"
#macro BT_WEST "west"
// Bumpers and Triggers
#macro BT_LEFT_SHOULDER "left_shoulder"
#macro BT_RIGHT_SHOULDER "right_shoulder"
#macro BT_LEFT_TRIGGER "left_trigger"
#macro BT_RIGHT_TRIGGER "right_trigger"
// MISC
#macro BT_START "start"
#macro BT_SELECT "select"
// Stick press
#macro BT_LEFT_STICK_BUTTON "left_stick_button"
#macro BT_RIGHT_STICK_BUTTON "right_stick_button"
// D-PAD
#macro BT_DPAD_UP "dpad_up"
#macro BT_DPAD_DOWN "dpad_down"
#macro BT_DPAD_LEFT "dpad_left"
#macro BT_DPAD_RIGHT "dpad_right"
// Axis (KEYBOARD)
#macro BT_AXIS_UP "axis_up"
#macro BT_AXIS_DOWN "axis_down"
#macro BT_AXIS_LEFT "axis_left"
#macro BT_AXIS_RIGHT "axis_right"

//Action
#macro ACT_ACCEPT "act_accept"
#macro ACT_RETURN "act_return"
#macro ACT_CONFIRM "act_confirm"
#macro ACT_PAUSE "act_pause"
#macro ACT_SELECT "act_select"

//#macro ACT_CANCEL "act_cancel"
//#macro ACT_RESET "act_reset"

#macro ACT_RESTART "game_restart"
#macro ACT_REWIND "game_rewind"

// Mouse
#macro MB_SCROLL	"mb_scroll"
#macro MB_LEFT		mb_left
#macro MB_RIGHT		mb_right

#endregion

#region Default Maps

///@function		build_default_input_map_keyboard() 
///@description		Retorna o struct do mapa de input base para teclado
function build_default_input_map_keyboard()
{
	var _map = new BuildInputMap();	
	with (_map){
		#region BUTTON
		set_input("north", ord("T"))
		set_input("south", vk_space)
		set_input("east", vk_backspace)
		set_input("west", ord("Y"));
		
		// Shoulders buttons
		set_input("left_shoulder", ord("Q"))
		set_input("right_shoulder", ord("E"))
		set_input("left_trigger", vk_control)
		set_input("right_trigger", vk_shift);
	
		// Start and select
		set_input("start", vk_escape)
		set_input("select", vk_tab);
	
		// Axis/WASD
		set_input("axis_up", ord("W"))
		set_input("axis_down", ord("S"))
		set_input("axis_left", ord("A"))
		set_input("axis_right", ord("D"));
		
		// DPAD
		set_input("dpad_up", vk_up)
		set_input("dpad_down", vk_down)
		set_input("dpad_left", vk_left)
		set_input("dpad_right", vk_right);
	
		// MISC
		set_input("left_stick_button", ord("F"))
		set_input("right_stick_button", ord("G"));
		#endregion	
		
		#region ACTIONS
		
		// INTERFACE
		set_input("act_accept",[vk_space, vk_enter]);
		set_input("act_confirm",[vk_space, vk_enter]);
		set_input("act_return",[vk_backspace, vk_escape]);		
		set_input("act_pause",vk_escape);
		
		//	Game
		set_input("game_rewind",[ord("Q"), vk_backspace]);
		set_input("game_interact", vk_space);
		set_input("game_restart",ord("R"));
		
		#endregion
	}
	return variable_clone(_map.button_map);
}

///@function		build_default_input_map_mouse() 
///@description		Retorna o struct do mapa de input base para mouse
function build_default_input_map_mouse()
{
	var _map = new BuildInputMap();	
	with (_map){
		#region BUTTON
		
		set_input("mouse_click_right", mb_right)
		set_input("mouse_click_left", mb_left)	
		
		#endregion	
		
		#region ACTIONS
		
		set_input("act_accept", mb_left);
		set_input("act_return", mb_right);
			
		#endregion
	}
	return variable_clone(_map.button_map);
}

///@function		build_default_input_map_gamepad() 
///@description		Retorna o struct do mapa de input base para gamepads
function build_default_input_map_gamepad()
{
	var _map = new BuildInputMap();	
	with (_map){
		#region BUTTON
		set_input("north", gp_face4);
		
		if(os_type == os_ps4 && global.enter_button_assign == 0) || (os_type == os_switch) {
			set_input("south", gp_face2);
			set_input("east", gp_face1);
		}else{
			set_input("south", gp_face1);
			set_input("east", gp_face2);
		}
		set_input("west", gp_face3);
		
		// Shoulders buttons
		set_input("left_shoulder", gp_shoulderl);
		set_input("right_shoulder", gp_shoulderr);
		set_input("left_trigger", gp_shoulderlb);
		set_input("right_trigger", gp_shoulderrb);
	
		// Start and select
		set_input("start", gp_start);
		set_input("select", gp_select);
	 
		// Axis
		set_input("axis_left_v", gp_axislv, false);
		set_input("axis_left_h", gp_axislh, false);
		set_input("axis_right_v", gp_axisrv, false);
		set_input("axis_right_h", gp_axisrh, false);
		
		// DPAD
		set_input("dpad_up", gp_padu);
		set_input("dpad_down", gp_padd);
		set_input("dpad_left", gp_padl);
		set_input("dpad_right", gp_padr);
	
		// MISC
		set_input("left_stick_button", gp_stickl);
		set_input("right_stick_button", gp_stickr);
		
		#endregion
		
		#region ACTIONS
		
		// INTERFACE

		if(os_type == os_ps4 && global.enter_button_assign == 0) || (os_type == os_switch){
			set_input("act_accept",gp_face2);
			set_input("act_confirm", gp_face2);
			set_input("act_return",gp_face1);
		}else{
			set_input("act_accept",gp_face1);
			set_input("act_confirm", gp_face1);
			set_input("act_return",gp_face2);
		}
		set_input("act_pause",gp_start);
		
		//	Game
		set_input("game_restart", gp_face4);

		if(os_type == os_ps4 && global.enter_button_assign == 0) || (os_type == os_switch){
			set_input("act_select", gp_face2);
			set_input("act_reset", gp_face1);
		}else{
			set_input("act_select", gp_face1);
			set_input("act_reset", gp_face2);
		}
		
		set_input("game_interact", gp_face1);
		set_input("game_rewind",gp_face3);
		
		#endregion
	}
	return variable_clone(_map.button_map);
}

#endregion

#region Input Events

function __input_sys_run_at_init()
{
	/*
	input_bind_event(vk_space, [tween_cursor_click], INPUT_MODE.KEYBOARD);
	input_bind_event(gp_face1, [tween_cursor_click], INPUT_MODE.XBOX);
	input_bind_event(mb_left, [tween_cursor_click], INPUT_MODE.MOUSE);
	*/
}

#endregion
