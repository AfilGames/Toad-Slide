/// @description Setup

// Inherit the parent event
event_inherited();

update_depth = function() {
	depth = -y + UNIT * 1.1;
}

update_depth();

var _default_sprites = [spr_hole_01, spr_hole_02, spr_hole_03];
var _filled_sprites = [spr_hole_filled_01, spr_hole_filled_02, spr_hole_filled_03];

var _index = level_get_biome();

sprite_default = _default_sprites[_index];
sprite_filled = _filled_sprites[_index];

grid_data.action_modify = function(_instance) {
	if !_instance.sink exit;
	
	if deactivated {
		with(_instance.grid_data) {
			template_pushable_post_check_modifier();
		}
		_instance.move_continuous();
	}
	else {
		_instance.grid_data_reset();
		_instance.deactivated = true;
		
		if (audio_exists(_instance.slide_sound) and audio_is_playing(_instance.slide_sound)) {
			audio_stop_sound(_instance.slide_sound);
		}
		
		audio_play_sfx(snd_bloco_encaixar);
	
		image_speed = 1;
		sprite_index = sprite_filled;
		image_index = 0;
		
	
		deactivated = true;
	}
}