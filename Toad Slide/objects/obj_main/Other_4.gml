/// @description 

if ((room != rm_splash_screen) and (room != rm_main_menu) and (room != rm_init)) {
	if (global.level_index <= 10) {
		audio_stop_sound(snd_ambient_summer);
		audio_stop_sound(snd_ambient_autumn);
		audio_play_sfx(snd_ambient_spring, true);
		
		audio_play_bgm(snd_mus_spring);
	}
	else if (global.level_index <= 20) {
		audio_stop_sound(snd_ambient_spring);
		audio_stop_sound(snd_ambient_autumn);
		audio_play_sfx(snd_ambient_summer, true);
		
		audio_play_bgm(snd_mus_summer);
	}
	else if (global.level_index <= 30) {
		audio_stop_sound(snd_ambient_summer);
		audio_stop_sound(snd_ambient_spring);
		audio_play_sfx(snd_ambient_autumn, true);
		
		audio_play_bgm(snd_mus_autumn);
	}
}
else {
	audio_stop_sound(snd_ambient_summer);
	audio_stop_sound(snd_ambient_spring);
	audio_stop_sound(snd_ambient_autumn);
	
	if (room == rm_main_menu) {
		audio_play_bgm(snd_mus_menu);
	}
}