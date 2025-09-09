/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

block_input_calls_manager();

acc_timer_return = false;
if (acc_timer_checking)
{
	acc_timer -= delta_time_seconds();	
	if (acc_timer <= 0)
	{
		var _decreased_timer = acc_timer_total - acc_decrease;
		_decreased_timer = clamp(_decreased_timer, 0.1, acc_timer_total);
		acc_timer = _decreased_timer;
			
		acc_decrease += acc_timer * delta_time_seconds(2);
		acc_timer_return = true;
	} 
		
}else
{
	acc_decrease = 0;
	acc_timer = 0;
}	

acc_timer_checking = false;

//show_debug_message(global.input_profile.mode);