/// @description Verifica se tem conexão com internet
// Você pode escrever seu código neste editor
if (async_load[? "id"] == ah_btc) {
	//show_message("Internet Status:: " + string(async_load[? "status"]));
  switch (async_load[? "status"]) {
    case 1: break;
    case 0:
      show_debug_message("Internet OK");
	  global.internet = "ok";
    break;
    default:
      show_debug_message("Internet Fail");
	  global.internet = "fail";
	  show_debug_message(string(global.user_name) + " = Force Load");
	  porting_loadgamedata();
		/*xboxone_set_savedata_user(global.user_id);
		global.user_name = xboxone_gamedisplayname_for_user(global.user_id);
		show_debug_message(string(global.user_name) + " = Force Load");
		global.current_platform.porting_loadgamedata();*/
    break;
  }
}
