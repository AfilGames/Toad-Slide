gdk_update();

//if(global.internet == "ok"){
//	if(room != room_init){
//		for(var i = 0; i < array_length(global.can_unlock_achievement); i++){
//				if(!global.can_unlock_achievement[i] && season_achieve[i]){
//					var _result = xboxone_achievements_set_progress(global.user_id, i, 100)
//					if(_result > 0)
//						season_achieve[i] = false;
//				}
//		}
//	}
//}

if(global.user_id != pointer_null){
var atual = xboxone_get_savedata_user();
	if (xboxone_get_savedata_user() != global.user_id)
	{
	    var _error = xboxone_set_savedata_user(global.user_id);
	}else{
		if(global.inLoad == false)
			porting_loadgamedata();	
	}
}


if(!window_has_focus()){
	if(!global.hasPaused){
		global.forcePause = true;
		global.hasPaused = true;
	}
}else{
	global.forcePause = false;
	global.hasPaused = false;
}