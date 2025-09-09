//porting_check_pad_status();

with(global.current_platform)
porting_check_constrain();

if(global.can_save && global.load_finished && !global.is_saving){
    if(counter >= max_counter_time)
    {
        global.can_save = false;
        global.current_platform.porting_savegamedata();
        counter = 0;
        exit;
    }
    if(counter <= max_counter_time)
    counter ++;

   // show_debug_message("counter" + string(counter))
}