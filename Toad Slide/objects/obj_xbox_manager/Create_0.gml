show_debug_message("obj_xbox_manager")
global.forcePause = false;
var inForcePause = false;
porting_init_libs = function(){
	porting_set_assigned_enter_button();
	porting_set_confirm_button_value();
	porting_set_cancel_button_value();
}

porting_init_user = function(){
	xboxlive_show_account_picker();	
}

porting_close_user = function(){
	global.user_id = noone;
	global.savedata = noone;
}

porting_unlock_achievements = function(_trophy_id){
	xboxone_achievements_set_progress(global.user_id, string(_trophy_id), 100);
}

porting_check_suspend = function(){
	if(xboxone_is_suspending()){
		//Pause Function before the suspend function
		xboxone_suspend();
	}
	
	
}

porting_check_constrain = function(){

	if(xboxone_is_constrained()){
		//Pause Function here
		if(!inForcePause){
			inForcePause = true;
			global.forcePause = true;
		}
	}else{
		inForcePause = false;	
		global.forcePause = false;
	}
	
}

porting_can_check_user = function(){
	//Check Where and When can check the user disconnection
	return true;
	//else
	//return false;
}

porting_check_user = function(){
	if(porting_can_check_user()){
		if(!xboxone_user_is_signed_in(global.user_id)){	
			porting_close_user();
			set_variables_to_default();
		}
	}	
}

porting_online_events_stats = function(){

}

porting_online_connection = function(){

}

porting_online_disconnection = function(){

}

porting_upload_leaderboard = function(_leaderboard_id){
	var result = xboxone_stats_set_stat_int(global.user_id, string(_leaderboard_id), global.score_to_post);
	
	if(result != -1)
		show_debug_message(string(_leaderboard_id) + " = _leaderboard_id - posted")
}

porting_get_single_leaderboard = function(_leaderboard_id){

}

porting_get_leaderboard_range = function(_leaderboard_id){
	if(can_get_leaderboard())
		xboxone_stats_get_leaderboard(global.user_id, string(_leaderboard_id), 10, 0, false, false);
}

porting_reset_leaderboard_range = function(_first_index, _last_index){
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
	global.enter_button_assign = 1; //0 for Circle - 1 for Cross
}

porting_activity_update = function(activity_status){
	
	
	
}

porting_loadgamedata = function(){
	global.loadbuff = buffer_create(1,buffer_grow, 1);
	show_debug_message("loadbuff");
	
	buffer_async_group_begin("asyncsavegroup");
	
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
	
	buffer_async_group_option("showdialog",0);
	buffer_async_group_option("slottitle", global.game_title);
	
	global.savebuff = buffer_create(1, buffer_grow,1);
	buffer_write(global.savebuff, buffer_string, global.savedata);
	buffer_save_async(global.savebuff,global.filename,0,buffer_get_size(global.savebuff));
	
	global.save_id = buffer_async_group_end();
}