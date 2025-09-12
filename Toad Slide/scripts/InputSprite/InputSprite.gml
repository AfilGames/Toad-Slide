#region INPUT CONSTANT

function input_get_sprite(_input, _dir = 0, _mode = global.input_profile.mode)
{
	var _sprite = noone,
		_input_const = _input;
	
	if (is_string(_input))
	{
		if (_mode == INPUT_MODE.MOUSE) {
			_mode = INPUT_MODE.KEYBOARD;
		}
		
		var _map = input_get_map(_mode);
		_input_const = _map.get_input(_input);
	
		_input_const = is_array(_input_const) ? _input_const[0] : _input_const;
	}
	
	if (_input_const != noone)
	{
		if (!IS_NO_BUTTON)
		{
			switch (_mode)
			{
				case INPUT_MODE.KEYBOARD:	_sprite = __input_get_sprite_keyboard(_input_const)		break;	
				case INPUT_MODE.PS4:		_sprite = __input_get_sprite_ps4(_input_const, _dir)	break;	
				case INPUT_MODE.PS5:		_sprite = __input_get_sprite_ps5(_input_const, _dir)	break;	
				case INPUT_MODE.SWITCH:		_sprite = __input_get_sprite_switch(_input_const, _dir)	break;	
				case INPUT_MODE.XBOX:		_sprite = __input_get_sprite_xbox(_input_const, _dir)	break;	
			}
		}
		else
		{
			_sprite = spr_no_button;
		}
	}	
	return _sprite;
}

function draw_input_sprite(_input_spr, _subimg, _x, _y, _xscale, _yscale, _rot, _color, _alpha)
{
	if (IS_NO_BUTTON) _input_spr = spr_no_button;
	var _scale = input_is_gamepad_mode() ? 0.25 : 1.2;
	draw_sprite_ext(
		_input_spr, 
		_subimg, 
		_x, 
		_y, 
		_xscale * _scale, 
		_yscale * _scale, 
		_rot,
		_color, 
		_alpha
	);		
}

function __input_get_sprite_switch(_input, _dir = 0)
{
	var _spr = noone;
	switch(_input)
	{
		case gp_face1: _spr = spr_switch_b_button; break;
		case gp_face2: _spr = spr_switch_a_button; break;
		case gp_face3: _spr = spr_switch_y_button; break;
		case gp_face4: _spr = spr_switch_x_button; break;
	
		case gp_shoulderl: _spr = spr_switch_l_button; break;
		case gp_shoulderr: _spr = spr_switch_r_button; break;
		case gp_shoulderlb: _spr = spr_switch_zl_button; break;
		case gp_shoulderrb: _spr = spr_switch_zr_button; break;
	
		case gp_start: _spr = spr_switch_plus_button; break;
		case gp_select: _spr = spr_switch_minus_button; break;
	
		case gp_padu: _spr = spr_switch_dpad_up_button; break;
		case gp_padd: _spr = spr_switch_dpad_down_button; break;
		case gp_padl: _spr = spr_switch_dpad_left_button; break;
		case gp_padr: _spr = spr_switch_dpad_right_button; break;
					
		case gp_stickl: _spr = spr_switch_left_stick; break;
		case gp_stickr: _spr = spr_switch_right_stick; break;
		
		case gp_axisrv:
			switch (_dir)
			{
				case -1: _spr = spr_switch_left_stick_up; break;
				case 1: _spr = spr_switch_left_stick_down; break;
			}	
			break;
				
		case gp_axislv:
			switch (_dir)
			{
				case -1: _spr = spr_switch_right_stick_up; break;
				case 1: _spr = spr_switch_right_stick_down; break;
			}	
			break;
		
		case gp_axisrh:
			switch (_dir)
			{
				case -1: _spr = spr_switch_left_stick_left; break;
				case 1: _spr = spr_switch_left_stick_right; break;	
			}	
			break;
			
		case gp_axislh:
			switch (_dir)
			{
				case -1: _spr = spr_switch_right_stick_left; break;
				case 1: _spr = spr_switch_right_stick_right; break;	
			}	
			break;
	}
	return _spr;
}

function __input_get_sprite_ps4(_input, _dir = 0)
{
	var _spr = noone;
	switch(_input)
	{
		case gp_face1: _spr = spr_ps4_cross_button; break;
		case gp_face2: _spr = spr_ps4_circle_button; break;
		case gp_face3: _spr = spr_ps4_square_button; break;
		case gp_face4: _spr = spr_ps4_triangle_button; break;
	
		case gp_shoulderl: _spr = spr_ps4_l1_button; break;
		case gp_shoulderr: _spr = spr_ps4_r1_button; break;
		case gp_shoulderlb: _spr = spr_ps4_l2_button; break;
		case gp_shoulderrb: _spr = spr_ps4_r2_button; break;
	
		case gp_start: _spr = spr_ps4_options_button; break;
		case gp_select: _spr = spr_ps4_touchpad_button; break;
	
		case gp_padu: _spr = spr_ps4_dpad_up_button; break;
		case gp_padd: _spr = spr_ps4_dpad_down_button; break;
		case gp_padl: _spr = spr_ps4_dpad_left_button; break;
		case gp_padr: _spr = spr_ps4_dpad_right_button; break;
					
		case gp_stickl: _spr = spr_ps4_left_stick; break;
		case gp_stickr: _spr = spr_ps4_right_stick; break;
		
		case gp_axisrv:
			switch (_dir)
			{
				case -1: _spr = spr_ps4_left_stick_up; break;
				case 1: _spr = spr_ps4_left_stick_down; break;
			}	
			break;
				
		case gp_axislv:
			switch (_dir)
			{
				case -1: _spr = spr_ps4_right_stick_up; break;
				case 1: _spr = spr_ps4_right_stick_down; break;
			}	
			break;
		
		case gp_axisrh:
			switch (_dir)
			{
				case -1: _spr = spr_ps4_left_stick_left; break;
				case 1: _spr = spr_ps4_left_stick_right; break;	
			}	
			break;
			
		case gp_axislh:
			switch (_dir)
			{
				case -1: _spr = spr_ps4_right_stick_left; break;
				case 1: _spr = spr_ps4_right_stick_right; break;	
			}	
			break;
	}
	return _spr;
}

function __input_get_sprite_ps5(_input, _dir = 0)
{
	var _spr = noone;
	switch(_input)
	{
		case gp_face1: _spr = spr_ps5_cross_button; break;
		case gp_face2: _spr = spr_ps5_circle_button; break;
		case gp_face3: _spr = spr_ps5_square_button; break;
		case gp_face4: _spr = spr_ps5_triangle_button; break;
	
		case gp_shoulderl: _spr = spr_ps5_l1_button; break;
		case gp_shoulderr: _spr = spr_ps5_r1_button; break;
		case gp_shoulderlb: _spr = spr_ps5_l2_button; break;
		case gp_shoulderrb: _spr = spr_ps5_r2_button; break;
	
		case gp_start: _spr = spr_ps5_options_button; break;
		case gp_select: _spr = spr_ps5_touchpad_button; break;
	
		case gp_padu: _spr = spr_ps5_dpad_up_button; break;
		case gp_padd: _spr = spr_ps5_dpad_down_button; break;
		case gp_padl: _spr = spr_ps5_dpad_left_button; break;
		case gp_padr: _spr = spr_ps5_dpad_right_button; break;
					
		case gp_stickl: _spr = spr_ps5_left_stick; break;
		case gp_stickr: _spr = spr_ps5_right_stick; break;
		
		case gp_axisrv:
			switch (_dir)
			{
				case -1: _spr = spr_ps5_left_stick_up; break;
				case 1: _spr = spr_ps5_left_stick_down; break;
			}	
			break;
				
		case gp_axislv:
			switch (_dir)
			{
				case -1: _spr = spr_ps5_right_stick_up; break;
				case 1: _spr = spr_ps5_right_stick_down; break;
			}	
			break;
		
		case gp_axisrh:
			switch (_dir)
			{
				case -1: _spr = spr_ps5_left_stick_left; break;
				case 1: _spr = spr_ps5_left_stick_right; break;	
			}	
			break;
			
		case gp_axislh:
			switch (_dir)
			{
				case -1: _spr = spr_ps5_right_stick_left; break;
				case 1: _spr = spr_ps5_right_stick_right; break;	
			}	
			break;
	}
	return _spr;
}

function __input_get_sprite_xbox(_input, _dir = 0)
{
	var _spr = noone;
	switch(_input)
	{
		case gp_face1: _spr = spr_xbox_a_button; break;
		case gp_face2: _spr = spr_xbox_b_button; break;
		case gp_face3: _spr = spr_xbox_x_button; break;
		case gp_face4: _spr = spr_xbox_y_button; break;
	
		case gp_shoulderl: _spr = spr_xbox_lb_button; break;
		case gp_shoulderr: _spr = spr_xbox_rb_button; break;
		case gp_shoulderlb: _spr = spr_xbox_lt_button; break;
		case gp_shoulderrb: _spr = spr_xbox_rt_button; break;
	
		case gp_start: _spr = spr_xbox_menu_button; break;
		case gp_select: _spr = spr_xbox_view_button; break;
	
		case gp_padu: _spr = spr_xbox_dpad_up_button; break;
		case gp_padd: _spr = spr_xbox_dpad_down_button; break;
		case gp_padl: _spr = spr_xbox_dpad_left_button; break;
		case gp_padr: _spr = spr_xbox_dpad_right_button; break;
					
		case gp_stickl: _spr = spr_xbox_left_stick; break;
		case gp_stickr: _spr = spr_xbox_right_stick; break;
		
		case gp_axisrv:
			switch (_dir)
			{
				case -1: _spr = spr_xbox_left_stick_up; break;
				case 1: _spr = spr_xbox_left_stick_down; break;
			}	
			break;
				
		case gp_axislv:
			switch (_dir)
			{
				case -1: _spr = spr_xbox_right_stick_up; break;
				case 1: _spr = spr_xbox_right_stick_down; break;
			}	
			break;
		
		case gp_axisrh:
			switch (_dir)
			{
				case -1: _spr = spr_xbox_left_stick_left; break;
				case 1: _spr = spr_xbox_left_stick_right; break;	
			}	
			break;
			
		case gp_axislh:
			switch (_dir)
			{
				case -1: _spr = spr_xbox_right_stick_left; break;
				case 1: _spr = spr_xbox_right_stick_right; break;	
			}	
			break;
	}
	return _spr;
}

function __input_get_sprite_keyboard(_input)
{
	var _spr = noone;
	switch (_input)
	{
		case vk_enter: _spr = spr_keyboard_enter; break;	
		case vk_escape: _spr = spr_keyboard_esc; break;	
		case vk_space: _spr = spr_keyboard_space; break;	
		case ord("R"): _spr = spr_keyboard_r; break;	
		case ord("H"): _spr = spr_keyboard_h; break;
		case ord("Q"): _spr = spr_keyboard_q; break;
	}
	return _spr;
}

function __input_get_sprite_mouse(_input)
{
	var _spr = noone;
	switch (_input)
	{
		case MB_LEFT:	_spr = spr_mouse_lbutton; break;	
		case MB_RIGHT:	_spr = spr_mouse_rbutton; break;	
		case MB_SCROLL: _spr = spr_mouse_scroll; break;	
	}
	return _spr;
}

#endregion



function draw_rotation_input(_x, _y, _xscale, _yscale, _rotation, _alpha)
{
	var _lsprite = input_get_sprite(ACT_ROTATE_LEFT),
		_rsprite = input_get_sprite(ACT_ROTATE_RIGHT);
	
	if (input_is_gamepad_mode())
	{
		if (_lsprite!= noone)
		{
			draw_input_sprite(
				_lsprite, 
				0, 
				_x - 12, 
				_y, 
				_xscale, 
				_yscale, 
				_rotation - 10,
				-1, 
				_alpha
			);	
		}
				
		if (_rsprite != noone)
		{
			draw_input_sprite(
				_rsprite, 
				0, 
				_x + 12, 
				_y, 
				_xscale, 
				_yscale, 
				_rotation + 10,
				-1, 
				_alpha
			);	
		}	
	}
	else
	{
		draw_input_sprite(
			_lsprite, 
			0, 
			_x, 
			_y, 
			_xscale, 
			_yscale, 
			_rotation,
			-1, 
			_alpha
		);	
	}
}