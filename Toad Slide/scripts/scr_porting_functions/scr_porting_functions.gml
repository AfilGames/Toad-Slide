#macro CURRENT_PATCH 1
#macro CHEAT true
#macro IS_MS_STORE false
#macro MS:IS_MS_STORE true

// Apenas para uso de criação de video gameplay
#macro IS_NO_BUTTON false
#macro NOBUTTON:IS_NO_BUTTON true

#region Init
function porting_init_var(){
	//Configurações do jogo
	global.isMsStore = IS_MS_STORE;//Marque em caso da build Windows ser MS Store
	global.scid =  "00000000-0000-0000-0000-0000635a12c7";//scid da microsoft ms store
	global.game_title = "ToadSlide"; // só aceita letras e numeros
	global.filename = string(global.game_title);//Nome do arq save (não usar .dat)
	global.first_scene = rm_init;//Room inicial depois do Splash
	
	//Abaixo é carregado em runtime
	global.restriction_age = 0;
	global.user_id = noone;
	global.user_name = "Nickname"; 
	global.current_input = "gamepad"
	global.isLaunchingActvity = false;
	global.activity_level_launch = 1;
	global.porting_language = 1;
	
	init_save_var();
	porting_init_gameplay_var();
	porting_init_pad_var();
	
	global.is_paused = false;
	
	porting_update_cheat_status();
}

function porting_init_pad_var(){
	global.last_player_index = 0;
	global.holdtype = array_create(2, noone);
	global.max_pad_number = 8;
	global.pad_by_player = array_create(global.max_pad_number, noone);
	global.pad_by_player[0] = 0;
	
	global.can_unlock_achievement = array_create(99, true);
	global.disconnected_controller = false;
	global.first_input = false;
}

function porting_init_gameplay_var(){
	texture_prefetch("texturegroup1");
	global.score_to_post = 0;
}
#endregion


#region Reset Var To Default
function set_variables_to_default(){
	//Reseta as variáveis e volta para a tela inicial
	init_save_var();
	reset_porting_var();
	room_goto(global.first_scene);
}

function init_save_var(){
	global.can_save = false;
	global.is_saving = false;
	global.is_loading = false;
	global.load_finished = false;
	
	global.savedata = noone;
	global.load_id = noone;
	global.save_id = noone;
	global.savebuff = noone;
	global.loadbuff = noone;
}

function reset_porting_var(){
	global.user_id = noone;
	global.user_name = "Nickname";
	global.savedata = noone;
	global.first_input = false;
	global.disconnected_controller = false;
	for(var i = 0; i <= global.max_pad_number; i++){
		array_set(global.pad_by_player, i, false);
		array_set(global.can_sign_in_player_pad, i, false);
	}
}
#endregion

function porting_update_cheat_status(){
	/*if(code_is_compiled())
		global.is_cheat_active = false;
	else
		global.is_cheat_active = true;*/
}

function porting_pause(pause){
		global.is_paused = pause;
		//show_debug_message("Game Paused")
}
function porting_show_disconnected_controller(x_pos, y_pos){
	instance_create_depth(x_pos, y_pos,0,obj_controller_connection);
}

function get_system_language(){
	var system_language;
	switch(os_get_language())
	{
		case "en":
		case "en-US":
		case "en-UK":
			system_language = 0;
		break;

		case "pt":
		case "pt-BR":
			system_language = 1;
		break;
		
		case "es":
			system_language = 2;
		break;
		
		case "de":
			system_language = 3;
		break;
		
		case "ru":
			system_language = 4;
		break;
		
		default:	
			system_language = 1;
		break;
	}
	return system_language;
}

