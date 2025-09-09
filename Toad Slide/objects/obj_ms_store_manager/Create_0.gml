show_debug_message("obj_mss_manager")
global.load_finished = false;
global.forcePause = false;
global.hasPaused = false;
season_achieve = array_create(99, true)
ah_btc = -1;
global.inLoad = false;
global.internet = "";
global.loadbuffOf = noone;
global.load_idOff = -1;

porting_init_libs = function(){
	porting_set_assigned_enter_button();
	porting_set_confirm_button_value();
	porting_set_cancel_button_value();
	var _scid = global.scid;
	gdk_init(_scid);
	checkOffline();
}

checkOffline = function(){
	ah_btc = http_get("https://www.microsoft.com");	
}

porting_init_user = function(){
	//xboxone_show_account_picker()
}

porting_close_user = function(){
	global.user_id = noone;
	global.savedata = noone;
}

porting_unlock_achievements = function(_trophy_id){
	global.can_unlock_achievement[_trophy_id] = false;
	xboxone_achievements_set_progress(global.user_id, string(_trophy_id), 100);
	SaveAchievements();
}

porting_check_suspend = function(){
	if(xboxone_is_suspending()){
		//Pause Function before the suspend function
		xboxone_suspend();
	}
}

porting_check_constrain = function(){
	if(os_is_paused() or !window_has_focus()){
		//Pause Function here
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

porting_set_assigned_enter_button = function(){
	global.enter_button_assign = 1; //0 for Circle - 1 for Cross
}

porting_set_cancel_button_value = function(){
	if(global.enter_button_assign == 0)
		global.cancel_button = gp_face1;
	else
		global.cancel_button = gp_face2;
}

porting_set_confirm_button_value = function(){
	if(global.enter_button_assign == 0)
		global.confirm_button = gp_face2;
	else
		global.confirm_button = gp_face1;
}

porting_loadgamedata = function(){
	//Primeiro arregamos o save offline
	loadOfflline();
	//Se não tem internet barra para evitar que o save seja sobreescrito
	if(global.internet == "fail"){
		global.inLoad = true;
		return;	
	}
    xboxone_set_savedata_user(global.user_id);
	show_debug_message("Load: " + string( global.filename));			
	queue_load("multi/" + string( global.filename));
	//global.load_id = gdk_load_buffer(global.loadbuff,  string(global.user_id) +  string( global.filename), -1, 16384);
	global.inLoad = true;
	LoadAchievements();
}

porting_savegamedata = function(){
	global.save_load.porting_write_data();
	 xboxone_set_savedata_user(global.user_id);
	global.savebuff = buffer_create(1, buffer_grow,1);	
	buffer_write(global.savebuff, buffer_text, global.savedata);
	//Grava online
	windowsSaveGroup(global.savebuff);
	//Grava offline
	saveOffline();
}
windowsSaveGroup = function(_b2) {
	gdk_save_group_begin("multi");
	gdk_save_buffer(_b2, string( global.filename), 0, buffer_tell(_b2));
	global.save_id = gdk_save_group_end();				
}
function queue_load(_filename)
{	
	global.loadbuff = buffer_create(1, buffer_grow, 1);
	global.load_id = gdk_load_buffer(global.loadbuff, _filename, 0, 16384);
		
}

loadOfflline = function(){
	if(global.internet == "fail"){
		if(file_exists("last.ini")){
			ini_open( "last.ini" );
			global.user_id = ini_read_string( "last", "lastt_player", "000" );
			ini_close();
		}
	}
	
	global.loadbuffOf = buffer_create(1,buffer_grow, 1);
	global.load_idOff = buffer_load_async(global.loadbuffOf,string(global.user_id) + string( global.filename) ,0,16384);
	
}
saveOffline = function(){
	buffer_save_async(global.savebuff,string(global.user_id) +  string( global.filename),0,buffer_get_size(global.savebuff));
}

porting_activity_update = function(activity_status = "Launch"){

}

SaveAchievements = function(){
	
	var achievemets = {
		list: global.can_unlock_achievement	
	}
	var j = json_stringify(achievemets);
	var bb = buffer_create(1, buffer_grow,1);	
	buffer_write(bb, buffer_text, j);
	buffer_save(bb,"Achi_" + string(global.user_id) +  string( global.filename)); 
	/*ini_open("Achi_" + string(global.user_id) +  string( global.filename));
	ini_write_string("Save", "Achievements", j);
	ini_close();*/
}

LoadAchievements = function(){
	if(room == room_init)
	return;
	var fn = "Achi_" + string(global.user_id) +  string( global.filename);
	

		var buf = buffer_load(fn);	
		if(buffer_exists(buf)){
			var j = buffer_read(buf, buffer_text);
			if(string_length(j) > 2){
				var obj = json_parse(j);
				global.can_unlock_achievement = obj.list;
				for (var i = 0; i < array_length(global.can_unlock_achievement); i++)
				{		
					if(global.can_unlock_achievement[i] == false){
						show_debug_message("Check achievement: " + string(i));
						xboxone_achievements_set_progress(global.user_id, string(i), 100);
						//global.current_platform.porting_unlock_achievements(i);		
					}
				}
			}
		}
}