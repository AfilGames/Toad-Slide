var ident = async_load[? "id"];
if(ident == global.load_id){//Se é load online
	
	var load_map = buffer_read(global.loadbuff, buffer_text);
	//A lógica aqui verifica se o save local esta diferente do online, isto significa que o jogador jogou offline
	if(global.loadbuffOf != noone){
		var load_mapOff = buffer_read(global.loadbuffOf, buffer_text);
		if(string_length(load_mapOff) > 2 && load_map != load_mapOff)	{//Off é mais atual, sincroniza
			try{
				var dataOnline = json_parse(load_map);
				var dataOffline = json_parse(load_mapOff);
				if(dataOnline.save_version_porting != "1" && dataOffline.save_version_porting != "1")
				{	
					//Faltou comparar as versões, como estava sempre usava a versão offline (local)
					if(dataOffline.save_version_porting > dataOnline.save_version_porting){
						load_map = load_mapOff;
						show_debug_message("Get Offline Save");
					}
				}
			}catch(_e){
				
			}
		}
	}
		
	if(string_length(load_map) < 2)
		load_map = "";
		
	buffer_delete(global.loadbuff);
	
	global.save_load.porting_read_data(load_map);
	if(os_type == os_switch)
		switch_save_data_unmount()
		
	global.load_finished = true;
		
		
}
else if(ident == global.save_id){
	buffer_delete(global.savebuff);
	if(os_type == os_switch){
		switch_save_data_commit();
		switch_save_data_unmount()
	}
	global.is_saving = false;
	show_debug_message("Save Finished")
}else if(ident == global.load_idOff){
	show_debug_message("Read Offline Save");
	//Importante aqui, caso seteja sem internet fazemos a leitura dos dados do offline e iniciamos o jogo
	if(global.internet == "fail"){
		var load_map = buffer_read(global.loadbuffOf, buffer_text);	
		if(string_length(load_map) < 15)
			load_map = "";
		buffer_delete(global.loadbuffOf);
		global.save_load.porting_read_data(load_map);
		global.load_finished = true;
	}
}

if(global.can_save && global.load_finished && !global.is_saving){
	if(counter >= max_counter_time)
	{
		global.can_save = false;
		global.current_platform.porting_savegamedata();
		counter = 0;
		exit;
	}
	if(counter<=max_counter_time)
	counter++;
	
	//show_debug_message("Counter" + string(counter))
}


