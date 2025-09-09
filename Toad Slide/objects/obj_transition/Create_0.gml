/// @description Methods and Variables

// State Machine
transition_state = "transition_in"; // transition_in, transition_stay, transition_out
transition_state_init = false;

// TIMERS (MEASURED IN SECONDS! 1 = 1 second)
fade_in_duration = 0.3;		
fade_out_duration = 0.3;

// Transion Att
transition_alpha = 0;

#region METHODS

///@function				transition_room_changed()
///@description				Método chamado pelo sistema quando a mudança de room é feita
transition_room_changed = function()
{
	transition_change_state("transition_out");
}

///@function				transition_change_state(_state)
///@description				Troca o estado da transição e reseta varíaveis
///@param {string} _state	Novo estado a ser definido
transition_change_state = function(_state)
{
	transition_state = _state;
	transition_state_init = false;
}

// States

///@function				transition_state_in()
///@description				Comportamento durante o estado "transition_in"
transition_state_in = function()
{
	if (transition_state_init)
	{
		transition_state_init = true;
		transition_alpha = 0;
	}
	
	transition_alpha = approach(transition_alpha, 1, delta_time_seconds() / fade_in_duration);
	
	if (transition_alpha >= 1)
	{
		transition_change_state("transition_stay");
		__scene_transition_change_room();
	}
}

///@function				transition_state_out()
///@description				Comportamento durante o estado "transition_out"
transition_state_out = function()
{
	if (transition_state_init)
	{
		transition_state_init = true;
		transition_alpha = 1;
	}
	
	transition_alpha = approach(transition_alpha, 0, delta_time_seconds() / fade_in_duration);
	
	if (transition_alpha <= 0)
	{
		__scene_transition_end();
	}
}

///@function				transition_state_stay()
///@description				Comportamento durante o estado "transition_stay"
transition_state_stay = function()
{

}

///@function				transition_state_controller()
///@description				Gerencia a chamada dos métodos de cada estado
transition_state_controller = function()
{
	switch (transition_state)	
	{
		case "transition_in":
			transition_state_in();
			break;
		case "transition_stay":
			transition_state_stay();
			break;
		case "transition_out":
			transition_state_out();
			break;
	}
}

// DRAW

///@function				transition_draw()
///@description				Método que desenha o efeito da transição na GUI
transition_draw = function()
{
	var _width = GUI_WIDTH,
		_height = GUI_HEIGHT;
	
	draw_set_alpha(transition_alpha);
	draw_rectangle_color(0,0, _width, _height, c_black, c_black, c_black, c_black, false);
	draw_set_alpha(1);
}

#endregion

