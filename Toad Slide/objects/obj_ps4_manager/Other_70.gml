if(async_load[? "id"] == PSN_LEADERBOARD_SCORE_RANGE_MSG){
	show_debug_message("PSN_LEADERBOARD_SCORE_RANGE_MSG");
	var numentries = async_load[? "numentries"];

	for(var _player_index = 0; _player_index < numentries; _player_index++){
		var _player = async_load[? "playerid" + string(_player_index)]
		var _score = async_load[? "scorevalue" + string(_player_index)];
		show_debug_message(string(_score) + " = _score " + string(_player_index))
		
		global.player_name[_player_index] = _player;
		global.player_score[_player_index] = _score;
	}

}