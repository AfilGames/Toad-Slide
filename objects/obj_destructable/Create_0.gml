/// @description Setup

// Inherit the parent event
event_inherited();

action = function() {
	deactivated = true;
	
	audio_play_sfx(snd_bloco_quebrar);
}

update_depth = function() {
	if deactivated {
		depth = -y + UNIT * 1.1;
	}
	else {
		depth = -y;
	}
}

update_depth();