var cmd  = async_load[? "type"];
show_debug_message("CMD:: " + string(cmd));
if(async_load[? "type"] == "xboxone_accountpicker"){
	global.user_id = async_load[? "user"];
	show_debug_message(string(global.user_id) + " = user_id");
}

if (!xboxone_user_is_signed_in(global.user_id) and global.user_id != -1){
	exit;
}


