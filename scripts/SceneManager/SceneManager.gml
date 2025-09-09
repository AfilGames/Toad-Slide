/*
	Funções de controle de room/scene e transições
*/

global.__scene_control = {};
with (global.__scene_control)
{
	transition_obj = noone;
	transition_dest = noone;
	transitioning = false;
	transition_depth = -1000;
	
}

#region Transition

///@function					scene_transition_fade(_room)
///@description					Transiciona para outra room com um efeito de fade
///@param {Asset.GMRoom} _room	Room destino
function scene_transition_fade(_room)
{
	if (!global.__scene_control.transitioning)
	{		
		input_lock_all(true);
		var _depth = global.__scene_control.transition_depth
		global.__scene_control.transition_obj = instance_create_depth(0,0,_depth, obj_transition);	
		global.__scene_control.transition_dest = _room;	
		global.__scene_control.transitioning = true;
		
		show_debug_message($"Transitioning to room {_room} using fade");
	}
	
}

///@function					scene_change_room(_room)
///@description					Transiciona para outra room sem nenhum efeito de transição
///@param {Asset.GMRoom} _room	Room destino
function scene_change_room(_room)
{
	// Essa função existe caso seja necessario adicionar tratamentos quando acontecer a troca de rooms futuramente
	room_goto(_room);	
}

///@function					__scene_transition_end(_room)
///@description					Evento de quando o efeito de transição acaba, reseta variaveis de controle e deleta o objeto de transição
function __scene_transition_end()
{
	var _transition_obj = global.__scene_control.transition_obj;
	if (instance_exists(_transition_obj)) instance_destroy(_transition_obj);
	
	global.__scene_control.transition_obj = noone;
	global.__scene_control.transition_dest = noone;
	global.__scene_control.transitioning = false;
	input_unlock_all(true);
}

///@function					__scene_transition_change_room(_room)
///@description					Evento de quando o efeito de transição inicial termina, chama a transição de room e o próximo estado da transição
function __scene_transition_change_room()
{
	var _room =  global.__scene_control.transition_dest;
	var _transition_obj =  global.__scene_control.transition_obj;
	
	scene_change_room(_room);
	
	if (instance_exists(_transition_obj))
	{
		_transition_obj.transition_room_changed();
	}	
}

#endregion

