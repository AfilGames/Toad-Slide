/// @description Setup

black_bg_alpha = 0;

// Inherit the parent event
event_inherited();

ingame_screen = new node_canvas("ingame_screen", NODE_ORIGIN.TOP_LEFT);
with (ingame_screen)
{
	// Defina o tamanho do canvas para o tamanho da GUI
	node_set_size(GUI_WIDTH, GUI_HEIGHT);
	
	// ANIMAÇÂO
	node_set_call_delay(0.2);
	
	// Cria botão de Play
	var _level = new node_button($"level_button", false);
	with (_level)
		{	
			node_set_position(16 + 64, 10 + 20);
			
			add_component_processor();
			processor.add_process(
				function() {
					self.text = $"{language_get_localized_text("ingame_level")} {global.level_index}";
				},
				true
			);
			processor.add_process(
				function(_node) {
					if _node.node_active {
						_node.node_text_set_colors(#000000);
						//_node.text_scale.x = .5;
						//_node.text_scale.y = .5;
					}
					else {
						_node.node_text_set_colors(#ffffff);
						//_node.text_scale.x = 1;
						//_node.text_scale.y = 1;
					}
				},
				true
			);
			
			node_sprite_set_scale(1, 1);
			
			// Tamanho base do botão
			node_set_size(142,48);
			
			// Adicionando texto
			node_add_text($"{language_get_localized_text("ingame_level")} {global.level_index}", "interface_14", #ffffff, true);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_level_indicator_banner);
			
			// Escala inicial do node
			node_set_start_scale(0,0);
			
			// Definindo animações de estado do Node
			with (animator)
			{		
				// Aqui utilizo as animações padrão de escala para definir o comportamento delas
				// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
				set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
				set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
			}
		}

	var _button_container = new node_container_vertical("ingame_buttons",, NODE_ORIGIN.BOTTOM_RIGHT)
	with (_button_container)
	{
		
		// Define a posição do container dentro do Canvas
		node_set_position(GUI_WIDTH - 16, GUI_HEIGHT - 10);
		
		// Margem entre os botões do container
		container_set_margin(8,2);
		
		var _punch = new node_button($"punch_button", true);
		with (_punch)
		{	
			add_component_processor();
			processor.add_process(
					function(_node) {
						if (global.input_profile.mode != INPUT_MODE.MOUSE) {
							self.navigator.selected = false;
						}
					},
					true
				);
			processor.add_process(
				function(_node) {
					if _node.node_active {
						_node.node_text_set_colors(#000000);
						//_node.text_scale.x = .5;
						//_node.text_scale.y = .5;
					}
					else {
						_node.node_text_set_colors(#ffffff);
						//_node.text_scale.x = 1;
						//_node.text_scale.y = 1;
					}
				},
				true
			);
			
			navigator.block_directions(true, true, true, true);
			
			node_set_position(GUI_WIDTH - 50 - 22, GUI_HEIGHT - 24 - 22);
		
			// Tamanho base do botão
			node_set_size(100, 36);
			
			sound_select = noone;
			
			// Adicionando texto
			node_add_text("ingame_punch", "interface_10", #ffffff, true);
		
			// Adicionando sprite
			node_add_sprite(spr_ui_ingame_indicator);
			
			// Adicionando sprite para quando o botão for selecionado
			node_sprite_set_hover(spr_ui_ingame_indicator_selected);
		
			node_sprite_set_scale(1, 1);
					
			// Adicionado uma função para rodar quando o node for clicado
			var _click_action = function(_node)
			{		
				 //Criando um Tween para animar o botão ao ser clicado
			
				mini_tween(_node.transform, 0.1)				// Defino o alvo como o transform do botão e o timer para 0.1 segundos
					.tween_scale(0.9, 0.9)						// Adiciono o tween_scale para animar a escala do botão para os valores que quero
					.set_ease(EASING_CURVES.SINE_IN)			// Defino qual curva de interpolação eu quero utilizar
					.set_on_complete(function (_target)			// Adiciono uma função para rodar quando o Tween for completo
					{
						mini_tween(_target, 0.1)				// Dentro da função que é executado no final do Tween, eu crio outro tween
							.tween_scale(1, 1)					// para voltar o valor da escala para 1
							.set_ease(EASING_CURVES.SINE_OUT);
					});
				
				obj_main.restart();
			}				
			set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
		
			// Escala inicial do node
			node_set_start_scale(0,0);
			
			ui_button_add_input_indicator("game_interact");
			
			// Definindo animações de estado do Node
			with (animator)
			{		
				// Aqui utilizo as animações padrão de escala para definir o comportamento delas
				// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
				set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
				set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
			}
		}
		
		var _restart = new node_button($"restart_button", true);
		with (_restart)
			{	
				add_component_processor();
				processor.add_process(
					function(_node) {
						if (global.input_profile.mode != INPUT_MODE.MOUSE) {
							self.navigator.selected = false;
						}
					},
					true
				);
				processor.add_process(
					function(_node) {
						if _node.node_active {
							_node.node_text_set_colors(#000000);
							//_node.text_scale.x = .5;
							//_node.text_scale.y = .5;
						}
						else {
							_node.node_text_set_colors(#ffffff);
							//_node.text_scale.x = 1;
							//_node.text_scale.y = 1;
						}
					},
					true
				);
				
				navigator.block_directions(true, true, true, true);
				
				node_set_position(GUI_WIDTH - 50 - 22, GUI_HEIGHT - 24 - 22);
				
				sound_select = noone;
				
				// Tamanho base do botão
				node_set_size(100, 36);
			
				// Adicionando texto
				node_add_text("ingame_restart", "interface_10", #ffffff, true);
			
				// Adicionando sprite
				node_add_sprite(spr_ui_ingame_indicator);
				
				// Adicionando sprite para quando o botão for selecionado
				node_sprite_set_hover(spr_ui_ingame_indicator_selected);
			
				node_sprite_set_scale(1, 1);
						
				// Adicionado uma função para rodar quando o node for clicado
				var _click_action = function(_node)
				{		
					 //Criando um Tween para animar o botão ao ser clicado
				
					mini_tween(_node.transform, 0.1)				// Defino o alvo como o transform do botão e o timer para 0.1 segundos
						.tween_scale(0.9, 0.9)						// Adiciono o tween_scale para animar a escala do botão para os valores que quero
						.set_ease(EASING_CURVES.SINE_IN)			// Defino qual curva de interpolação eu quero utilizar
						.set_on_complete(function (_target)			// Adiciono uma função para rodar quando o Tween for completo
						{
							mini_tween(_target, 0.1)				// Dentro da função que é executado no final do Tween, eu crio outro tween
								.tween_scale(1, 1)					// para voltar o valor da escala para 1
								.set_ease(EASING_CURVES.SINE_OUT);
						});
					
					obj_main.restart();
				}				
				set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
			
				// Escala inicial do node
				node_set_start_scale(0,0);
				
				ui_button_add_input_indicator("game_restart");
				
				// Definindo animações de estado do Node
				with (animator)
				{		
					// Aqui utilizo as animações padrão de escala para definir o comportamento delas
					// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
					set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
					set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
				}
			}
	
		var _rewind = new node_button($"rewind_button", true);
		with (_rewind)
			{	
				add_component_processor();
				processor.add_process(
					function(_node) {
						if (global.input_profile.mode != INPUT_MODE.MOUSE) {
							self.navigator.selected = false;
						}
					},
					true
				);
				processor.add_process(
					function(_node) {
						if _node.node_active {
							_node.node_text_set_colors(#000000);
							//_node.text_scale.x = .5;
							//_node.text_scale.y = .5;
						}
						else {
							_node.node_text_set_colors(#ffffff);
							//_node.text_scale.x = 1;
							//_node.text_scale.y = 1;
						}
					},
					true
				);
				
				navigator.block_directions(1, 1, 1, 1);
				
				node_set_position(GUI_WIDTH - 50 - 22, GUI_HEIGHT - 24 - 22);
				
				sound_select = noone;
				
				// Tamanho base do botão
				node_set_size(100, 36);
			
				// Adicionando texto
				node_add_text("ingame_undo", "interface_10", #ffffff, true);
			
				// Adicionando sprite
				node_add_sprite(spr_ui_ingame_indicator);
			
				// Adicionando sprite para quando o botão for selecionado
				node_sprite_set_hover(spr_ui_ingame_indicator_selected);
			
				node_sprite_set_scale(1, 1);
						
				// Adicionado uma função para rodar quando o node for clicado
				var _click_action = function(_node)
				{		
					 //Criando um Tween para animar o botão ao ser clicado
				
					mini_tween(_node.transform, 0.1)				// Defino o alvo como o transform do botão e o timer para 0.1 segundos
						.tween_scale(0.9, 0.9)						// Adiciono o tween_scale para animar a escala do botão para os valores que quero
						.set_ease(EASING_CURVES.SINE_IN)			// Defino qual curva de interpolação eu quero utilizar
						.set_on_complete(function (_target)			// Adiciono uma função para rodar quando o Tween for completo
						{
							mini_tween(_target, 0.1)				// Dentro da função que é executado no final do Tween, eu crio outro tween
								.tween_scale(1, 1)					// para voltar o valor da escala para 1
								.set_ease(EASING_CURVES.SINE_OUT);
						});
					
					rewind_instances();                         
				}				
				set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
			
				// Escala inicial do node
				node_set_start_scale(0,0);
				
				ui_button_add_input_indicator("game_rewind");
			
				// Definindo animações de estado do Node
				with (animator)
				{		
					// Aqui utilizo as animações padrão de escala para definir o comportamento delas
					// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
					set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
					set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
				}
			}
	
		// Agora que os structs dos botões estão completes, adiciono eles no container
		node_add(_punch, _restart, _rewind);
	}
	
	node_add(_level, _button_container);
	
	// Chama a função de awake para termianr a configuração interna da interface
	__awake();
}

// Criando o canvas para o menu principal
pause_menu = new node_canvas("pause_menu", NODE_ORIGIN.TOP_LEFT);
with (pause_menu)
{
	// Defina o tamanho do canvas para o tamanho da GUI
	node_set_size(GUI_WIDTH, GUI_HEIGHT);
	
	// ANIMAÇÂO
	node_set_call_delay(0.2);
	
	// Cria container horizontal para distribuir os botões do menu
	var _button_container = new node_container_vertical("menu_buttons")
	with (_button_container)
	{
		add_component_processor();
		processor.add_process(
			function() {
				if (os_type == os_windows)
				{
					if (!gamepad_is_connected(global.pad_by_player[0]))
					{
						if input_check_pressed("act_return") {
							audio_play_sfx(snd_ui_select);
							node_change_active_canvas(0);
							global.paused = false;
						}
					}
					else					{
						if input_check_pressed("act_pause") {
							node_change_active_canvas(0);
							global.paused = false;
						}
					}
				}
				else
				{
					if input_check_pressed("act_pause") {
						node_change_active_canvas(0);
						global.paused = false;
					}
				}
			},
			true
		);
		
		
		// Define a posição do container dentro do Canvas
		node_set_position(GUI_WIDTH/2, GUI_HEIGHT * .5);
		
		// Margem entre os botões do container
		container_set_margin(5,5);
		
		var _banner = new node_button($"pause_banner", false);
		with (_banner)
		{
			
			// Define a posição do container dentro do Canvas
			node_set_position(GUI_WIDTH/2, GUI_HEIGHT * .17);
			
			// Tamanho base do botão
			node_set_size(160 + 40, 96);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_level_select_banner);
			
			// Adicionando texto
			node_add_text("menu_paused", "interface_14", #000000, true);
	 
	
			node_sprite_set_scale(1, 1);
		
			// Escala inicial do node
			node_set_start_scale(0,0);
	
			// Definindo animações de estado do Node
			with (animator)
			{		
				// Aqui utilizo as animações padrão de escala para definir o comportamento delas
				// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
				set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
				set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
			}
		}
		
		// Cria botão de Play
		var _resume = new node_button($"resume_button");
		with (_resume)
		{
			add_component_processor()
			processor.add_process(
				function(_node) {
					if _node.node_active {
						_node.node_text_set_colors(#000000);
						//_node.text_scale.x = .5;
						//_node.text_scale.y = .5;
					}
					else {
						_node.node_text_set_colors(#ffffff);
						//_node.text_scale.x = 1;
						//_node.text_scale.y = 1;
					}
				},
				true
			);
			
			// Tamanho base do botão
			node_set_size(220,42);
			node_set_scale(1, 1);
			
			// Adicionando texto
			node_add_text("pause_resume", "interface_14", #ffffff, true);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_9slice_32);
			
			// Adicionando sprite para quando o botão for selecionado
			node_sprite_set_hover(spr_ui_9slice_32_hover);
			
			//node_sprite_set_scale(5, 1.4);
						
			// Adicionado uma função para rodar quando o node for clicado
			var _click_action = function(_node)
			{		
				// Criando um Tween para animar o botão ao ser clicado
				call_later(2, time_source_units_frames, function() {
					global.paused = false;
				
					node_change_active_canvas(0);
				});
				
				mini_tween(_node.transform, 0.1)				// Defino o alvo como o transform do botão e o timer para 0.1 segundos
					.tween_scale(0.9, 0.9)						// Adiciono o tween_scale para animar a escala do botão para os valores que quero
					.set_ease(EASING_CURVES.SINE_IN)			// Defino qual curva de interpolação eu quero utilizar
					.set_on_complete(function (_target)			// Adiciono uma função para rodar quando o Tween for completo
					{
						mini_tween(_target, 0.1)				// Dentro da função que é executado no final do Tween, eu crio outro tween
							.tween_scale(1, 1)					// para voltar o valor da escala para 1
							.set_ease(EASING_CURVES.SINE_OUT);
					});
			}				
			set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
			
			// Escala inicial do node
			node_set_start_scale(0,0);
			
			// Definindo animações de estado do Node
			with (animator)
			{		
				// Aqui utilizo as animações padrão de escala para definir o comportamento delas
				// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
				set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
				set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
			}
		}
		
		// Botão de Opções
		var _options = new node_button($"options_button");
		with (_options)
		{
			add_component_processor()
			processor.add_process(
				function(_node) {
					if _node.node_active {
						_node.node_text_set_colors(#000000);
						//_node.text_scale.x = .5;
						//_node.text_scale.y = .5;
					}
					else {
						_node.node_text_set_colors(#ffffff);
						//_node.text_scale.x = 1;
						//_node.text_scale.y = 1;
					}
				},
				true
			);
			
			// Tamanho base do botão
			node_set_size(220,42);
			node_set_scale(1, 1);
			
			// Adicionando texto
			node_add_text("menu_options", "interface_14", #ffffff, true);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_9slice_32);
			
			// Adicionando sprite para quando o botão for selecionado
			node_sprite_set_hover(spr_ui_9slice_32_hover);
			
			//node_sprite_set_scale(5, 1.4);
			
			// Adicionado uma função para rodar quando o node for clicado
			var _click_action = function(_node)
			{		
				// Criando um Tween para animar o botão ao ser clicado
				node_change_active_canvas(2);
				
				mini_tween(_node.transform, 0.1)				// Defino o alvo como o transform do botão e o timer para 0.1 segundos
					.tween_scale(0.9, 0.9)						// Adiciono o tween_scale para animar a escala do botão para os valores que quero
					.set_ease(EASING_CURVES.SINE_IN)			// Defino qual curva de interpolação eu quero utilizar
					.set_on_complete(function (_target)			// Adiciono uma função para rodar quando o Tween for completo
					{
						mini_tween(_target, 0.1)				// Dentro da função que é executado no final do Tween, eu crio outro tween
							.tween_scale(1, 1)					// para voltar o valor da escala para 1
							.set_ease(EASING_CURVES.SINE_OUT);
					});
			}				
			set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
			
			// Escala inicial do node
			node_set_start_scale(0,0);
			
			// Definindo animações de estado do Node
			with (animator)
			{		
				// Aqui utilizo as animações padrão de escala para definir o comportamento delas
				// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
				set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
				set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
			}
		}
		
		// Botão de Opções
		var _lvl_select = new node_button($"level_select_button");
		with (_lvl_select)
		{
			add_component_processor()
			processor.add_process(
				function(_node) {
					if _node.node_active {
						_node.node_text_set_colors(#000000);
						//_node.text_scale.x = .5;
						//_node.text_scale.y = .5;
					}
					else {
						_node.node_text_set_colors(#ffffff);
						//_node.text_scale.x = 1;
						//_node.text_scale.y = 1;
					}
				},
				true
			);
			
			// Tamanho base do botão
			node_set_size(220,42);
			node_set_scale(1, 1);
			
			// Adicionando texto
			node_add_text("menu_level_select", "interface_14", #ffffff, true);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_9slice_32);
			
			// Adicionando sprite para quando o botão for selecionado
			node_sprite_set_hover(spr_ui_9slice_32_hover);
			
			//node_sprite_set_scale(5, 1.4);
			
			// Adicionado uma função para rodar quando o node for clicado
			var _click_action = function(_node)
			{		
				// Criando um Tween para animar o botão ao ser clicado
				node_change_active_canvas(3);
				
				mini_tween(_node.transform, 0.1)				// Defino o alvo como o transform do botão e o timer para 0.1 segundos
					.tween_scale(0.9, 0.9)						// Adiciono o tween_scale para animar a escala do botão para os valores que quero
					.set_ease(EASING_CURVES.SINE_IN)			// Defino qual curva de interpolação eu quero utilizar
					.set_on_complete(function (_target)			// Adiciono uma função para rodar quando o Tween for completo
					{
						mini_tween(_target, 0.1)				// Dentro da função que é executado no final do Tween, eu crio outro tween
							.tween_scale(1, 1)					// para voltar o valor da escala para 1
							.set_ease(EASING_CURVES.SINE_OUT);
					});
			}				
			set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
			
			// Escala inicial do node
			node_set_start_scale(0,0);
			
			// Definindo animações de estado do Node
			with (animator)
			{		
				// Aqui utilizo as animações padrão de escala para definir o comportamento delas
				// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
				set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
				set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
			}
		}
		
		var _backmenu = new node_button($"backmenu_button");
		with (_backmenu)
		{
			add_component_processor()
			processor.add_process(
				function(_node) {
					if _node.node_active {
						_node.node_text_set_colors(#000000);
						//_node.text_scale.x = .5;
						//_node.text_scale.y = .5;
					}
					else {
						_node.node_text_set_colors(#ffffff);
						//_node.text_scale.x = 1;
						//_node.text_scale.y = 1;
					}
				},
				true
			);
			
			// Tamanho base do botão
			node_set_size(220,42);
			node_set_scale(1, 1);
			
			// Adicionando texto
			node_add_text("pause_main_menu", "interface_14", #ffffff, true);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_9slice_32);
			
			// Adicionando sprite para quando o botão for selecionado
			node_sprite_set_hover(spr_ui_9slice_32_hover);
			
			//node_sprite_set_scale(5, 1.4);
			
			// Adicionado uma função para rodar quando o node for clicado
			var _click_action = function(_node)
			{		
				// Criando um Tween para animar o botão ao ser clicado
				transition_function(
					function() {
						scene_change_room(rm_main_menu);
						call_later(2, time_source_units_frames, function() { node_change_active_canvas(1) });
	
						global.paused = false;
					}
				);
				
				mini_tween(_node.transform, 0.1)				// Defino o alvo como o transform do botão e o timer para 0.1 segundos
					.tween_scale(0.9, 0.9)						// Adiciono o tween_scale para animar a escala do botão para os valores que quero
					.set_ease(EASING_CURVES.SINE_IN)			// Defino qual curva de interpolação eu quero utilizar
					.set_on_complete(function (_target)			// Adiciono uma função para rodar quando o Tween for completo
					{
						mini_tween(_target, 0.1)				// Dentro da função que é executado no final do Tween, eu crio outro tween
							.tween_scale(1, 1)					// para voltar o valor da escala para 1
							.set_ease(EASING_CURVES.SINE_OUT);
					});
			}				
			set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
			
			// Escala inicial do node
			node_set_start_scale(0,0);
			
			// Definindo animações de estado do Node
			with (animator)
			{		
				// Aqui utilizo as animações padrão de escala para definir o comportamento delas
				// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
				set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
				set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
			}
		}
		
		// Agora que os structs dos botões estão completes, adiciono eles no container
		node_add(_banner, _resume, _options, _lvl_select, _backmenu);		
	}		
	
	// Adiciono o struct do container, já com os botões criados, dentro do Canvas
	node_add(_button_container);
	
	// Chama a função de awake para termianr a configuração interna da interface
	__awake();
}

options_menu = ui_create_option_menu();

level_select = ui_create_level_select();

// Defino minha coleção de canvas que podem ser exibidos por esse objeto
canvas_collection = [ingame_screen, pause_menu, options_menu, level_select];