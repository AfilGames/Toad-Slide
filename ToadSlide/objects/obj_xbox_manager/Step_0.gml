porting_check_suspend();

if(global.user_id != pointer_null){
//var atual = xboxone_get_savedata_user();
	if (xboxone_get_savedata_user() != global.user_id)
	{
	    var _error = xboxone_set_savedata_user(global.user_id);
	}else{
		if(global.load_finished == false){
			porting_loadgamedata();	
			global.user_name = xboxlive_gamedisplayname_for_user(global.user_id);
			show_debug_message(string(global.user_name) + " = user_name");	
		}
	}
}