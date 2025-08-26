show_debug_message("obj_windows_manager")
global.forcePause = false;
porting_init_libs = function(){

	porting_set_assigned_enter_button();
	porting_set_confirm_button_value();
	porting_set_cancel_button_value();
}

porting_init_user = function(){

}

porting_close_user = function(){

}

porting_unlock_achievements = function(argument0){
	//show_debug_message("You Unlock the achievement number: " + string(argument0));

}

porting_check_suspend = function(){

}

porting_check_constrain = function(){

}

porting_can_check_user = function(){
	//Check Where and When can check the user disconnection
	return true;
	//else
	//return false;
}

porting_check_user = function(){

}

porting_online_events_stats = function(){

}

porting_online_connection = function(){

}

porting_online_disconnection = function(){

}

porting_upload_leaderboard = function(argument0){

}

porting_get_single_leaderboard = function(argument0){

}

porting_get_leaderboard_range = function(argument0){

}

porting_reset_leaderboard_range = function(argument0, argument1){

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
	global.load_id = buffer_load_async(global.loadbuff, global.filename, -1, 16384);
}

porting_savegamedata = function(){
	global.save_load.porting_write_data();
	global.savebuff = buffer_create(1, buffer_grow,1);
	buffer_write(global.savebuff, buffer_string, global.savedata);
	buffer_save_async(global.savebuff,global.filename,0,buffer_get_size(global.savebuff));		
}

function LaunchActivity(_intentId){
	
}

porting_loadgamedata();