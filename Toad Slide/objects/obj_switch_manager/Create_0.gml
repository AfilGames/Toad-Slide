show_debug_message("obj_switch_manager")

porting_init_libs = function(){
	porting_init_user();
	porting_set_assigned_enter_button();
	porting_set_confirm_button_value();
	porting_set_cancel_button_value();
	porting_set_default_pad_config();
}

porting_set_default_pad_config = function(){
	var _is_single_player = true;
	var _min_player, _max_player;
	_min_player = 1;
	_max_player = 1;
	
	//global.holdtype[0] = switch_controller_joycon_holdtype_vertical;
	//global.holdtype[1] = switch_controller_joycon_holdtype_horizontal;
	
	switch_controller_support_set_defaults();
	//switch_controller_joycon_set_holdtype(global.holdtype[_holdtype_index]);
	porting_set_pad_info(_is_single_player, _min_player, _max_player);
}

porting_set_pad_info = function(_is_single_player, _min_player, _max_player){
	var	_styles = switch_controller_joycon_dual | switch_controller_pro_controller | switch_controller_handheld;
	switch_controller_set_supported_styles(_styles);
	
	switch_controller_support_set_singleplayer_only(_is_single_player);
	switch_controller_support_set_player_min(_min_player);
	switch_controller_support_set_player_max(_max_player);
}

porting_init_user = function(){
	global.user_id = switch_accounts_open_preselected_user();
	global.user_name = switch_accounts_get_nickname(global.user_id);
}

porting_close_user = function(){
	global.user_id = noone;
	global.savedata = noone;
}

porting_unlock_achievements = function(arg){
	
}

porting_check_suspend = function(){
	
}

porting_check_constrain = function(){
	if(os_is_paused()){
		//Pause Function here
	}
}

porting_can_check_user = function(){

}

porting_check_user = function(){

}

porting_upload_leaderboard = function(argument0){
	var _leaderboard_id = argument0;
	
	if(global.is_connected){
		switch_leaderboard_post_common_data(global.user_id,global.user_name);
		show_debug_message("post_common_data")
		switch_leaderboard_post_score(global.user_id, _leaderboard_id, global.score_to_post);
		show_debug_message(string(_leaderboard_id) + " = _leaderboard_id " + "-" + " post_score")
	}
}

porting_online_events_stats = function(){
	if(!switch_accounts_is_user_online(global.user_id) and global.can_connect){
		porting_online_disconnection();
	}
}

porting_online_connection = function(){
	if(!global.can_connect)
		global.can_connect = switch_accounts_login_user(global.user_id);
	if(global.can_connect && !global.is_connected){
		show_debug_message("global.can_connect = true")
		var result = switch_gameserver_login_user(global.user_id, 0x2FB3F700, "3Ug3jwjL");
		show_debug_message(string(result) + " = result")
	}
}

porting_online_disconnection = function(){
	if(global.is_connected)
		switch_gameserver_logout_user(global.user_id);
}

porting_get_single_leaderboard = function(argument0){
	var _leaderboard_id = argument0;
}

porting_get_leaderboard_range = function(argument0){
	var _leaderboard_id = argument0;
		if(global.is_connected and can_get_leaderboard()){
			show_debug_message(string(_leaderboard_id) + "_leaderboard_id")
			switch_leaderboard_get_scores(global.user_id,_leaderboard_id,switch_leaderboard_type_anybody,10,0);
		}
}

porting_reset_leaderboard_range = function(argument0, argument1){
	var _first_index = argument0;
	var _last_index = argument1;
	_private_porting_reset_leaderboards_by_range(_first_index, _last_index);
}

porting_set_confirm_button_value = function(){
	if(global.enter_button_assign == 0)
		global.confirm_button = gp_face2;
	else
		global.confirm_button = gp_face1;
}

porting_set_cancel_button_value = function(){
	if(global.enter_button_assign == 0)
		global.cancel_button = gp_face1;
	else
		global.cancel_button = gp_face2;
}

porting_set_assigned_enter_button = function(){
	global.enter_button_assign = 0; // 0 for A Button - B for Cross
}

porting_activity_update = function(activity_status){
	
	
	
}

porting_loadgamedata = function(){
	switch_save_data_mount(global.user_id)
	global.loadbuff = buffer_create(1,buffer_grow, 1);
	show_debug_message("loadbuff");
	
	buffer_async_group_begin("asyncsavegroup");

	buffer_async_group_option("showdialog",0);
	buffer_async_group_option("slottitle", global.game_title);

	buffer_load_async(global.loadbuff, global.filename,0,-1);
	show_debug_message("buffer_load_async");			
	
	global.load_id = buffer_async_group_end();
	show_debug_message("buffer_async_group_end");	
}

porting_savegamedata = function(){
	switch_save_data_mount(global.user_id)
	global.save_load.porting_write_data();
	
	buffer_async_group_begin("asyncsavegroup");
	
	buffer_async_group_option("showdialog",0);
	buffer_async_group_option("slottitle", global.game_title);
	
	global.savebuff = buffer_create(1, buffer_grow,1);
	buffer_write(global.savebuff, buffer_string, global.savedata);
	buffer_save_async(global.savebuff, global.filename,0,buffer_get_size(global.savebuff));
	
	global.save_id = buffer_async_group_end();
}

porting_loadgamedata();