global.achievements_list = {};
global.achievement_values = {};

function achievement_reset_all() {
	with(global.achievements_list) {
		all_trophys =			[false, 00, "Mestre das Masmorras"		]; //	Done
		
		arrow_1 =				[false, 05, "Desvio Estratégico"		]; //	Done
		arrow_5 =				[false, 21, "Sonho de Valsa"			]; //	Done
		arrow_10 =				[false, 30, "Mudança de Rota"			]; //	Done
		arrow_13 =				[false, 35, "Virada no Labirinto"		]; //	Done
		arrow_15 =				[false, 40, "Desvio Inteligente"		]; //	Done
		arrow_18 =				[false, 45, "Rei das Curvas"			]; //	Done
		
		break_1 =				[false, 10, "Quebrando Tudo"			]; //	Done
		break_5 =				[false, 24, "Destruidor"				]; //	Done
		
		holes_filled_1 =		[false, 02, "Pedreiro Aprendiz"			]; //	Done
		holes_filled_5 =		[false, 16, "Arquiteto das Ruínas"		]; //	Done
		
		level_1 =				[false, 01, "Primeiro Passo"			]; //	Done
		level_5 =				[false, 12, "Desbravador"				]; //	Done
		level_10 =				[false, 13, "Saindo do Fogo"			]; //	Done
		level_15 =				[false, 14, "Meio do Caminho"			]; //	Done
		level_18 =				[false, 15, "Limpando as Ruínas"		]; //	Done
		
		pushed_1 =				[false, 03, "Especialista em Deslize"	]; //	Done
		pushed_5 =				[false, 17, "Força do Minotauro"		]; //	Done
		pushed_10 =				[false, 26, "Força Taurina"				]; //	Done
		pushed_13 =				[false, 31, "Empurrão do Destino"		]; //	Done
		pushed_15 =				[false, 36, "Força Bruta Gentil"		]; //	Done
		pushed_18 =				[false, 41, "Poder do Minotauro"		]; //	Done
		
		restart_1 =				[false, 07, "Insistência é Virtude"		]; //	Done
		restart_5 =				[false, 19, "Novos Começos"				]; //	Done
		restart_10 =			[false, 28, "Recomeçar é Preciso"		]; //	Done
		restart_13 =			[false, 33, "Outra Chance"				]; //	Done
		restart_15 =			[false, 38, "Renovando Estratégias"		]; //	Done
		restart_18 =			[false, 43, "Mestre do Recomeço"		]; //	Done
		
		speedrun_lvl_5 =		[false, 11, "Velocista"					]; //	Done
		
		stopper_1 =				[false, 04, "Precisão Cirúrgica"		]; //	Done
		stopper_5 =				[false, 20, "Parada Eficiente"			]; //	Done
		stopper_10 =			[false, 29, "Parada Estratégica"		]; //	Done
		stopper_13 =			[false, 34, "Ponto de Parada"			]; //	Done
		stopper_15 =			[false, 39, "Xis da Questão"			]; //	Done
		stopper_18 =			[false, 44, "Parada Obrigatória"		]; //	Done
		
		teleporter_1 =			[false, 09, "Explorador Incansável"		]; //	Done
		teleporter_5 =			[false, 23, "Rei do Teleporte"			]; //	Done
		
		treasure_1 =			[false, 08, "Colecionador Iniciante"	]; //	Done
		treasure_5 =			[false, 22, "Guardador de Tesouros"		]; //	Done
		
		undo_1 =				[false, 06, "Errar é Humano"			]; //	Done
		undo_5 =				[false, 18, "Voltando no Tempo"			]; //	Done
		undo_10 =				[false, 27, "Melhor Pensar Duas Vezes"	]; //	Done
		undo_13 =				[false, 32, "Voltar Atrás"				]; //	Done
		undo_15 =				[false, 37, "Rebobinando o Labirinto"	]; //	Done
		undo_18 =				[false, 42, "Mestre do Retrocesso"		]; //	Done
		
		undoless_level_5 =		[false, 25, "Sem Erros"					]; //	Done
	}
	
	//	Achievement Values
	with(global.achievement_values) {
		arrow_n = 0;
		break_n = 0;
		hole_filled_n = 0;
		push_n = 0;
		restart_n = 0;
		level_time = 0;
		stopper_n = 0;
		teleport_n = 0;
		treasure_n = 0;
		undo_n = 0;
		undos_level = 0;
		undoless_levels = 0;
	}
	
	show_debug_message($"[Achievements] All Reset!");
}

achievement_reset_all();

function achievement_set(_name) {
	if struct_exists(global.achievements_list, _name) {
		if !global.achievements_list[$ _name][0] {
			global.achievements_list[$ _name][0] = true;
		
			if (global.debug.log_achievements) show_debug_message($"\n[Achievements] Unlocked: ({global.achievements_list[$ _name][1]} - {_name} - {global.achievements_list[$ _name][2]})");
			unlock_achievement_test(_name);
			
			global.current_platform.porting_unlock_achievements(global.achievements_list[$ _name][1])
			var _names = struct_get_names(global.achievements_list);
			var _success = true;
			for (var i = 0; i < array_length(_names); i++) {
				var _namei = _names[i];
				if (_namei == "all_trophys") continue;
				var _element = global.achievements_list[$ _namei][0];
		
				if !_element {
					_success = false;
					break;
				}
			}
	
			if _success {
				if !global.achievements_list[$ "all_trophys"][0] {
					global.achievements_list[$ "all_trophys"][0] = true;
		
					if (global.debug.log_achievements) show_debug_message($"\n[Achievements] UNLOCKED ALL!!!!");
				}
				//else if (global.debug.log_achievements) show_debug_message($"[Achievements][ERROR] Already unlocked: all_trophys!!!");
			}
		}
		//else if (global.debug.log_achievements) show_debug_message($"[Achievements][ERROR] Already unlocked: {_name}!!!");
	}
	else if (global.debug.log_achievements) show_debug_message($"\n[Achievements][ERROR] Achievement: {_name} does not exist!!!");
}

function achievement_log() {
	var _names = struct_get_names(global.achievements_list);
	var _names_values = struct_get_names(global.achievement_values);
	
	show_debug_message("\n[Achievements]\n\n________________________________\t\tLOGGING ACHIEVEMENTS!\t\t________________________________");
	var _locked = 0;
	for (var i = 0; i < array_length(_names); i++) {
		if !global.achievements_list[$ _names[i]][0] {
			show_debug_message($"({global.achievements_list[$ _names[i]][1]} - {_names[i]} - {global.achievements_list[$ _names[i]][2]}): no");
			_locked++;
		}
	}
	show_debug_message($"({_locked} achievements locked)\n");
	var _unlocked = 0;
	for (var i = 0; i < array_length(_names); i++) {
		if global.achievements_list[$ _names[i]][0] {
			show_debug_message($"({global.achievements_list[$ _names[i]][1]} - {_names[i]} - {global.achievements_list[$ _names[i]][2]}): UNLOCKED");
			_unlocked++;
		}
	}
	show_debug_message($"({_unlocked} achievements unlocked)\n");
	show_debug_message("\n\n________________________________\t\tVALUES!\t\t________________________________");
	for (var i = 0; i < array_length(_names_values); i++) {
		show_debug_message($"{_names_values[i]}: {global.achievement_values[$ _names_values[i]]}");
	}

}