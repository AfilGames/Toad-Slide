var eventtype = async_load[? "event_type"];
if(eventtype == "game_intent")
{
	var intent_type = async_load[?"intent_type"];
	var intent_data = async_load[?"intent_data"];
	
	
	
	show_debug_message("Game intent message received of type:" + string(intent_type) + " with data:" + string(intent_data));
	
	if(intent_type=="launchActivity")
	{
		var data_as_map = json_decode(intent_data);
	
		var activityid = data_as_map[?"activityId"];
	
		show_debug_message("Found launch activity ID:" +string(activityid));
		global.isLaunchingActvity = true;
		
		ds_map_destroy(data_as_map);
	}
	
}

show_debug_message("eventtype: "+string(eventtype));
show_debug_message("async_load: "+string(async_load));