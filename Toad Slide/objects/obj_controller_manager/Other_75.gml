switch(async_load[? "event_type"]){           // Parse the async_load map to see which event has been triggered
    case "gamepad discovered":{                   // A game pad has been discovered
        var _slot = async_load[? "pad_index"];       // Get the slot index value from the async_load map
        show_debug_message("Pad Connected On Slot: "+string(global.pad_by_player[0]));
		gamepad_set_axis_deadzone(global.pad_by_player[0], 0.350);
		show_debug_message(gamepad_get_description(global.pad_by_player[0]))
		set_controller_type(global.pad_by_player[0]);
		__input_connect_gamepad(global.pad_by_player[0]);
        break;
    }
    case "gamepad lost":{ // Gamepad has been removed or otherwise disabled
		if(os_type == os_windows){
			if(!gamepad_is_connected(global.pad_by_player[0])){
				global.current_controller_type = BUTTON_ICON_KEYBOARD;
			}
		}
        
    }
}

