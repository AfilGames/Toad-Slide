#macro BUTTON_ICON_TYPE "BUTTON_ICON_TYPE"
#macro BUTTON_ICON_PLAYSTATION4 "BUTTON_ICON_PLAYSTATION4"
#macro BUTTON_ICON_PLAYSTATION5 "BUTTON_ICON_PLAYSTATION5"
#macro BUTTON_ICON_XBOX "BUTTON_ICON_XBOX"
#macro BUTTON_ICON_SWITCH "BUTTON_ICON_SWITCH"
#macro BUTTON_ICON_KEYBOARD "BUTTON_ICON_KEYBOARD"


//trocar para keyboard
#macro BUTTON_SOUTH		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_space	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_cross_button		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_cross_button		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_b_button			: spr_xbox_a_button			 )))
#macro BUTTON_NORTH		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_keyboard_r				: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_triangle_button	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_triangle_button		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_x_button			: spr_xbox_y_button			 )))
#macro BUTTON_WEST		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_shift	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_square_button		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_square_button		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_y_button			: spr_xbox_x_button			 )))
#macro BUTTON_EAST		global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_circle_button		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_circle_button		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_a_button			: spr_xbox_b_button			 )))
#macro BUTTON_LEFT		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_dpad_left_button	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_dpad_left_button	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_dpad_left_button	: spr_xbox_dpad_left_button	 )))
#macro BUTTON_RIGHT		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_dpad_right_button	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_dpad_right_button	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_dpad_right_button	: spr_xbox_dpad_right_button )))
#macro BUTTON_UP		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_dpad_up_button	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_dpad_up_button		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_dpad_up_button		: spr_xbox_dpad_up_button	 )))
#macro BUTTON_DOWN		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_dpad_down_button	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_dpad_down_button	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_dpad_down_button	: spr_xbox_dpad_down_button	 )))
#macro BUTTON_LSTICK	global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_left_stick_button	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_left_stick_button	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_left_stick_move	: spr_xbox_left_stick )))
#macro BUTTON_RSTICK	global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_right_stick_button: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_right_stick_button	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_right_stick_button : spr_xbox_right_stick)))
#macro BUTTON_START		global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_options_button	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_options_button		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_plus_button		: spr_xbox_menu_button		 )))
#macro BUTTON_SELECT	global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_touchpad_button	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_touchpad_button		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_minus_button		: spr_xbox_view_button	 )))
#macro BUTTON_RBUMPER	global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_r1_button			: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_r1_button			: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_r_button			: spr_xbox_rb_button		 )))
#macro BUTTON_RTRIGGER	global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_r2_button			: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_r2_button			: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_zr_button			: spr_xbox_rt_button		 )))
#macro BUTTON_LBUMPER	global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_l1_button			: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_l1_button			: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_l_button			: spr_xbox_lb_button		 )))
#macro BUTTON_LTRIGGER	global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_l2_button			: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_l2_button			: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_zl_button			: spr_xbox_lt_button		 )))
#macro BUTTON_DPAD		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_pad	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_dpad				: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_dpad				: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_dpad				: spr_xbox_dpad				 )))
#macro L_AXIS			global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_left_stick		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_left_stick			: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_left_stick			: spr_xbox_left_stick		 )))
#macro R_AXIS			global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_right_stick		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_right_stick			: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_right_stick		: spr_xbox_right_stick		 )))
#macro L_AXIS_UP		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_left_stick_up		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_left_stick_up		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_left_stick_up		: spr_xbox_left_stick_up	 )))
#macro L_AXIS_DOWN		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_left_stick_down	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_left_stick_down		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_left_stick_down	: spr_xbox_left_stick_down	 )))
#macro L_AXIS_RIGHT		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_left_stick_right	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_left_stick_right	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_left_stick_right	: spr_xbox_left_stick_right	 )))
#macro L_AXIS_LEFT		global.current_controller_type == BUTTON_ICON_KEYBOARD ? spr_input_keyboard_wasd	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_left_stick_left	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_left_stick_left		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_left_stick_left	: spr_xbox_left_stick_left	 )))
#macro R_AXIS_UP		global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_right_stick_up	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_right_stick_up		: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_right_stick_up		: spr_xbox_right_stick_up	 )))
#macro R_AXIS_DOWN		global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_right_stick_down	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_right_stick_down	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_right_stick_down	: spr_xbox_right_stick_down	 )))
#macro R_AXIS_RIGHT		global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_right_stick_right	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_right_stick_right	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_right_stick_right	: spr_xbox_right_stick_right )))
#macro R_AXIS_LEFT		global.current_controller_type == BUTTON_ICON_KEYBOARD ? placeholder_keyboard		: (global.current_controller_type == BUTTON_ICON_PLAYSTATION4 ? spr_ps4_right_stick_left	: (global.current_controller_type == BUTTON_ICON_PLAYSTATION5 ? spr_ps5_right_stick_left	: (global.current_controller_type == BUTTON_ICON_SWITCH ? spr_switch_right_stick_left	: spr_xbox_right_stick_left	 )))
#macro gp_pad "gp_pad"

#macro PS4:BUTTON_SOUTH		spr_ps4_cross_button
#macro PS4:BUTTON_NORTH		spr_ps4_triangle_button
#macro PS4:BUTTON_WEST		spr_ps4_square_button
#macro PS4:BUTTON_EAST		spr_ps4_circle_button
#macro PS4:BUTTON_LEFT		spr_ps4_dpad_left_button
#macro PS4:BUTTON_RIGHT		spr_ps4_dpad_right_button
#macro PS4:BUTTON_UP		spr_ps4_dpad_up_button
#macro PS4:BUTTON_DOWN		spr_ps4_dpad_down_button
#macro PS4:BUTTON_LSTICK	spr_ps4_left_stick_button
#macro PS4:BUTTON_RSTICK	spr_ps4_right_stick_button
#macro PS4:BUTTON_START		spr_ps4_options_button
#macro PS4:BUTTON_SELECT	spr_ps4_touchpad_button
#macro PS4:BUTTON_RBUMPER	spr_ps4_r1_button
#macro PS4:BUTTON_RTRIGGER	spr_ps4_r2_button
#macro PS4:BUTTON_LBUMPER	spr_ps4_l1_button
#macro PS4:BUTTON_LTRIGGER	spr_ps4_l2_button
#macro PS4:BUTTON_DPAD		spr_ps4_dpad
#macro PS4:L_AXIS			spr_ps4_left_stick
#macro PS4:R_AXIS			spr_ps4_right_stick
#macro PS4:L_AXIS_UP		spr_ps4_left_stick_up
#macro PS4:L_AXIS_DOWN		spr_ps4_left_stick_down
#macro PS4:L_AXIS_RIGHT		spr_ps4_left_stick_right
#macro PS4:L_AXIS_LEFT		spr_ps4_left_stick_left
#macro PS4:R_AXIS_UP		spr_ps4_right_stick_up
#macro PS4:R_AXIS_DOWN		spr_ps4_right_stick_down
#macro PS4:R_AXIS_RIGHT		spr_ps4_right_stick_right
#macro PS4:R_AXIS_LEFT		spr_ps4_right_stick_left

#macro PS5:BUTTON_SOUTH		spr_ps5_cross_button
#macro PS5:BUTTON_NORTH		spr_ps5_triangle_button
#macro PS5:BUTTON_WEST		spr_ps5_square_button
#macro PS5:BUTTON_EAST		spr_ps5_circle_button
#macro PS5:BUTTON_LEFT		spr_ps5_dpad_left_button
#macro PS5:BUTTON_RIGHT		spr_ps5_dpad_right_button
#macro PS5:BUTTON_UP		spr_ps5_dpad_up_button
#macro PS5:BUTTON_DOWN		spr_ps5_dpad_down_button
#macro PS5:BUTTON_LSTICK	spr_ps5_left_stick_button
#macro PS5:BUTTON_RSTICK	spr_ps5_right_stick_button
#macro PS5:BUTTON_START		spr_ps5_options_button
#macro PS5:BUTTON_SELECT	spr_ps5_touchpad_button
#macro PS5:BUTTON_RBUMPER	spr_ps5_r1_button
#macro PS5:BUTTON_RTRIGGER	spr_ps5_r2_button
#macro PS5:BUTTON_LBUMPER	spr_ps5_l1_button
#macro PS5:BUTTON_LTRIGGER	spr_ps5_l2_button
#macro PS5:BUTTON_DPAD		spr_ps5_dpad
#macro PS5:L_AXIS			spr_ps5_left_stick
#macro PS5:R_AXIS			spr_ps5_right_stick
#macro PS5:L_AXIS_UP		spr_ps5_left_stick_up
#macro PS5:L_AXIS_DOWN		spr_ps5_left_stick_down
#macro PS5:L_AXIS_RIGHT		spr_ps5_left_stick_right
#macro PS5:L_AXIS_LEFT		spr_ps5_left_stick_left
#macro PS5:R_AXIS_UP		spr_ps5_right_stick_up
#macro PS5:R_AXIS_DOWN		spr_ps5_right_stick_down
#macro PS5:R_AXIS_RIGHT		spr_ps5_right_stick_right
#macro PS5:R_AXIS_LEFT		spr_ps5_right_stick_left


#macro SWITCH:BUTTON_SOUTH		spr_switch_b_button
#macro SWITCH:BUTTON_NORTH		spr_switch_x_button
#macro SWITCH:BUTTON_WEST		spr_switch_y_button
#macro SWITCH:BUTTON_EAST		spr_switch_a_button
#macro SWITCH:BUTTON_LEFT		spr_switch_dpad_left_button
#macro SWITCH:BUTTON_RIGHT		spr_switch_dpad_right_button
#macro SWITCH:BUTTON_UP			spr_switch_dpad_up_button
#macro SWITCH:BUTTON_DOWN		spr_switch_dpad_down_button
#macro SWITCH:BUTTON_LSTICK		spr_switch_left_stick_move
#macro SWITCH:BUTTON_RSTICK		spr_switch_right_stick_button
#macro SWITCH:BUTTON_START		spr_switch_plus_button
#macro SWITCH:BUTTON_SELECT		spr_switch_minus_button
#macro SWITCH:BUTTON_RBUMPER	spr_switch_r_button
#macro SWITCH:BUTTON_RTRIGGER	spr_switch_zr_button
#macro SWITCH:BUTTON_LBUMPER	spr_switch_l_button
#macro SWITCH:BUTTON_LTRIGGER	spr_switch_zl_button
#macro SWITCH:BUTTON_DPAD		spr_switch_dpad
#macro SWITCH:L_AXIS			spr_switch_left_stick
#macro SWITCH:R_AXIS			spr_switch_right_stick
#macro SWITCH:L_AXIS_UP			spr_switch_left_stick_up
#macro SWITCH:L_AXIS_DOWN		spr_switch_left_stick_down
#macro SWITCH:L_AXIS_RIGHT		spr_switch_left_stick_right
#macro SWITCH:L_AXIS_LEFT		spr_switch_left_stick_left
#macro SWITCH:R_AXIS_UP			spr_switch_right_stick_up
#macro SWITCH:R_AXIS_DOWN		spr_switch_right_stick_down
#macro SWITCH:R_AXIS_RIGHT		spr_switch_right_stick_right
#macro SWITCH:R_AXIS_LEFT		spr_switch_right_stick_left


#macro XBOX:BUTTON_SOUTH		spr_xbox_a_button
#macro XBOX:BUTTON_NORTH		spr_xbox_y_button
#macro XBOX:BUTTON_WEST			spr_xbox_x_button
#macro XBOX:BUTTON_EAST			spr_xbox_b_button
#macro XBOX:BUTTON_LEFT			spr_xbox_dpad_left_button
#macro XBOX:BUTTON_RIGHT		spr_xbox_dpad_right_button
#macro XBOX:BUTTON_UP			spr_xbox_dpad_up_button
#macro XBOX:BUTTON_DOWN			spr_xbox_dpad_down_button
#macro XBOX:BUTTON_LSTICK		spr_xbox_left_stick
#macro XBOX:BUTTON_RSTICK		spr_xbox_right_stick
#macro XBOX:BUTTON_START		spr_xbox_menu_button
#macro XBOX:BUTTON_SELECT		spr_xbox_view_button
#macro XBOX:BUTTON_RBUMPER		spr_xbox_rb_button
#macro XBOX:BUTTON_RTRIGGER		spr_xbox_rt_button
#macro XBOX:BUTTON_LBUMPER		spr_xbox_lb_button
#macro XBOX:BUTTON_LTRIGGER		spr_xbox_lt_button
#macro XBOX:BUTTON_DPAD			spr_xbox_dpad
#macro XBOX:L_AXIS				spr_xbox_left_stick
#macro XBOX:R_AXIS				spr_xbox_right_stick
#macro XBOX:L_AXIS_UP			spr_xbox_left_stick_up
#macro XBOX:L_AXIS_DOWN			spr_xbox_left_stick_down
#macro XBOX:L_AXIS_RIGHT		spr_xbox_left_stick_right
#macro XBOX:L_AXIS_LEFT			spr_xbox_left_stick_left
#macro XBOX:R_AXIS_UP			spr_xbox_right_stick_up
#macro XBOX:R_AXIS_DOWN			spr_xbox_right_stick_down
#macro XBOX:R_AXIS_RIGHT		spr_xbox_right_stick_right
#macro XBOX:R_AXIS_LEFT			spr_xbox_right_stick_left
is_keyboard = false;


global.deadzone = 0.350;

switch(os_type)
{
	case os_switch:
		global.current_controller_type = BUTTON_ICON_SWITCH;
	break;
	case os_ps4:
		global.current_controller_type = BUTTON_ICON_PLAYSTATION4;
	break;
	case os_ps5:
		global.current_controller_type = BUTTON_ICON_PLAYSTATION5;
	break;
	case os_xboxone:
	case os_xboxseriesxs:
		global.current_controller_type = BUTTON_ICON_XBOX;
	break;
	case os_windows:
		global.current_controller_type = BUTTON_ICON_KEYBOARD;
	break;
}
	
	
south_pressed = noone;
east_pressed = noone;
north_pressed = noone;
west_pressed = noone;
	
right_bumper_pressed = noone;
right_trigger_pressed = noone;
left_bumper_pressed = noone;
left_trigger_pressed = noone;

start_pressed = noone;
select_pressed = noone;

confirm_button_pressed = noone;
cancel_button_pressed = noone;

left_stick_pressed = noone;
right_stick_pressed = noone;

up_pressed = noone;
down_pressed = noone;
left_pressed = noone;
right_pressed = noone;

up_axis = noone;
down_axis = noone;
right_axis = noone;
left_axis = noone;

up_axis_pressed_buffer = noone;
down_axis_pressed_buffer = noone;
right_axis_pressed_buffer = noone;
left_axis_pressed_buffer = noone;

/////////////////////////////////////////////
/////////////////////////////////////////////

x_axis = noone;
y_axis = noone;

south = noone;
east = noone;
north = noone;
west = noone;

right_bumper = noone;
right_trigger = noone;
left_bumper = noone;
left_trigger = noone;

start = noone;
select = noone;

confirm_button = noone;
cancel_button = noone;

left_stick = noone;
right_stick = noone;

up = noone;
down = noone;
left = noone;
right = noone;

up_axis_pressed = noone;
down_axis_pressed = noone;
right_axis_pressed = noone;
left_axis_pressed = noone;

up_axis = noone;
down_axis= noone;
right_axis = noone;
left_axis = noone;



update_input = function(){
	
	if(is_keyboard){
		keyboard_input_check();
		keyboard_input_check_pressed();
	}
	else{
		update_input_check();
		update_input_pressed();
	}
	
}

keyboard_input_check = function(){
	up = keyboard_check(ord("W")) || keyboard_check(vk_up);
	down = keyboard_check(ord("S")) || keyboard_check(vk_down);
	right = keyboard_check(ord("D")) || keyboard_check(vk_right);
	left = keyboard_check(ord("A")) || keyboard_check(vk_left);
	
	start = keyboard_check(vk_escape);
	south = keyboard_check(vk_space);
	north = keyboard_check(ord("R"));
	west = keyboard_check(vk_shift);
	
	confirm_button =  keyboard_check(vk_enter)
}

keyboard_input_check_pressed = function(){
	confirm_button_pressed =  keyboard_check_pressed(vk_enter)
	cancel_button_pressed =  keyboard_check_pressed(vk_backspace)
	start_pressed = keyboard_check_pressed(vk_escape);
	south_pressed = keyboard_check_pressed(vk_space);
	north_pressed = keyboard_check_pressed(ord("R"));
	west_pressed = keyboard_check_pressed(vk_shift);
	
	up_pressed = keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up)
	down_pressed = keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)
	right_pressed = keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right)
	left_pressed = keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left)
}


update_input_check = function(){
x_axis = gamepad_axis_value(global.pad_by_player[0], gp_axislh);
y_axis = gamepad_axis_value(global.pad_by_player[0], gp_axislv);

south = gamepad_button_check(global.pad_by_player[0], gp_face1);
east = gamepad_button_check(global.pad_by_player[0], gp_face2);
west = gamepad_button_check(global.pad_by_player[0], gp_face3);
north = gamepad_button_check(global.pad_by_player[0], gp_face4);

right_bumper = gamepad_button_check(global.pad_by_player[0], gp_shoulderr);
right_trigger = gamepad_button_check(global.pad_by_player[0], gp_shoulderrb);
left_bumper = gamepad_button_check(global.pad_by_player[0], gp_shoulderl);
left_trigger = gamepad_button_check(global.pad_by_player[0], gp_shoulderlb);

confirm_button = gamepad_button_check(global.pad_by_player[0], global.confirm_button);
cancel_button = gamepad_button_check(global.pad_by_player[0], global.cancel_button);

start = gamepad_button_check(global.pad_by_player[0], gp_start);
select = gamepad_button_check(global.pad_by_player[0], gp_select);

left_stick = gamepad_button_check(global.pad_by_player[0], gp_stickl);
right_stick = gamepad_button_check(global.pad_by_player[0], gp_stickr);

up = gamepad_button_check(global.pad_by_player[0], gp_padu) || gamepad_axis_value(global.pad_by_player[0], gp_axislv) < -global.deadzone;
down = gamepad_button_check(global.pad_by_player[0], gp_padd) ||  gamepad_axis_value(global.pad_by_player[0], gp_axislv) > global.deadzone;
right = gamepad_button_check(global.pad_by_player[0], gp_padr) || gamepad_axis_value(global.pad_by_player[0], gp_axislh) > global.deadzone;
left = gamepad_button_check(global.pad_by_player[0], gp_padl) || gamepad_axis_value(global.pad_by_player[0], gp_axislh) < -global.deadzone;

up_axis = gamepad_axis_value(global.pad_by_player[0], gp_axislv) < -global.deadzone;
down_axis = gamepad_axis_value(global.pad_by_player[0], gp_axislv) > global.deadzone;
right_axis = gamepad_axis_value(global.pad_by_player[0], gp_axislh) > global.deadzone;
left_axis = gamepad_axis_value(global.pad_by_player[0], gp_axislh) < -global.deadzone;
}

update_input_pressed = function(){
	
south_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_face1);
east_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_face2);
west_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_face3);
north_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_face4);

right_bumper_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_shoulderr);
right_trigger_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_shoulderrb);
left_bumper_pressed	= gamepad_button_check_pressed(global.pad_by_player[0], gp_shoulderl);
left_trigger_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_shoulderlb);

confirm_button_pressed = gamepad_button_check_pressed(global.pad_by_player[0], global.confirm_button);
cancel_button_pressed = gamepad_button_check_pressed(global.pad_by_player[0], global.cancel_button);


start_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_start) ;
select_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_select);

left_stick_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_stickl);
right_stick_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_stickr);

up_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_padu) || gamepad_axis_value(global.pad_by_player[0], gp_axislv) < -global.deadzone && !up_axis_pressed_buffer;
down_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_padd) || gamepad_axis_value(global.pad_by_player[0], gp_axislv) > global.deadzone && !down_axis_pressed_buffer;
right_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_padr) || gamepad_axis_value(global.pad_by_player[0], gp_axislh) > global.deadzone && !right_axis_pressed_buffer;
left_pressed = gamepad_button_check_pressed(global.pad_by_player[0], gp_padl) || gamepad_axis_value(global.pad_by_player[0], gp_axislh) < -global.deadzone && !left_axis_pressed_buffer;
		
up_axis_pressed = gamepad_axis_value(global.pad_by_player[0], gp_axislv) < -global.deadzone && !up_axis_pressed_buffer ? gamepad_axis_value(global.pad_by_player[0], gp_axislv) : 0;
down_axis_pressed = gamepad_axis_value(global.pad_by_player[0], gp_axislv) > global.deadzone && !down_axis_pressed_buffer ? gamepad_axis_value(global.pad_by_player[0], gp_axislv) : 0;
right_axis_pressed = gamepad_axis_value(global.pad_by_player[0], gp_axislh) > global.deadzone && !right_axis_pressed_buffer ? gamepad_axis_value(global.pad_by_player[0], gp_axislv) : 0;
left_axis_pressed = gamepad_axis_value(global.pad_by_player[0], gp_axislh) < -global.deadzone && !left_axis_pressed_buffer ? gamepad_axis_value(global.pad_by_player[0], gp_axislv) : 0;
		
up_axis_pressed_buffer = gamepad_axis_value(global.pad_by_player[0], gp_axislv) < -global.deadzone;
down_axis_pressed_buffer = gamepad_axis_value(global.pad_by_player[0], gp_axislv) > global.deadzone;
right_axis_pressed_buffer = gamepad_axis_value(global.pad_by_player[0], gp_axislh) > global.deadzone;
left_axis_pressed_buffer = gamepad_axis_value(global.pad_by_player[0], gp_axislh) < -global.deadzone;

}


get_input_glyph = function(input, axis_value = 0){
	switch(input){
		case gp_pad:
		return BUTTON_DPAD;
		
		case gp_face1:
		if(global.enter_button_assign == 1)
			return BUTTON_SOUTH;
		else
			return BUTTON_EAST;	

		
		case gp_face2:
		if(global.enter_button_assign == 0)
			return BUTTON_SOUTH;
		else
			return BUTTON_EAST;
		
		case gp_face3:
		return BUTTON_WEST; 
		
		case gp_face4:
		return BUTTON_NORTH; 
		
		case gp_shoulderl:
		return BUTTON_LBUMPER; 
		
		case gp_shoulderlb:
		return BUTTON_LTRIGGER; 
		
		case gp_shoulderr:
		return BUTTON_RBUMPER; 
		
		case gp_shoulderrb:
		return BUTTON_RTRIGGER; 
		
		case gp_padu:
		return BUTTON_UP; 
		
		case gp_padd:
		return BUTTON_DOWN; 
		
		case gp_padl:
		return BUTTON_LEFT; 
		
		case gp_padr:
		return BUTTON_RIGHT; 
		
		case gp_select:
		return BUTTON_SELECT; 
		
		case gp_start:
		return BUTTON_START; 
		
		case gp_stickl:
		return BUTTON_LSTICK; 
		
		case gp_stickr:
		return BUTTON_RSTICK; 
		
		case gp_axislh:
			if(axis_value > 0)
				return L_AXIS_RIGHT; 
			else if(axis_value < 0)
				return L_AXIS_LEFT; 
			else
				return L_AXIS; 
				
		case gp_axislv:
			if(axis_value < 0)
				return L_AXIS_UP; 
			else if(axis_value > 0)
				return L_AXIS_DOWN; 
			else
				return L_AXIS; 
		
		case gp_axisrh:
			if(axis_value > 0)
				return R_AXIS_RIGHT; 
			else if(axis_value < 0)
				return R_AXIS_LEFT; 
			else
				return R_AXIS; 
		
		case gp_axisrv:
			if(axis_value < 0)
				return R_AXIS_UP; 
			else if(axis_value > 0)
				return R_AXIS_DOWN; 
			else
				return R_AXIS; 
	}
}

set_controller_type = function(_slot){
	global.pad_by_player[0] = _slot;
	switch (os_type)
	{
		case os_ps4:
			global.current_controller_type = BUTTON_ICON_PLAYSTATION4;
			break;
		case os_ps5:
			global.current_controller_type = BUTTON_ICON_PLAYSTATION5;
			break;
		case os_switch:
			global.current_controller_type = BUTTON_ICON_SWITCH;
			break;
		case os_xboxone:
		case os_xboxseriesxs:
			global.current_controller_type = BUTTON_ICON_XBOX;
			break;
		default:
			
			if (string_count("SONY",string_upper(gamepad_get_description(_slot))) > 0){
				global.current_controller_type = BUTTON_ICON_PLAYSTATION4;
			} else {
				global.current_controller_type = BUTTON_ICON_XBOX;
			}
			if(is_keyboard)
				global.current_controller_type = BUTTON_ICON_KEYBOARD;
		break;
	}
	__input_connect_gamepad(global.pad_by_player[0]);
}