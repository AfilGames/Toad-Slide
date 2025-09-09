/// @description Métodos de controle de áudio

// Carrega todos os audiogroups
__audio_group_load_all();

// Variaveis de controle de fade de áudio
bgm_fade_in_amount = 0.1;
bgm_fade_out_amount = 0.1;
bgm_fade_state_flag = false;
fade_sys_mus_vol_prev = 1;

// Variaveis de controla da queue de sfx
sfx_queue_played = false;

///@function		bgm_control()
///@description		Controla os audios de música e transição entre eles
bgm_control = function()
{
	var _control = global.__audio_control;
	if (!_control.audio_groups_loaded) return;
	
	if (_control.bgm_change_flag)
	{
		if (_control.bgm_fade)
		{
			bgm_fade_control();
		}
		else
		{
			bgm_stop_all_music();
			bgm_play_next_music();
			_control.bgm_change_flag = false;
		}
	}
}

///@function		bgm_stop_all_music()
///@description		Desativa todas as músicas sendo tocadas no momento 
bgm_stop_all_music = function()
{
	var _control = global.__audio_control;
	var _active_music = _control.bgm_active_music;
	if (is_array(_active_music))
	{
		var _active_mus_len = array_length(_active_music);
		for (var _i = 0; _i < _active_mus_len; _i++)
		{
			var _music = _active_music[_i];
			audio_stop_sound(_music);
		}	
	}
	else
	{
		audio_stop_sound(_active_music);
	}
	global.__audio_control.bgm_is_playing = false;
}

///@function		bgm_play_next_music()
///@description		Toca as músicas armazenadas na fila
bgm_play_next_music = function()
{
	var _control = global.__audio_control;
	var _next_music = _control.bgm_next_music;
	var _prio = global.__audio_control.bgm_priority;
	
	if (_next_music == noone) return;
	
	if (is_array(_next_music))
	{
		var _next_mus_len = array_length(_next_music);
		for (var _i = 0; _i < _next_mus_len; _i++)
		{
			var _music = _next_music[_i];			
			audio_play_sound(_music, _prio, true);
		}			
	}
	else
	{
		audio_play_sound(_next_music, _prio, true);
	}
	_control.bgm_active_music = variable_clone(_next_music);
	_control.bgm_next_music = noone;
	
	global.__audio_control.bgm_is_playing = true;
	show_debug_message($"Now playing {_next_music}");
}

///@function		bgm_fade_control()
///@description		Controla o fade in e out de audio
bgm_fade_control = function()
{
	var _control = global.__audio_control;
	switch (_control.bgm_fade_state)
	{
		case "in":
			if (!bgm_fade_state_flag)
			{
				bgm_play_next_music();
				bgm_fade_state_flag = true;
			}
			if (_control.bgm_fade_in)
			{
				var _vol = audio_get_volume_sys_music();
				_vol = lerp(_vol, fade_sys_mus_vol_prev, bgm_fade_in_amount);
				audio_set_volume_sys_music(_vol);
			
				if (_vol >= fade_sys_mus_vol_prev) 
				{
					_control.bgm_fade = false;
					_control.bgm_change_flag = false;
					bgm_fade_state_flag = false;
				}
			}
			else
			{
				audio_set_volume_sys_music(fade_sys_mus_vol_prev);		
				_control.bgm_fade = false;
				_control.bgm_change_flag = false;
				bgm_fade_state_flag = false;
				
			}	
			break;
			
		case "out":
			if (!bgm_fade_state_flag)
			{
				fade_sys_mus_vol_prev = audio_get_volume_sys_music();
				bgm_fade_state_flag = true;
			}
			if (_control.bgm_fade_out)
			{
				var _vol = audio_get_volume_sys_music();
				_vol = lerp(_vol, 0, bgm_fade_out_amount)
				audio_set_volume_sys_music(_vol);
				if (_vol <= 0.05) 
				{
					bgm_stop_all_music();
					bgm_fade_state_flag = false;
					_control.bgm_fade_state = "in";
				}
			}
			else
			{
				audio_set_volume_sys_music(0);
				bgm_stop_all_music();
				bgm_fade_state_flag = false;
				_control.bgm_fade_state = "in";
			}	
			break;
	}	
}

///@function		sfx_queue_control()
///@description		Controla a fila de audios de efeitos especiais
sfx_queue_control = function()
{
	var _control = global.__audio_control;
	if (!_control.audio_groups_loaded) return;

	if (_control.play_sfx_queue && array_length(_control.sfx_queue) > 0)
	{
		if (!sfx_queue_played)
		{
			audio_play_sfx(_control.sfx_queue[0]);
			sfx_queue_played = true;
		}
		else
		{
			if (!audio_is_playing(_control.sfx_queue[0]))
			{
				array_shift(_control.sfx_queue);
				sfx_queue_played = false;
			}
		}		
	}
}