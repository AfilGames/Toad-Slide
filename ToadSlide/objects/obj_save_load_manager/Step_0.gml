/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Aplica o delay entre os procedimentos de save
if (global.__save_control.save_delay_next_call && !global.__save_control.ignore_delay){
	save_timer--;
	if (save_timer <= 0)
	{
		save_timer =  global.__save_control.save_delay;
		global.__save_control.save_delay_next_call = false;
	}
}
else
{
	save_calls_manager();	
}




















