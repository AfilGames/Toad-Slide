show_debug_message(string(async_load[? "type"]))

if(async_load[? "type"] == "xboxone_accountpicker"){
	global.user_id = async_load[? "user"];
	show_debug_message(string(global.user_id) + " = user_id");
}

if (!xboxone_user_is_signed_in(global.user_id) and global.user_id != -1){
	exit;
}
else{	
	xboxone_set_savedata_user(global.user_id);
	global.user_name = xboxone_gamedisplayname_for_user(global.user_id);
	show_debug_message(string(global.user_name) + " = user_id");
	porting_loadgamedata();
}

