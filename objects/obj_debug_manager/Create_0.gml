/// @description Setup

//	Debug
dbg_view("Utilitary", true, 30, 90, 480);

dbg_section("Logging")
dbg_checkbox(ref_create(global.debug, "log_rewind"), "Rewind");
dbg_checkbox(ref_create(global.debug, "log_achievements"), "Achievements");
dbg_button("Log Achievements", obj_main.log_achievements, 120);

dbg_section("Cheats");
dbg_button("Next Room", obj_main.next_level, 120);

dbg_section("Graphics");
dbg_slider(ref_create(global.settings_data.graphic, "resolution"), 1, (DISPLAY_HEIGHT div DEF_CAMERA_HEIGHT), "Window Scale:");
dbg_button("Fullscreen", obj_window_manager.toggle_fulscreen, 120);
dbg_same_line();
dbg_button("Update", obj_window_manager.update, 120);

dbg_section("Resets");
dbg_button("Reset Room", obj_main.restart, 120);
dbg_same_line();
dbg_button("Reset Achievements", obj_main.reset_achievements, 120);
show_debug_overlay(false);