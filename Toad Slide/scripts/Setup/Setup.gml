enum PUSHABLE_ANIM {
	STEPPED,
	CONTINUOUS
}

enum PUSHABLE_MODE {
	STEPPED,
	CONTINUOUS
}

global.game_setup = {};
#macro SETUP global.game_setup

with(global.game_setup) {
	push_anim = PUSHABLE_ANIM.CONTINUOUS;
	
	push_mode = PUSHABLE_MODE.CONTINUOUS;
	push_move_spd = 2;
}