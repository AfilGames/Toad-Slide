// Controle de eventos async

if(load_level_read)
{
	exit;
}

var _event_id = async_load[? "id"];

// Evento de save
if (_event_id == global.__save_control.save_id)
{
	// Finaliza procedimento de save
	global.__save_control.is_saving = false;
	if (global.__save_control.save_buffer != -1)
	{
		buffer_delete(global.__save_control.save_buffer);
		global.__save_control.save_buffer = -1;
	}
}
else if (_event_id == global.__save_control.save_id)
{
	// Finaliza procedimento de save
	__save_finish_saving_procedure();	
}
else if (_event_id == global.__save_control.load_id)
{
    if (async_load[? "status"] == false)
    {
        show_debug_message("Load failed!");
		__save_finish_loading_procedure();
    }
	else
	{
		var _loaded_data = buffer_read(global.__save_control.load_buffer, buffer_string);	
		__save_process_loaded_data(_loaded_data);
		__save_finish_loading_procedure();
		load_level_read = true;
	}
}
