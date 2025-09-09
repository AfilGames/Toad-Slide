function porting_check_any_button_pressed_by_pad(_pad_value){

	if(gamepad_button_check_pressed(_pad_value,gp_face1) or gamepad_button_check_pressed(_pad_value,gp_face2))
		return true;

	if(gamepad_button_check_pressed(_pad_value,gp_face3) or gamepad_button_check_pressed(_pad_value,gp_face4))
		return true;

	if(gamepad_button_check_pressed(_pad_value,gp_padr) or gamepad_button_check_pressed(_pad_value,gp_padd))
		return true;

	if(gamepad_button_check_pressed(_pad_value,gp_padl) or gamepad_button_check_pressed(_pad_value,gp_padu))
		return true;

	if(gamepad_button_check_pressed(_pad_value,gp_shoulderl) or gamepad_button_check_pressed(_pad_value,gp_shoulderlb))
		return true;

	if(gamepad_button_check_pressed(_pad_value,gp_shoulderr) or gamepad_button_check_pressed(_pad_value,gp_shoulderrb))
		return true;
		
	if(gamepad_button_check_pressed(_pad_value,gp_start) or gamepad_button_check_pressed(_pad_value,gp_select))
		return true;

	if(gamepad_button_check_pressed(_pad_value,gp_stickl) or gamepad_button_check_pressed(_pad_value,gp_stickr))
		return true;
		
	if( gamepad_axis_value(_pad_value, gp_axislv) < -global.deadzone)
		return true;
		
	if( gamepad_axis_value(_pad_value, gp_axislv) > global.deadzone)
	 return true;
	 
	if(gamepad_axis_value(_pad_value, gp_axislh) > global.deadzone)
	  return true;
	 
	if(gamepad_axis_value(_pad_value, gp_axislh) < -global.deadzone)
		return true;
}

function porting_get_unasigned_player(){
	for(var _player_index = 0; _player_index <= global.max_pad_number; _player_index++){
		if(!global.player_signed_in[_player_index]){
			return _player_index;
		}
	}
}

function porting_get_number_of_connected_players(){
	var number_of_connected_players = 0;
	for(var _player_index = 0; _player_index <= global.last_player_index; _player_index++){
		if(global.player_signed_in[_player_index])
			number_of_connected_players ++;
	}
	return number_of_connected_players;
}