__instantiate_system_objects();
__sys_transition_first_scene();

instance_create_depth(0, 0, 0, obj_main);
instance_create_depth(0, 0, 0, obj_window_manager).update();
instance_create_depth(0, 0, 0, obj_camera_manager);
if CHEAT instance_create_depth(0, 0, 0, obj_debug_manager);