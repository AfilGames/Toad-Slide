global.level_index = 1;
global.level_number = 0;
global.level_target = 1;

enum BIOME {
	SPRING,
	SUMMER,
	AUTUMN
}

function level_get_biome(_level_index = global.level_index) {
	return ((_level_index - 1) div 10)
}

//	Indexxing the levels
for (var i = 1; true; i++) {
	if room_exists(asset_get_index($"rm_level_{zero_padding(i, 2, 0)}")) {
		global.level_number = i;
	}
	else break;
}

//	Functions
function level_get_room(_index) {
	var _room = asset_get_index($"rm_level_{zero_padding(_index, 2, 0)}");
	return _room;
}


function level_setup() {
	obj_camera_manager.set(room_width * .5, room_height * .5);
	instance_create_depth(0, 0, 0, obj_nodeui_ingame);
	//instance_create_depth(0, 0, 0, obj_godrays);
	//instance_create_depth(0, 0, 0, obj_falling);
	
	if audio_is_playing(snd_bloco_arrastando_loop) audio_stop_sound(snd_bloco_arrastando_loop);
	
	layer_x(layer_get_id("Tileset"), UNIT);
	layer_y(layer_get_id("Tileset"), UNIT);
	
	layer_x(layer_get_id("Tileset2"), UNIT);
	layer_y(layer_get_id("Tileset2"), UNIT);
	
	layer_x(layer_get_id("Props"), UNIT * .5);
	layer_y(layer_get_id("Props"), UNIT * .5);
	
	layer_x(layer_get_id("Mud"), UNIT);
	layer_y(layer_get_id("Mud"), UNIT);
	
	layer_set_visible(layer_get_id("LevelGuides"), false);
	
	layer_background_index(layer_get_id("TiledFloor"), level_get_biome());
	
	global.paused = false;
}