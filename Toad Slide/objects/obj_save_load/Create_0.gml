#region Save

//Esta função sera executada depois do Load de forma assincrona
funAfetrLoad = function(){};

global.Save = function(json){
	global.json = json;
	global.can_save = true;
}

global.Load = function(fun){
	inLoad = 1;
	funAfetrLoad = fun;
	global.current_platform.porting_loadgamedata();
}

porting_start_save = function(){


}

porting_write_data = function(){
	global.savedata = global.json;
	
}
#endregion

#region Load
	
	
porting_read_data = function(_map_to_load){
	
	global.data_json = _map_to_load;// json_decode(_map_to_load);
	inLoad = 2;
	global.load_finished = true;
	funAfetrLoad();//Sempre que acaba de carregar chama este cara que executar o action after setado na função Load
	show_debug_message("Load Finished")
}

function LoadGame(){
    global.Load(OnLoadSettings);
}

function OnLoadSettings(){
    var json = global.data_json;//os dados sempre estarão neste global.data_json
    if(json != undefined && string_length(json) > 5)
    {
	    var json = global.data_json;//os dados sempre estarão neste global.data_json

	    __save_clean_load_buffer();
	    if(json != undefined && string_length(json) > 5)
	    {
	        //Covertejson para objeto e carrega os dados
	        __save_process_loaded_data(json);
	    }
		
	    show_debug_message("Load Finished")
	}
	
}

#endregion




//global.current_platform.porting_loadgamedata();