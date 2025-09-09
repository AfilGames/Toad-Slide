if(async_load[? "event"] == "GetLeaderboardComplete"){
	show_debug_message("GetLeaderboardComplete")
	var n_entries = async_load[? "numentries"];
	var error = async_load[? "error"];
							
	if(error != 0){
		for(var _player_index = 0; _player_index < n_entries; _player_index++){
			var _player = async_load[? "Player" + string(_player_index)];
			var _player_id = async_load[? "Playerid" + string(_player_index)];
			var _score = async_load[? "Score" + string(_player_index)];
			global.player_name[_player_index] = _player;
			global.player_id[_player_index] = _player_id;
			global.player_score[_player_index] = _score;
		}
	}
	show_debug_message("LeaderboardCompleted")
}