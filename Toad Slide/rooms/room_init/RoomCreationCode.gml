global.settings_loaded = false;	
instance_create_depth(0,0,0,obj_platform_manager)
global.save_load =  instance_create_depth(0,0,0,obj_save_load)
instance_create_depth(0,0,0,obj_splash_manager)
global.current_controller = instance_create_depth(0,0,-1000,obj_controller_manager)
//window_set_fullscreen(true);

settings_set_language(__language_get_system_language());