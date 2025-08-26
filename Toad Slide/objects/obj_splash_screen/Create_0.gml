/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

splash_queue = global.project_settings.splash_screen;
splash_queue_len = array_length(splash_queue);

// State Machine
splash_state = "fade_in";
splash_ind = 0;
splash_state_init = false;
splash_last_img = splash_ind >= splash_queue_len - 1;

// SPRITE ATT
splash_alpha = 1;
splash_scale = .66;

// TIMERS (MEASURED IN SECONDS! 1 = 1 second)
fade_in_duration = 1;		
fade_out_duration = 1;
splash_timer = 0;

// Time that the splashscreen will stay on the screen with full alpha before fading out
splash_stay_timer_max = 1;
splash_stay_timer = splash_stay_timer_max;

// Interval between multiples splash sprites
interval_timer_max = 1;
interval_timer = interval_timer_max;

/*
	All timers are measured in seconds
	fade_in_duration = 1 means that the fade in will last 1 second
	When subtracting or adding a value to those timers, i use the delta_time_seconds() function
	To get the correct value for the operation that guarantee the timers will stay the same
	duration no matter the current fps
*/

#region METHODs

// State Machine
splash_end_presentation = function()
{
	scene_change_room(global.project_settings.menu_room);	
}

splash_change_state = function(_state)
{
	splash_state_init = false;
	splash_state = _state;
}

splash_skip_next = function()
{
	interval_timer -= 1 * delta_time_seconds();
	
	if (splash_last_img)
	{
		splash_end_presentation();
	}
	else if (interval_timer <= 0)
	{
		interval_timer = interval_timer_max;
		splash_ind++;
		splash_ind = clamp(splash_ind, 0, splash_queue_len - 1);		
		
		if (splash_ind >= splash_queue_len - 1)
		{
			splash_last_img = true;	
		}
		splash_change_state("fade_in");
	}
	
}

splash_state_fade_in = function()
{
	if (!splash_state_init)
	{
		splash_timer = 0;
		splash_alpha = 1;
		splash_state_init = true;
	}
	
	/*
		Substitui o delta_time por um valor fixo, dependendo do projeto e do tamanho dos arquivos sendo carregados
		o valor do delta_time pode vir muito grande nos primeiros frames, o que atrapalha o calculo dos tempos
		
		0.01 é o valor esperado a ser retornado pelo delta_time em um jogo rodando a 60fps
		splash_timer += delta_time_seconds();
	*/
		
	splash_timer += 0.01;
	//splash_alpha = EaseInOutSine(splash_timer, 0, 1, fade_in_duration);
	
	if (splash_alpha >= 1)
	{
		splash_change_state("stay");
	}
}

splash_state_stay = function()
{
	if (!splash_state_init)
	{
		splash_stay_timer = 0;
		splash_timer = 0;
		splash_state_init = true;
	}
	
	splash_stay_timer += delta_time_seconds();
	if (splash_stay_timer >= splash_stay_timer_max)
	{
		if (splash_last_img && !global.__save_control.save_loaded)
		{
			return;
		}
		splash_change_state("fade_out");
	}	
}

splash_state_fade_out = function()
{
	if (!splash_state_init)
	{	
		splash_timer = 0;
		splash_alpha = 1;
		splash_state_init = true;
	}
	
	// Nessa parte o load dos arquivos já foi finalizado, então pode retornar a função de delta_time
	
	splash_timer += delta_time_seconds();
	splash_alpha = EaseInOutSine(splash_timer, 1, -1, fade_out_duration);
	
	if (splash_alpha <= 0.05)
	{
		splash_skip_next();
	}
}

splash_state_control = function()
{
	
	switch (splash_state)
	{
		case "fade_in":
			splash_state_fade_in();	
			break;
		
		case "stay":
			splash_state_stay();
			break;
			
		case "fade_out":
			splash_state_fade_out();
			break;
	}
}

// DRAW
splash_draw = function()
{
	var _sprite = splash_queue[splash_ind];
	var _x = GUI_WIDTH / 2,
		_y = GUI_HEIGHT / 2;
	
	draw_sprite_ext(spr_afil_logo, 0, _x, _y, .233, .233, 0, c_white, splash_alpha);
	//draw_sprite_ext(_sprite, 0, _x, _y, splash_scale, splash_scale, 0, -1, splash_alpha);
}

splash_get_scale = function()
{
	var _spr = splash_queue[splash_ind];
	var _width = sprite_get_width(_spr);
	
	splash_scale  = GUI_WIDTH / _width;
	
}	

// INPUT
get_skip_input = function()
{
	if (input_check_any()) {
		if (splash_last_img && !global.__save_control.save_loaded)
		{
			return;	
		}
		
		if (splash_state != "fade_out") splash_change_state("fade_out");
	}		
}
#endregion

#region START

splash_get_scale();

#endregion