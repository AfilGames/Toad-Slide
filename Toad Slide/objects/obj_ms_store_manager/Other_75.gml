if(async_load[? "event_type"] == "user signed in"){
	global.user_id =  xboxone_get_activating_user();	
	xboxone_set_savedata_user(global.user_id)
	ini_open( "last.ini" );
	ini_write_string( "last", "lastt_player",string( global.user_id ));
	ini_close();
}