function ui_create_option_menu() {
	var _options_menu = new node_canvas("options_menu", NODE_ORIGIN.TOP_LEFT);
	with (_options_menu)
	{
		add_component_processor();
		processor.add_process(
			function() {
				if input_check_pressed("act_return") {
					audio_play_sfx(snd_ui_select);
					node_change_active_canvas(1);
				}
			},
			true
		);
	
		// Defina o tamanho do canvas para o tamanho da GUI
		node_set_size(GUI_WIDTH, GUI_HEIGHT);
	
		// ANIMAÇÂO
		node_set_call_delay(0.2);
	
		// Cria container horizontal para distribuir os botões do menu
		var _button_container = new node_container_vertical("menu_buttons")
		with (_button_container)
		{
		
			// Define a posição do container dentro do Canvas
			node_set_position(GUI_WIDTH/2, GUI_HEIGHT * .5);
		
			// Margem entre os botões do container
			container_set_margin(2,2);
			
			var _banner = new node_button($"options_banner", false);
			with (_banner)
			{
				// Tamanho base do botão
				node_set_size(160, 96);
			
				// Adicionando texto
				node_add_text("menu_options", "interface_14", #ffffff, true);
			 
				// Adicionando sprite
				node_add_sprite(spr_ui_level_select_banner);
			
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
			
			var _main_volume_option = new node_button($"main_volume_option");
			with (_main_volume_option)
			{
				add_component_processor();
				processor.add_process(
					function() {
						self.text = $"{language_get_localized_text("options_volume_main")}: {round(global.settings_data.audio.volume_main * 100)}"
					},
					true
				);
				processor.add_process(
					function() {
						var _dir = input_check_movement_pressed().x;
						if (_dir != 0) {
							global.settings_data.audio.volume_main = qwrap(global.settings_data.audio.volume_main + (_dir * .1), 0, 1);
							audio_set_volume_sys_main(global.settings_data.audio.volume_main);
							save_settings();
							audio_play_sfx(sound_click);
						}
					},
					false
				);
			
				// Tamanho base do botão
				node_set_size(290, 54 * .9);
				
				node_set_scale(1, 1.1);
			
				// Adicionando texto
				node_add_text($"{language_get_localized_text("options_volume_main")}: {round(global.settings_data.audio.volume_main * 100)}", "interface_8", #ffffff, true);
				
				sound_click = snd_ui_select;
				
				// Adicionando sprite
				node_add_sprite(spr_ui_options_button);
			
				// Adicionando sprite para quando o botão for selecionado
				node_sprite_set_hover(spr_ui_options_button_hover);
			
				//node_sprite_set_scale(2.5, 1);
						
				// Adicionado uma função para rodar quando o node for clicado
				var _click_action = function(_node)
				{	
					var _diff = device_mouse_x_to_gui(0) - _node.transform.position.x;
					var _dir = 1;
					
					var _width = _node.transform.size.x * .2;
					
					if (global.input_profile.mode == INPUT_MODE.MOUSE) and (abs(_diff) > _width) {
						_dir = sign(_diff);
					}
					
					global.settings_data.audio.volume_main = qwrap(global.settings_data.audio.volume_main + .1 * _dir, 0, 1);
					audio_set_volume_sys_main(global.settings_data.audio.volume_main);
					save_settings();
				
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
		
			var _music_volume_option = new node_button($"music_volume_option");
			with (_music_volume_option)
			{
				add_component_processor();
				processor.add_process(
					function() {
						self.text = $"{language_get_localized_text("options_volume_music")}: {round(global.settings_data.audio.volume_music * 100)}"
					},
					true
				);
				processor.add_process(
					function() {
						var _dir = input_check_movement_pressed().x;
						if (_dir != 0) {
							global.settings_data.audio.volume_music = qwrap(global.settings_data.audio.volume_music + (_dir * .1), 0, 1);
							audio_set_volume_sys_music(global.settings_data.audio.volume_music);
							save_settings();
							audio_play_sfx(sound_click);
						}
					},
					false
				);
			
				// Tamanho base do botão
				node_set_size(290, 54 * .9);
				
				node_set_scale(1, 1.1);
			
				// Adicionando texto
				node_add_text($"{language_get_localized_text("options_volume_music")}: {round(global.settings_data.audio.volume_music * 100)}", "interface_8", #ffffff, true);
			
				// Adicionando sprite
				node_add_sprite(spr_ui_options_button);
				
				sound_click = snd_ui_select;
			
				// Adicionando sprite para quando o botão for selecionado
				node_sprite_set_hover(spr_ui_options_button_hover);
			
				//node_sprite_set_scale(2.5, 1);
						
				// Adicionado uma função para rodar quando o node for clicado
				var _click_action = function(_node)
				{	
					var _diff = device_mouse_x_to_gui(0) - _node.transform.position.x;
					var _dir = 1;
					
					var _width = _node.transform.size.x * .2;
					
					if (global.input_profile.mode == INPUT_MODE.MOUSE) and (abs(_diff) > _width) {
						_dir = sign(_diff);
					}
					
					global.settings_data.audio.volume_music = qwrap(global.settings_data.audio.volume_music + .1 * _dir, 0, 1);
					audio_set_volume_sys_music(global.settings_data.audio.volume_music);
					
					save_settings();
				
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
		
			var _sound_volume_option = new node_button($"sound_volume_option");
			with (_sound_volume_option)
			{
				add_component_processor();
				processor.add_process(
					function() {
						self.text = $"{language_get_localized_text("options_volume_sound")}: {round(global.settings_data.audio.volume_sfx * 100)}"
					},
					true
				);
				processor.add_process(
					function() {
						var _dir = input_check_movement_pressed().x;
						if (_dir != 0) {
							global.settings_data.audio.volume_sfx = qwrap(global.settings_data.audio.volume_sfx + (_dir * .1), 0, 1);
							audio_set_volume_sys_sfx(global.settings_data.audio.volume_sfx);
							save_settings();
							audio_play_sfx(sound_click);
						}
					},
					false
				);
			
				// Tamanho base do botão
				node_set_size(290, 54 * .9);
				
				node_set_scale(1, 1.1);
			
				// Adicionando texto
				node_add_text($"{language_get_localized_text("options_volume_sound")}: {round(global.settings_data.audio.volume_sfx * 100)}", "interface_8", #ffffff, true);
			
				// Adicionando sprite
				node_add_sprite(spr_ui_options_button);
				
				sound_click = snd_ui_select;
			
				// Adicionando sprite para quando o botão for selecionado
				node_sprite_set_hover(spr_ui_options_button_hover);
			
				//node_sprite_set_scale(2.5, 1);
						
				// Adicionado uma função para rodar quando o node for clicado
				var _click_action = function(_node)
				{	
					var _diff = device_mouse_x_to_gui(0) - _node.transform.position.x;
					var _dir = 1;
					
					var _width = _node.transform.size.x * .2;
					
					if (global.input_profile.mode == INPUT_MODE.MOUSE) and (abs(_diff) > _width) {
						_dir = sign(_diff);
					}
					
					global.settings_data.audio.volume_sfx = qwrap(global.settings_data.audio.volume_sfx + .1 * _dir, 0, 1);
					audio_set_volume_sys_sfx(global.settings_data.audio.volume_sfx);
					
					save_settings();
				
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
			
			var _language_mode_option = new node_button($"language_option");
			with (_language_mode_option)
			{
				add_component_processor();
				processor.add_process(
					function() {
						self.text = $"{language_get_localized_text("options_language")}: {language_get_localized_text("language")}"
					},
					true
				);
				processor.add_process(
					function() {
						var _dir = input_check_movement_pressed().x;
						if (_dir != 0) {
							audio_play_sfx(sound_click);
							settings_alternate_language();
						}
					},
					false
				);
			
				// Tamanho base do botão
				node_set_size(290, 54 * .9);
				
				node_set_scale(1, 1.1);
			
				// Adicionando texto
				node_add_text($"{language_get_localized_text("options_language")}: {language_get_localized_text("language")}", "interface_8", #ffffff, true);
			
				// Adicionando sprite
				node_add_sprite(spr_ui_options_button);
				
				sound_click = snd_ui_select;
			
				// Adicionando sprite para quando o botão for selecionado
				node_sprite_set_hover(spr_ui_options_button_hover);
			
				//node_sprite_set_scale(2.5, 1);
						
				// Adicionado uma função para rodar quando o node for clicado
				var _click_action = function(_node)
				{		
					settings_alternate_language();
				
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
			
			var _back = new node_button($"back_button");
			with (_back)
			{
				// Tamanho base do botão
				node_set_size(200,48);
				node_set_scale(1, .96);
			
				// Adicionando texto
				node_add_text("menu_back", "interface_14", #ffffff, true);
			 
				// Adicionando sprite
				node_add_sprite(spr_ui_9slice_32);
			
				// Adicionando sprite para quando o botão for selecionado
				node_sprite_set_hover(spr_ui_9slice_32_hover);
			
				sound_click = snd_ui_select;
				
				//node_sprite_set_scale(4, 1.2);
						
				// Adicionado uma função para rodar quando o node for clicado
				var _click_action = function(_node)
				{		
					node_change_active_canvas(1);
				
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
			
			//if (ON_WINDOWS)
			//{
			//	// Agora que os structs dos botões estão completes, adiciono eles no container
			//	node_add(_banner, _main_volume_option, _music_volume_option, _sound_volume_option, _window_mode_option, _language_mode_option, _back);		
			//}
			//else
			
			
			// Agora que os structs dos botões estão completes, adiciono eles no container
			node_add(_banner, _main_volume_option, _music_volume_option, _sound_volume_option, _language_mode_option, _back);		
			
		}		
	
		// Adiciono o struct do container, já com os botões criados, dentro do Canvas
		node_add(_button_container);
	
		// Chama a função de awake para termianr a configuração interna da interface
		__awake();
	}
	
	return _options_menu;
}
	
function ui_create_level_select() {
	var _level_select = new node_canvas("level_select", NODE_ORIGIN.TOP_LEFT);
	with (_level_select)
	{
		// Defina o tamanho do canvas para o tamanho da GUI
		node_set_size(GUI_WIDTH, GUI_HEIGHT);
	
		// ANIMAÇÂO
		node_set_call_delay(0.2);
	
		add_component_renderer();
		renderer.custom_draw = function(_node) {
			draw_sprite_ext(
				spr_ui_level_select_background,
				0,
				GUI_WIDTH / 2,
				GUI_HEIGHT * .625,
				11,
				9,
				0,
				#ffffff,
				1
			);
		}
	
		var _banner = new node_button($"level_select_banner", false);
		with (_banner)
		{
			// Define a posição do container dentro do Canvas
			node_set_position(GUI_WIDTH/2, GUI_HEIGHT * .16);
		
			// Tamanho base do botão
			node_set_size(230, 90);
	
			// Adicionando texto
			node_add_text("menu_level_select", "interface_14", #ffffff, true);
	 
			// Adicionando sprite
			node_add_sprite(spr_ui_level_select_banner);
	
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
	
		// Cria container horizontal para distribuir os botões do menu
		var _button_container = new node_container_grid("level_select_buttons", new Vector2(6, 5), new Vector2(52, 52))
		with (_button_container)
		{
			add_component_processor();
			processor.add_process(
				function() {
					if input_check_pressed("act_return") {
						audio_play_sfx(snd_ui_select);
						node_change_active_canvas(1);
					}
				},
				true
			);
		
			// Define a posição do container dentro do Canvas
			node_set_position(GUI_WIDTH/2, GUI_HEIGHT * .625);
		
			// Margem entre os botões do container
			container_set_margin(0,0);
		
			for (var i = 1; i <= 30; i++) {
			
				// Cria botão de Play
				var _button = new node_button($"start_button", (i <= global.game_data.level_unlock));
				with (_button)
				{	
					index = i;
					unlocked = (i <= global.game_data.level_unlock);
				
					add_component_processor();
					processor.add_process(
						function() {
							if input_check_pressed("act_accept") {
								obj_main.goto_level(other.canvas_active.nav_node_selected.index);
							}
						},
						false
					);
				
					processor.add_process(
						function(_node) {
							if _node.node_active {
								_node.node_text_set_colors(#000000);
								_node.text_scale.x = .5;
								_node.text_scale.y = .5;
							}
							else {
								_node.node_text_set_colors(#ffffff);
								_node.text_scale.x = 1;
								_node.text_scale.y = 1;
							}
						},
						true
					);
			
					// Tamanho base do botão
					node_set_size(48,48);
					
					node_sprite_set_scale(1.3333, 1.3333);
					
					// Adicionando sprite
					if unlocked {
						node_add_sprite(spr_ui_level_select);
						node_add_text(i, "interface_14", #ffffff, true);
					}
					else {
						node_add_sprite(spr_ui_level_select_blocked);
						node_add_text("", "interface_14", #61353B, true);
					}
			
					// Adicionando sprite para quando o botão for selecionado
					node_sprite_set_hover(spr_ui_level_select_hover);
			
					//node_sprite_set_scale(1, 1);
						
					// Adicionado uma função para rodar quando o node for clicado
					var _click_action = function(_node)
					{		
						// Criando um Tween para animar o botão ao ser clicado
				
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
				node_add(_button);
			}
		}		
	
		// Adiciono o struct do container, já com os botões criados, dentro do Canvas
		node_add(_banner, _button_container);
	
		// Chama a função de awake para termianr a configuração interna da interface
		__awake();
	}
	
	return _level_select;
}
	
function ui_credit_title(_name, _text)
{
	var _title = new node_button(_name, false);
	with(_title)
	{
		node_text_set_box(42 * 5, 46);
		node_set_size(42 * 5, 46);
		
		node_add_sprite(spr_ui_credits);
		node_sprite_set_scale(1.25, 1);
		node_add_text(_text, "interface_12", #3C232C, true);				
	}	
	
	return _title;
}

function ui_credit_name(_name, _text)
{
	var _title = new node_button(_name, false);
	with(_title)
	{
		node_text_set_box(42 * 6, 46);
		node_set_size(42 * 6, 46);
		
		//node_add_sprite(spr_ui_credits_dark);

		var _text_width = string_width(_text) + 25;
		var _spr_width	= sprite_get_width(spr_ui_credits_dark);
		var _scale_text = (_text_width / _spr_width);
		
		//node_sprite_set_scale(_scale_text, 1);
		node_add_text(_text, "interface_12", #F4DFB2, true);				
	}	
	
	return _title;
}

function ui_draw_input_button(_node)
{
	var _transform = _node.transform;
	
	var _sprite_x	= _transform.position.x,
		_sprite_y	= _transform.position.y,
		_text_x		= _transform.position.x + (_node.text_offset.x * _transform.scale.x),
		_text_y		= _transform.position.y + (_node.text_offset.y * _transform.scale.y);

	
	if (!_node.text_calculated)
	{
	    draw_set_font(_node.font);

	    var _txt_width = string_width(_node.text);

	    _node.text_scale = new Vector2(1, 1);

	    if (_txt_width > _node.text_box.x)
	    {
	        _node.text_scale.x = round((_node.text_box.x / _txt_width) * 10) / 10;
	    }

	    _node.text_scale.y = _node.text_scale.x;

	    _node.text_calculated = true;
	}
				
	if (_node.sprite != noone)
	{	
		draw_sprite_ext(
			_node.sprite, 
			_node.sub_img, 
			_transform.position.x + 4, 
			_transform.position.y + 4, 
			(_node.transform.size.x / sprite_get_width(_node.sprite)) * (_transform.scale.x * _node.sprite_scale.x), 
			(_node.transform.size.y / sprite_get_height(_node.sprite)) * (_transform.scale.y * _node.sprite_scale.y), 
			_transform.rotation,
			#000000, 
			_transform.alpha * .33
		);
		draw_sprite_ext(
			_node.sprite, 
			_node.sub_img,
			_transform.position.x, 
			_transform.position.y, 
			(_node.transform.size.x / sprite_get_width(_node.sprite)) * (_transform.scale.x * _node.sprite_scale.x), 
			(_node.transform.size.y / sprite_get_height(_node.sprite)) * (_transform.scale.y * _node.sprite_scale.y), 
			_transform.rotation,
			_node.color, 
			_transform.alpha
		);
	}						
	
	// Draw sets
	draw_set_font(_node.font);
	draw_set_valign(_node.alignment_v);
	draw_set_halign(_node.alignment_h);
	
	// Drawing text
	draw_text_ext_transformed_color(
		_text_x, 
		_text_y, 
		_node.text, 
		_node.separation, 
		_node.horizontal_wrap, 
		_node.text_scale.x * _transform.scale.x, 
		_node.text_scale.y * _transform.scale.y, 
		_transform.rotation, 
		_node.color1, _node.color2, _node.color3, _node.color4, 
		_transform.alpha
	);
	
	if (_node.input_sprite != noone)
	{
		switch(_node.input_position)
		{
			case "bottom_left":
				var _input_x = _transform.position.x - (sprite_get_width(_node.sprite) * .45) * (_transform.scale.x * _node.sprite_scale.x);
				var _input_y = _transform.position.y + (sprite_get_height(_node.sprite) * .45) * (_transform.scale.y * _node.sprite_scale.y);
			break;
		
			default:
			case "top_left":
				var _input_x = _transform.position.x - (sprite_get_width(_node.sprite) * .45) * (_transform.scale.x * _node.sprite_scale.x);
				var _input_y = _transform.position.y - (sprite_get_height(_node.sprite) * .45) * (_transform.scale.y * _node.sprite_scale.y);
			break;
		}
		
		draw_input_sprite(
			_node.input_sprite, 
			_node.sub_img, 
			_input_x, 
			_input_y, 
			_transform.scale.x,
			_transform.scale.y,
			_transform.rotation,
			_node.color, 
			_transform.alpha
		);	
	}

	// Reseting draw_set
	draw_set_font(-1);
	draw_set_valign(-1);
	draw_set_halign(-1);
}

function ui_button_add_input_indicator(_input, _position = "top_left") {
	input_name			= _input;
	input_position		= _position;
	input_sprite		= input_get_sprite(input_name);			
	
	renderer.set_custom_draw(ui_draw_input_button);
		
	var _update = function(_node)
	{
		text			= language_get_localized_text(text_key);
		font			= language_get_localized_font(font_key);
		input_sprite	= input_get_sprite(input_name);
		input_position	= input_position;
		text_calculated = false;
	}
	node_set_custom_update(_update);
}

global.credits_trigger = false;