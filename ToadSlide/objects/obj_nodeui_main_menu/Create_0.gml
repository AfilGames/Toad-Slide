/// @description Setup

// Inherit the parent event
event_inherited();

title_screen = new node_canvas("title_screen", NODE_ORIGIN.TOP_LEFT);
with (title_screen)
{
	// Defina o tamanho do canvas para o tamanho da GUI
	node_set_size(GUI_WIDTH, GUI_HEIGHT);
	
	// ANIMAÇÂO
	node_set_call_delay(0.2);
	
	var _main_banner = new node_button($"main_banner", false);
	with (_main_banner)
	{
		add_component_processor();
		processor.add_process(
			function() {
				if (input_check_any() || porting_check_any_button_pressed_by_pad(global.pad_by_player[0])) { //input_check_pressed("act_accept") {
					show_debug_message("anybutton");
					node_change_active_canvas(1);
				}
			},
			false
		);
		
		node_add_text("", "interface_12", 0, true);
		
		node_set_position(GUI_WIDTH/2, GUI_HEIGHT * .33);
		
		node_sprite_set_scale(1, 1);
		
		// Tamanho base do botão
		node_set_size(sprite_get_width(spr_ui_logo) * .5, sprite_get_height(spr_ui_logo) * .5);
		
		// Adicionando sprite
		node_add_sprite(spr_ui_logo);
	
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
	var _button_container = new node_container_horizontal("title_buttons")
	with (_button_container)
	{		
		// Define a posição do container dentro do Canvas
		node_set_position(GUI_WIDTH/2, GUI_HEIGHT * .7);
		
		// Margem entre os botões do container
		container_set_margin(16,24);
		
		// Cria botão de Play
		var _start = new node_button($"start_button");
		with (_start)
		{	
			add_component_processor();
			processor.add_process(
				function() {
					if (input_check_any() || porting_check_any_button_pressed_by_pad(global.pad_by_player[0])) { 
						node_change_active_canvas(1);
					}
				},
				false
			);
			// Tamanho base do botão
			node_set_size(220,48);
			
			node_set_scale(1, 1);
			
			// Adicionando texto
			node_add_text("splash_start", "interface_10", #ffffff, true);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_9slice_32);
			
			// Adicionando sprite para quando o botão for selecionado
			node_sprite_set_hover(spr_ui_9slice_32_hover);
			
			//node_sprite_set_scale(6, 1.4);
						
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
		
		/*
			Os botões seguintes só replicam a construção do botão de PLAY
			quando temos botões que são na maior parte iguais uns aos outros
			é recomendado criar algum metodo de abstração para evitar tanta repetição de código
		*/
		
		// Agora que os structs dos botões estão completes, adiciono eles no container
		node_add(_start);	
	}		
	
	// Adiciono o struct do container, já com os botões criados, dentro do Canvas
	node_add(_main_banner, _button_container);
	
	// Chama a função de awake para termianr a configuração interna da interface
	__awake();
}

// Criando o canvas para o menu principal
main_menu = new node_canvas("main_menu", NODE_ORIGIN.TOP_LEFT);
with (main_menu)
{
	// Defina o tamanho do canvas para o tamanho da GUI
	node_set_size(GUI_WIDTH, GUI_HEIGHT);
	
	// ANIMAÇÂO
	node_set_call_delay(0.2);
	
	// Cria container horizontal para distribuir os botões do menu
	var _button_container = new node_container_vertical("menu_buttons")
	with (_button_container)
	{
		processor.add_process(
			function() {
				if input_check_pressed("act_return") {
					audio_play_sfx(snd_ui_select);
					node_change_active_canvas(0);
				}
			},
			true
		);
		
		// Define a posição do container dentro do Canvas
		node_set_position(GUI_WIDTH/2, GUI_HEIGHT * .5);
		
		// Margem entre os botões do container
		container_set_margin(5,5);
		
		var _main_banner = new node_button($"main_banner", false);
		with (_main_banner)
		{
			node_add_text("", "interface_14", 0, true);
			
			node_sprite_set_scale(1.33, 1.33);
			
			// Tamanho base do botão
			node_set_size(sprite_get_width(spr_ui_logo) * .25, sprite_get_height(spr_ui_logo) * .25);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_logo);
			
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
		var _play = new node_button($"play_button");
		with (_play)
		{
			// Tamanho base do botão
			node_set_size(220,42);
			node_set_scale(1, 1);
			
			// Adicionando texto
			node_add_text("menu_play", "interface_14", #ffffff, true);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_9slice_32);
			
			// Adicionando sprite para quando o botão for selecionado
			node_sprite_set_hover(spr_ui_9slice_32_hover);
			
			//node_sprite_set_scale(5, 1.4);
						
			// Adicionado uma função para rodar quando o node for clicado
			var _click_action = function(_node)
			{		
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
		var _options = new node_button($"options_button");
		with (_options)
		{

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
				node_change_active_canvas(3);
				
				mini_tween(_node.transform, 0.05)				// Defino o alvo como o transform do botão e o timer para 0.1 segundos
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
		
		// Botão de Créditos
		var _credits = new node_button($"credit_button");
		with (_credits)
		{
			// Tamanho base do botão
			node_set_size(220,42);
			node_set_scale(1, 1);
			
			// Adicionando texto
			node_add_text("menu_credits", "interface_14", #ffffff, true);
			
			// Adicionando sprite
			node_add_sprite(spr_ui_9slice_32);
			
			// Adicionando sprite para quando o botão for selecionado
			node_sprite_set_hover(spr_ui_9slice_32_hover);
			
			//node_sprite_set_scale(5, 1.4);
			
			// Adicionado uma função para rodar quando o node for clicado
			var _click_action = function(_node)
			{		
				node_change_active_canvas(4);
				
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
		
		if (ON_WINDOWS)
		{
			var _exit = new node_button($"exit_button");
			with (_exit)
			{
				// Tamanho base do botão
				node_set_size(220,42);
				node_set_scale(1, 1);
			
				// Adicionando texto
				node_add_text("menu_exit", "interface_14", #ffffff, true);
			
				// Adicionando sprite
				node_add_sprite(spr_ui_9slice_32);
			
				// Adicionando sprite para quando o botão for selecionado
				node_sprite_set_hover(spr_ui_9slice_32_hover);
			
				//node_sprite_set_scale(5, 1.4);
			
				// Adicionado uma função para rodar quando o node for clicado
				var _click_action = function(_node)
				{		
					game_end();
				
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
			node_add(_main_banner, _play, _options, _credits, _exit);
		}
		else{
			// Agora que os structs dos botões estão completes, adiciono eles no container
			node_add(_main_banner, _play, _options, _credits);		
		}
	}		
	
	// Adiciono o struct do container, já com os botões criados, dentro do Canvas
	node_add(_button_container);
	
	// Chama a função de awake para termianr a configuração interna da interface
	__awake();
}

level_select = ui_create_level_select();

credits_menu = new node_canvas("credits_menu", NODE_ORIGIN.TOP_LEFT)
with (credits_menu)
{
	// Defina o tamanho do canvas para o tamanho da GUI
	node_set_size(GUI_WIDTH, GUI_HEIGHT);
	node_set_call_delay(.2);
	
	var _button_container_bottom = new node_container_vertical("credits_btn_back",, NODE_ORIGIN.BOTTOM_RIGHT);
	with (_button_container_bottom)
	{
		
		// Define a posição do container dentro do Canvas
		node_set_position(GUI_WIDTH - 16, GUI_HEIGHT - 12);
		
		// Margem entre os botões do container
		container_set_margin(8, 2);
		
		var _accelerate = new node_button($"confirm_button", true);
		with (_accelerate)
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
			
			navigator.block_directions(true, true, true, true);
			
			node_set_position(GUI_WIDTH - 72, GUI_HEIGHT - 24);
		
			// Tamanho base do botão
			node_set_size(130, 42);
		
			// Adicionando texto
			node_add_text("credits_accelerate", "interface_8", #ffffff, true);
			
			// Adicionando sprite	
			node_add_sprite(spr_ui_ingame_indicator);
			
			// Adicionando sprite para quando o botão for selecionado
			//node_sprite_set_hover(spr_ui_9slice_32_hover);
		
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
			}				
			set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
		
			// Escala inicial do node
			node_set_start_scale(0,0);
			
			ui_button_add_input_indicator("act_accept");
			
			// Definindo animações de estado do Node
			with (animator)
			{		
				// Aqui utilizo as animações padrão de escala para definir o comportamento delas
				// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
				set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
				set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
			}
		}
		
		var _back = new node_button($"back_button", true);
		with (_back)
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
				
				navigator.block_directions(true, true, true, true);
				
				node_set_position(GUI_WIDTH - 72, GUI_HEIGHT - 24);
			
				// Tamanho base do botão
				node_set_size(130, 42);
			
				// Adicionando texto
				node_add_text("pause_main_menu", "interface_8", #ffffff, true);
			
				// Adicionando sprite
				node_add_sprite(spr_ui_ingame_indicator);
				
				// Adicionando sprite para quando o botão for selecionado
				//node_sprite_set_hover(spr_ui_9slice_32_hover);
			
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
					
					node_change_active_canvas(1);
				}				
				set_click_action(_click_action)	// Defino a função que acabei de criar como a função que ira rodar no click do node_button
			
				// Escala inicial do node
				node_set_start_scale(0,0);
				
				ui_button_add_input_indicator("act_return");
				
				// Definindo animações de estado do Node
				with (animator)
				{		
					// Aqui utilizo as animações padrão de escala para definir o comportamento delas
					// no estado de Enter e Leave, mas poderia utilizar animações customizadas para isso
					set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
					set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
				}
			}

		// Agora que o struct do botão pause está completo, adiciono ele no container
		node_add(_accelerate, _back);
	}
	
	var _credit_container = new node_container_vertical("credit_container", NODE_VERTICAL_PATTERN.UP_DOWN, NODE_ORIGIN.TOP_CENTER);
	with (_credit_container)
	{
		scroll_speed = -80;
		
		container_set_margin(0, 5);
				
		node_set_position(GUI_WIDTH / 2, GUI_HEIGHT);
		node_set_start_position(GUI_WIDTH / 2, GUI_HEIGHT);
		add_component_processor();
		
		with (processor)
		{
			add_process(function (_node)
			{
				var _speed = _node.scroll_speed;
				
				var _accelerate = input_check(ACT_ACCEPT);
				var _back		= input_check(ACT_RETURN);
				if (_accelerate) _speed *= 3.5;
				
				_node.node_transform_move(0, _speed * delta_time_seconds());				
				
				if (_node.transform.position.y <=  -(_node.transform.size.y)) || (_back)
				{
					//_node.node_transform_move(0, GUI_HEIGHT + _node.transform.size.y);	
					node_change_active_canvas(1);
				}
			});
		}
		
		add_component_animator();
		with (animator)
		{
			set_default_anim_scale(NODE_MOTION_STATE.ENTER, EASING_CURVES.ELASTIC_OUT, 1, .5, 0);							
			set_default_anim_scale(NODE_MOTION_STATE.LEAVE, EASING_CURVES.SINE_IN, 0, .15, 0);
		}
		
		var _title = ui_credit_title("credit_studio", "credits_studio");
		with(_title)
		{
			node_set_size(42 * 7, 51 * 1);
			node_text_set_box(42 * 7, 51 * 1.75);
			
			node_add_sprite(spr_ui_credits_dark);
			node_sprite_set_scale(1, 1);
			node_add_text("credits_title", "interface_18", 0, true);						
		}
				
		var _studio = ui_credit_title("credit_studio", "credits_studio"),
			_director = ui_credit_title("credit_director", "credits_director"),
			_producer = ui_credit_title("credit_producer", "credits_producer"),
			_lead_producer = ui_credit_title("credit_lead_producer", "credits_lead_producer"),
			_gd = ui_credit_title("credit_manager", "credits_game_designer"),
			_programmer = ui_credit_title("credit_manager", "credits_programmer"),
			_pixel = ui_credit_title("credit_manager", "credits_pixel_artist"),
			_qa = ui_credit_title("credit_manager", "credits_qa_test"),
			_publisher_manager = ui_credit_title("credit_manager", "credits_publisher_manager"),
			_sound = ui_credit_title("credit_manager", "credits_sound"),
			_artist2d = ui_credit_title("credit_manager", "credits_2d_artist"),
			_marketing = ui_credit_title("credit_manager", "credits_marketing"),
			_marketing_manager = ui_credit_title("credit_manager", "credits_marketing_manager"),
			_porting = ui_credit_title("credit_manager", "credits_porting"),
			_porting_producer = ui_credit_title("credit_manager", "credits_porting_producer")
			
		var _afil = ui_credit_name("credit_afil", "Afil Games"),
			_antonio = ui_credit_name("credit_afil", "Antonio Filipe"),
			_ayrton = ui_credit_name("credit_afil", "Ayrton Costa"),
			_belarmino = ui_credit_name("credit_afil", "Victor de Oliveira Belarmino"),
			_evandro = ui_credit_name("credit_afil", "Evandro Junior"),
			_pernas = ui_credit_name("credit_afil", "Bernardo Sarto de Lucena"),
			_andre = ui_credit_name("credit_afil", "André Luna"),
			_neko = ui_credit_name("credit_afil", "Lucas Estevão"),
			_carol = ui_credit_name("credit_afil", "Carolina Sayuri"),
			_chico = ui_credit_name("credit_afil", "Mateus (Chico) Paulino"),
			_sayuri = ui_credit_name("credit_afil", "Sayuri Oshiyama"),
			_caio = ui_credit_name("credit_afil", "Caio Galisa"),
			_deekin = ui_credit_name("credit_afil", "Deekin"),
			_ivan = ui_credit_name("credit_afil", "Ivan 'IvanGogh' Neto"),
			_joaquim = ui_credit_name("credit_afil", "Joaquim Alberto"),
			_patricia = ui_credit_name("credit_afil", "Patricia Lucas"),
			_jose = ui_credit_name("credit_afil", "José Nilton Mendonça Junior"),
			_rafa = ui_credit_name("credit_afil","Rafael Neres"),
			_jovani = ui_credit_name("credit_afil", "Jovani Fracasso da Silva"),
			_giullia = ui_credit_name("credit_afil", "Giullia (Alrose) Alves"),
			_pamela = ui_credit_name("credit_afil", "Pâmella Sanchez"),
			_rubs = ui_credit_name("credit_afil", "Rúbia Beray Armond"),
			_guh = ui_credit_name("credit_afil", "Gustavo Souza"),
			_mike = ui_credit_name("credit_afil", "Mike Oliveira"),
			_luizalves = ui_credit_name("credit_afil", "Luiz Gustavo Alves"),
			_vitorg = ui_credit_name("credit_afil", "Vitor George"),
			_fabiot = ui_credit_name("credit_afil", "Fabio Tiburcio"),
			_gabrielp = ui_credit_name("credit_afil", "Gabriel Paixão"),
			_igormaia = ui_credit_name("credit_afil", "Igor Maia"),
			_mneto = ui_credit_name("credit_afil", "Moisés Azevedo Neto");
			
		node_add(
			_title,
			_studio, _afil,
			_director, _antonio,
			_lead_producer, _ayrton,
			_producer, _belarmino,
			_gd, _andre,
			_programmer, _neko,
			_pixel, _ivan,
			_sound, _giullia,	
			_artist2d, _caio, _sayuri,
			_marketing_manager, _rubs,
			_marketing, _pamela, _guh,
			_publisher_manager, _patricia,
			_porting_producer, _mike,
			_porting, _luizalves, _vitorg, _fabiot, _gabrielp, _igormaia, _mneto,
			_qa, _joaquim, _jose, _rafa
		);
	}
		
	node_add(_credit_container, _button_container_bottom);
	
	__awake();
}

options_menu = ui_create_option_menu();

// Defino minha coleção de canvas que podem ser exibidos por esse objeto
canvas_collection = [title_screen, main_menu, level_select, options_menu, credits_menu];

if global.credits_trigger {
	call_later(2, time_source_units_frames, function() {
			node_change_active_canvas(4);
		}
	)
	
	global.credits_trigger = false;
}