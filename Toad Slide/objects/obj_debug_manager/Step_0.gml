/// @description Setup

if CHEAT {
	if (keyboard_check(vk_f12) && keyboard_check_pressed(vk_f1)) {
		show_debug_overlay(!is_debug_overlay_open());
	}

	if(keyboard_check_released(vk_f1) and !keyboard_check(vk_f12)) {
		global.game_data.level_unlock = global.level_number;
		if (room != rm_main_menu) {
			obj_main.next_level();
		}
		else {
			room_restart();
		}
	}
}