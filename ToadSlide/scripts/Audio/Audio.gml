/*
	Sistema de Controle de Audio
*/

global.__audio_control = {};
with (global.__audio_control)
{
	block_audio = false;
	audio_groups_loaded = true;
		
	bgm_priority = 0;
	sfx_priority = 0;
	
	sys_volume_main = 1;
	sys_volume_music = 1;
	sys_volume_sfx = 1;
		
	sfx_queue = [];
	play_sfx_queue = false;
	
	bgm_fade = false;
	bgm_fade_in = false;
	bgm_fade_out = false;
	bgm_change_flag = false;
	bgm_active_music = noone;
	bgm_next_music = noone;	
	bgm_fade_state = "in";
	bgm_is_playing = false;
}	


#region Audio System
///@function			__audio_group_load_all()
///@description			Load all audiogroups
function __audio_group_load_all()
{
	audio_group_load(ag_music);	
	audio_group_load(ag_sfx);	
}

///@function			__audio_group_loaded()
///@description			Called by the async event, set flags that the audiogroups were loaded
function __audio_group_loaded()
{
	global.__audio_control.audio_groups_loaded = true;	
	__audio_group_all_update_gain();
	
	show_debug_message("audio group loaded");
}

///@function				__audio_group_music_update_gain()
///@description				Calculate and update the gain of the audio group ag_music
function __audio_group_music_update_gain()
{
	var _vol_music = audio_get_volume_music() * audio_get_volume_sys_music();
	var _vol_main = audio_get_volume_main() * audio_get_volume_sys_main();
	var _ag_volume = _vol_music * _vol_main;
	
	if (audio_group_is_loaded(ag_music))
	{
		audio_group_set_gain(ag_music, _ag_volume, 0);
	}
}

///@function				__audio_group_sfx_update_gain()
///@description				Calculate and update the gain of the sfx group ag_sfx
function __audio_group_sfx_update_gain()
{
	var _vol_sfx = audio_get_volume_sfx() * audio_get_volume_sys_sfx();
	var _vol_main = audio_get_volume_main() * audio_get_volume_sys_main();
	var _ag_volume = _vol_sfx * _vol_main;
	
	if (audio_group_is_loaded(ag_sfx))
	{
		audio_group_set_gain(ag_sfx, _ag_volume, 0);
	}
}

///@function				__audio_group_all_update_gain()
///@description				Call all the audiogroup gain update functions
function __audio_group_all_update_gain()
{
	__audio_group_music_update_gain();
	__audio_group_sfx_update_gain();	
}

///@function				__audio_check_bgm_is_playing()
///@description				Check if the bgm is already playing
function __audio_check_bgm_is_playing(_bgm)
{
	var _is_playing = false;
	if (is_array(_bgm))
	{
		for (var _i = 0; _i < array_length(_bgm); _i++)
		{
			var _audio = _bgm[_i];
			_is_playing = audio_is_playing(_audio);
			
			if (!_is_playing) break;
		}
	}
	else
	{
		_is_playing = audio_is_playing(_bgm);
	}	
	
	return _is_playing;
}

#endregion

#region AUDIO VOLUME

#region AUDIO GET

///@function				audio_get_volume_main
///@description				Retorna o valor atual do volume principal (main)
function audio_get_volume_main()
{
	var _audio_settings = global.settings_data.audio;
	return _audio_settings.volume_main;
}

///@function				audio_get_volume_sfx
///@description				Retorna o valor atual do volume de efeitos especiais (sfx)
function audio_get_volume_sfx()
{
	var _audio_settings = global.settings_data.audio;
	return _audio_settings.volume_sfx;	
}

///@function				audio_get_volume_music
///@description				Retorna o valor atual do volume de efeitos música (music)
function audio_get_volume_music()
{
	var _audio_settings = global.settings_data.audio;
	return _audio_settings.volume_music;	
}

///@function				audio_get_volume_sys_main
///@description				Retorna o valor atual do system volume main (Usado apra diminuir o volume geral sem mudar as configurações do usuário, esse valor não é salvo)
function audio_get_volume_sys_main()
{
	var _audio_settings = global.__audio_control;
	return _audio_settings.sys_volume_main;	
}

///@function				audio_get_volume_sys_music
///@description				Retorna o valor atual do system volume music (Usado apra diminuir o volume da música sem mudar as configurações do usuário, esse valor não é salvo)
function audio_get_volume_sys_music()
{
	var _audio_settings = global.__audio_control;
	return _audio_settings.sys_volume_music;	
}

///@function				audio_get_volume_sys_sfx
///@description				Retorna o valor atual do system volume main (Usado apra diminuir o volume dos efeitos sem mudar as configurações do usuário, esse valor não é salvo)
function audio_get_volume_sys_sfx()
{
	var _audio_settings = global.__audio_control;
	return _audio_settings.sys_volume_sfx;	
}

#endregion

#region AUDIO SET
///@function				audio_set_volume_main
///@description				Define o valor do volume principal (main)
///@param {real} _vol		Valor a ser definido entre 0 e 1
function audio_set_volume_main(_vol)
{
	_vol = round(_vol * 10) / 10;

	var _audio_settings = global.settings_data.audio;
	_audio_settings.volume_main = _vol;
	_audio_settings.volume_main = clamp(_audio_settings.volume_main, 0, 1);
	
	__audio_group_all_update_gain();
	
	save_settings();
}

///@function				audio_set_volume_sfx
///@description				Define o valor do volume de efeitos especiais (sfx)
///@param {real} _vol		Valor a ser definido entre 0 e 1
function audio_set_volume_sfx(_vol)
{
	_vol = round(_vol * 10) / 10;
	
	var _audio_settings = global.settings_data.audio;
	_audio_settings.volume_sfx = _vol;
	_audio_settings.volume_sfx = clamp(_audio_settings.volume_sfx, 0, 1);
	
	__audio_group_sfx_update_gain();	
	
	save_settings();
}

///@function				audio_set_volume_music
///@description				Define o valor do volume de música (music)
///@param {real} _vol		Valor a ser definido entre 0 e 1
function audio_set_volume_music(_vol)
{
	_vol = round(_vol * 10) / 10;
	var _audio_settings = global.settings_data.audio;
	_audio_settings.volume_music = _vol;
	_audio_settings.volume_music = clamp(_audio_settings.volume_music, 0, 1);
	__audio_group_music_update_gain();	
	
	save_settings();
}

///@function				audio_set_volume_sys_main(_vol)
///@description				Define o valor do system volume main (Usado apra diminuir o volume main sem mudar as configurações do usuário, esse valor não é salvo)
///@param {real} _vol		Valor a ser definido entre 0 e 1
function audio_set_volume_sys_main(_vol)
{
	var _audio_settings = global.__audio_control;
	_audio_settings.sys_volume_main = _vol;
	_audio_settings.sys_volume_main = clamp(_audio_settings.sys_volume_main, 0, 1);
	
	__audio_group_all_update_gain();
}

///@function				audio_set_volume_sys_music(_vol)
///@description				Define o valor do system volume main (Usado apra diminuir o volume main sem mudar as configurações do usuário, esse valor não é salvo)
///@param {real} _vol		Valor a ser definido entre 0 e 1
function audio_set_volume_sys_music(_vol)
{
	global.__audio_control.sys_volume_music = _vol;
	global.__audio_control.sys_volume_music = clamp(global.__audio_control.sys_volume_music, 0, 1);
	
	__audio_group_music_update_gain();
}

///@function				audio_set_volume_sys_sfx(_vol)
///@description				Define o valor do system volume main (Usado apra diminuir o volume main sem mudar as configurações do usuário, esse valor não é salvo)
///@param {real} _vol		Valor a ser definido entre 0 e 1
function audio_set_volume_sys_sfx(_vol)
{
	var _audio_settings = global.__audio_control;
	_audio_settings.sys_volume_sfx = _vol;
	_audio_settings.sys_volume_sfx = clamp(_audio_settings.sys_volume_sfx, 0, 1);
	
	__audio_group_sfx_update_gain();
}
#endregion

#endregion

#region AUDIO PLAY

///@function						audio_play_bgm(_music, _fade_out, _fade_in)
///@description						Toca músicas do audiogroup ag_music, para as músicas tocando no momento da chamada da função com opção de fades
///@param {asset, array} _music		Asset da música a ser tocada, também pode ser passada uma array com múltiplos assets a serem tocados juntos
///@param {bool} _fade_out			Se a música tocando atualmente deve passar por um fade out antes de parar completamente
///@param {bool} _fade_in			Se a música a ser tocada deve passar por um efeito de fade in
function audio_play_bgm(_music, _fade_out = true, _fade_in = false)
{
	if (__audio_check_bgm_is_playing(_music)) return;
	
	if (global.__audio_control.bgm_is_playing)
	{
		global.__audio_control.bgm_fade_state = "out";
	}	
	global.__audio_control.bgm_next_music = _music;
	global.__audio_control.bgm_fade_in = _fade_in;
	global.__audio_control.bgm_fade_out = _fade_out;
	global.__audio_control.bgm_change_flag = true;
		
	if (_fade_out || _fade_in) global.__audio_control.bgm_fade = true;
}

///@function						audio_stop_bgm(_music, _fade_out, _fade_in)
///@description						Para todas as músicas sendo tocadas no BGM
///@param {bool} _fade_out			Se a música tocando atualmente deve passar por um fade out antes de parar completamente
function audio_stop_bgm(_fade_out = true)
{
	if (global.__audio_control.bgm_is_playing)
	{
		global.__audio_control.bgm_fade_state = "out";
	}
	else
	{
		return;	
	}
	global.__audio_control.bgm_fade_out = _fade_out;
	global.__audio_control.bgm_change_flag = true;
		
	if (_fade_out) global.__audio_control.bgm_fade = true;
}

///@function						audio_play_sfx(_sfx_id, _loop)
///@description						Toca um áudio de efeito especial
///@param {asset} _sfx_id			Asset de áudio a ser tocado
///@param {bool} _loop				Se o áudio deve se repetir (Ele se repetirá ate ser cancelado manualmente)
function audio_play_sfx(_sfx_id, _loop = false)
{
	var _prio = global.__audio_control.sfx_priority;	
	
	if (_loop && audio_is_playing(_sfx_id)) return;
	
	return audio_play_sound(_sfx_id, _prio, _loop)
}

///@function						audio_play_sfx_random(_sfx_array)
///@description						Toca um áudio escolhido aleatoriamente dentro de uma array
///@param {array} _sfx_array		Array de assets de áudio
function audio_play_sfx_random(_sfx_array)
{
	var _prio = global.__audio_control.sfx_priority;
	var _audio = array_pick_random(_sfx_array);
	audio_play_sfx(_audio);
}

///@function						audio_play_sfx_queue(_sfx_array)
///@description						Adiciona um áudio de efeito especial no final da fila de áudios, eles são tocados em sequência
///@param {asset} _sfx				Asset do áudio a ser adicionado
function audio_play_sfx_queue(_sfx)
{
	var _prio = global.__audio_control.sfx_priority;
	global.__audio_control.play_sfx_queue = true;
	array_push(global.__audio_control.sfx_queue, _sfx);
}
#endregion