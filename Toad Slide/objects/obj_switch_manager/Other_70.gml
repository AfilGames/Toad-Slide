var id_value = async_load[? "id"];

switch(id_value)
{
	case SWITCH_LEADERBOARD_COMMON_DATA_POSTED_MSG:
		var error = async_load[? "error"];
		if(error != 0){
			show_debug_message("ERROR = " + string(error))
		}
		show_debug_message("SWITCH_LEADERBOARD_COMMON_DATA_POSTED_MSG")
		break;
	
	case SWITCH_LEADERBOARD_SCORE_RANGE_MSG:
		var error = async_load[? "error"];
		show_debug_message("SWITCH_LEADERBOARD_SCORE_RANGE_MSG")

		if(error != 0){
			var codigos_do_erro = switch_error_get_os_code_info(error);
			switch_error_show_os_code(error);
			show_debug_message("Erro (" + string(error) + " " + string(codigos_do_erro[0]) + " - " + string(codigos_do_erro[1]));	
		} 
		else{
			show_debug_message("Get_Leaderboards INIT")

			var n_entries = async_load[? "numentries"];
			show_debug_message(string(n_entries) + " = n_entries")
			var leaderboard_id = async_load[? "leaderboardid"];
			show_debug_message(string(leaderboard_id) + " = leaderboardid")

			for(var _player_index = 0; _player_index < n_entries; _player_index++){
				
				var _score = async_load[? "score" + string(_player_index)];
				var _player = async_load[? "player" + string(_player_index)];

				global.player_name[_player_index] = _player;
				global.player_score[_player_index] = _score;
			}
			show_debug_message("Get_Leaderboards FINISHED")
			
		}	
		break;
	case "SWITCH_GAMESERVER (7001)":
		var status = async_load[? "status"];
		var error = async_load[? "error"];
			
		if(status == "user_disconnected")
		{
			global.is_connected = false;
			var codigos_do_erro = switch_error_get_os_code_info(error);
			switch_error_show_os_code(error);
			show_debug_message("Error (" + string(error) + " " + string(codigos_do_erro[0]) + " - " + string(codigos_do_erro[1]));
		}
		break;
	case SWITCH_GAMESERVER:
		var status = async_load[? "status"];
		var error = async_load[?"error"];
		if(error != 0){
			var codigos_do_erro = switch_error_get_os_code_info(error);
			switch_error_show_os_code(error);
			if(global.is_connected and global.can_connect)
				switch_gameserver_logout_user(global.user_id);
			global.can_connect = false;
			global.is_connected = false;
		}
		else{
			switch(status)
			{
				//caso não haja erros
				//quando loga no servidor
				case "user_logged_in":
					global.is_connected = true;
					show_debug_message("conectado ao servidor");
						
				break;
			
				//quando desloga do servidor
				case "user_logged_out":
					global.is_connected = false;
					show_debug_message("Usuario: " + global.user_name + "(" + string(global.user_id) + ") saiu do servidor");
				break;
			}
		}
		break;
}