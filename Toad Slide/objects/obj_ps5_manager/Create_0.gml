show_debug_message("obj_ps5_manager")

porting_init_libs = function(){
	show_debug_message("porting_init_libs")
	window_set_size(1920,1080)
	
	psn_load_modules();
	porting_init_user();
	porting_set_assigned_enter_button();
	porting_set_cancel_button_value();
	porting_set_confirm_button_value();
}

porting_init_user = function(){
	global.user_id = psn_account_id_for_pad(global.pad_by_player[0])
	global.user_name = psn_name_for_pad(global.pad_by_player[0])
	psn_init_trophy(global.pad_by_player[0]);
	porting_loadgamedata();	

}

porting_close_user = function(){
	global.user_id = noone;
	global.savedata = noone;
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

porting_unlock_achievements = function(_trophy_id){
	psn_unlock_trophy(global.pad_by_player[0], _trophy_id);
}

porting_set_confirm_button_value = function(){
	if(global.enter_button_assign == 0)
		global.confirm_button = gp_face2;
	else
		global.confirm_button = gp_face1;
}

porting_online_events_stats = function(){
	psn_tick();
	psn_tick_error_dialog();
}

porting_online_connection = function(){

}

porting_online_disconnection = function(){

}

porting_upload_leaderboard = function(_leaderboard_id){
	var _result = psn_check_np_availability(global.pad_by_player[0], true);
	
	if(_result >= 0){
		show_debug_message(string(_leaderboard_id) + " = _leaderboard_id - psn_check_np_availability = true")
		psn_post_leaderboard_score(global.pad_by_player[0], _leaderboard_id,global.score_to_post);
	}
}

porting_get_single_leaderboard = function(_leaderboard_id){
	var _result = psn_check_np_availability(global.pad_by_player[0], true);
	
	if(_result >= 0){
	psn_get_leaderboard_score(global.pad_by_player[0],_leaderboard_id);
	}
}

porting_get_leaderboard_range = function(_leaderboard_id){
	var _result = psn_check_np_availability(global.pad_by_player[0], true);
	
	if(_result >= 0){
		psn_get_leaderboard_score_range(global.pad_by_player[0],_leaderboard_id,1,10);
	}
}

porting_reset_leaderboard_range = function(_first_index, _last_index){
	_private_porting_reset_leaderboards_by_range(_first_index, _last_index);
}

porting_set_cancel_button_value = function(){
	if(global.enter_button_assign == 0)
		global.cancel_button = gp_face1;
	else
		global.cancel_button = gp_face2;
}

porting_set_assigned_enter_button = function(){
	global.enter_button_assign = 1; // 0 for Circle - 1 for Cross
}

porting_activity_update = function(activity_status){
	var uds_map = ds_map_create();
	if(activity_status == "Start"){
		ds_map_add(uds_map,"activityId","MainStory");
		psn_post_uds_event(global.pad_by_player[0],"activityStart",uds_map);
	}
	else if(activity_status == "End"){
		ds_map_add(uds_map,"activityId","MainStory");
		ds_map_add(uds_map,"outcome","completed");
		psn_post_uds_event(global.pad_by_player[0],"activityEnd",uds_map);
	}
	else if(activity_status == "Launch"){
		global.__level_load = global.activity_level_launch;
		room_goto(rm_level)
		global.isLaunchingActvity = false;
	}
	
	ds_map_destroy(uds_map);
}

porting_loadgamedata = function(){
	global.loadbuff = buffer_create(1,buffer_grow, 1);
	show_debug_message("loadbuff");
	
	buffer_async_group_begin("asyncsavegroup");
	if(os_type == os_ps4 or os_type == os_ps5){
			buffer_async_group_option("savepadindex", 0);
		if(os_type == os_ps5)
		{
			buffer_async_group_option("ps5_retrysavewhennospace", false);
			buffer_async_group_option("ps5_nospace_dialog", true); 
		}
	}
	buffer_async_group_option("showdialog",0);
	buffer_async_group_option("slottitle", global.game_title);

	buffer_load_async(global.loadbuff,global.filename,0,-1);
	show_debug_message("buffer_load_async");			
	
	global.load_id = buffer_async_group_end();
	show_debug_message("buffer_async_group_end");	
}

porting_savegamedata = function(){
	global.save_load.porting_write_data();
	
	buffer_async_group_begin("asyncsavegroup");
	
	if(os_type == os_ps4 or os_type == os_ps5){
			buffer_async_group_option("savepadindex", 0);
		if(os_type == os_ps5)
		{
			buffer_async_group_option("ps5_retrysavewhennospace", false);
			buffer_async_group_option("ps5_nospace_dialog", true); 
		}
	}
	
	buffer_async_group_option("showdialog",0);
	buffer_async_group_option("slottitle", global.game_title);
	
	global.savebuff = buffer_create(1, buffer_grow,1);
	buffer_write(global.savebuff, buffer_string, global.savedata);
	buffer_save_async(global.savebuff,global.filename,0,buffer_get_size(global.savebuff));
	
	global.save_id = buffer_async_group_end();
}