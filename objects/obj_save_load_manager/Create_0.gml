/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

load_level_read = false;

// Delay entre os procedimentos de save
save_timer = global.__save_control.save_delay;

// Janela de frames antes que o procedimento de save inicia depois de ser chamado
start_commands_delay_max = 10;
start_commands_delay = start_commands_delay_max;

///@function		save_calls_manager()
///@description		Controla os tiemr e chamadas de de funções de save
save_calls_manager = function()
{
	// Checa se o sistema possui comandos a serem salvos e se já não esta salvando algo
	if (global.__save_control.perform_save && !global.__save_control.is_saving)
	{
		// Delay antes de iniciar os comandos, para caso outros comandos sejam inseridos em uma janela pequena de frames
		start_commands_delay--;
		if (start_commands_delay <= 0)
		{
			// Indica que o procedimento de save começou
			global.__save_control.is_saving = true;
			
			// Executa funções do sistema para iniciar o save
			__save_perform_commands();
			__save_write_buffer();
			
			// Reseta flags e timers
			global.__save_control.perform_save = false;
			start_commands_delay = start_commands_delay_max;
		}
	}
}


__save_load_buffer();