show_debug_message("obj_platform_manager")
global.forcePause = false;
global.loadbuffOf = noone;
global.load_idOff = noone;
porting_init_var();

#region Create_plataform


if(os_type == os_switch)
	global.current_platform = instance_create_depth(0,0,0,obj_switch_manager)
else if(os_type == os_xboxone or os_type == os_xboxseriesxs)
	global.current_platform = instance_create_depth(0,0,0,obj_xbox_manager)
else if(os_type == os_ps4)
	global.current_platform = instance_create_depth(0,0,0,obj_ps4_manager)
else if(os_type == os_ps5)
	global.current_platform = instance_create_depth(0,0,0,obj_ps5_manager)
else if(os_type == os_windows && global.isMsStore == true)
	global.current_platform = instance_create_depth(0,0,0,obj_ms_store_manager)
else if(os_type == os_windows && global.isMsStore == false)
	global.current_platform = instance_create_depth(0,0,0,obj_windows_manager)
	
#endregion

global.current_platform.porting_init_libs();

counter = 0;
max_counter_time = 20;
