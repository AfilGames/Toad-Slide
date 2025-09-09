/// @description Ingame

if (winner_clock > -1) {
	
	if (winner_clock <= 0) {
		next_level();
	}
	winner_clock--;
}

if !global.paused {
	if input_check_pressed("game_restart") {
		restart();
	}

	if input_check_pressed("game_rewind") {
		rewind_instances();
	}
}

if input_check_pressed("act_pause") {
	pause_game();
}