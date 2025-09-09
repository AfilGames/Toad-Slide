
	for(var i = 0; i < 8; i++)
	{
		if(porting_check_any_button_pressed_by_pad(i))
		{
			if(global.first_input == true && global.pad_by_player[0] == i)
			{
				continue;	
			}
			global.disconnected_controller = false;
			global.first_input = true;
			global.pad_by_player[0] = i;
			break;
		}
	}

if(!global.first_input){
	global.disconnected_controller = false;
	if(os_type != os_ps4 && os_type != os_ps5){
		if(gamepad_get_device_count() > 0 && gamepad_is_connected(0)){
			is_keyboard = false;
			set_controller_type(0);
			global.first_input = true;
			global.porting_pause = false;
			global.pad_by_player[0] = 0;	
		}else{
			if(os_type == os_windows){
				is_keyboard = true;	
				global.first_input = true;
				global.porting_pause = false;
				global.pad_by_player[0] = 0;
			}
		}
	}
	exit;

}
global.porting_pause = false;
if(os_type == os_xboxone || os_type == os_xboxseriesxs){
	is_keyboard = false;
	if(global.disconnected_controller){
		for(var i = 0; i < gamepad_get_device_count(); i++)
		{
			if(porting_check_any_button_pressed_by_pad(i))
			{
				global.porting_pause = false;
				global.pad_by_player[0] = i;
				break;
			}
		}
	}
}

#region Check Input

if(os_type == os_windows)
{
	for(var i = 0; i < gamepad_get_device_count(); i++)
	{	
		if(keyboard_check_pressed(vk_anykey)){
			is_keyboard = true
			global.porting_pause = false;
			global.current_controller_type = BUTTON_ICON_KEYBOARD;
		}
		else if(porting_check_any_button_pressed_by_pad(i)){
			is_keyboard = false;
			global.porting_pause = false;
			global.current_controller_type = BUTTON_ICON_XBOX;
		}
	}
}

#endregion

if(!gamepad_is_connected(global.pad_by_player[0]) and !is_keyboard)
{
	if(global.disconnected_controller == false)
		show_debug_message("Sem joy ");
	if(os_type != os_windows){
		if(os_type == os_switch){
		    var _result = switch_controller_support_show();
		    if(_result == 0)
		        global.pad_by_player[0] = switch_controller_support_get_selected_id()
		}
	}
	global.disconnected_controller = true;
	global.porting_pause = true;
}
else
	global.disconnected_controller = false;
	
if(!global.disconnected_controller){
	update_input();
}


