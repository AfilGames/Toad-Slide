/// @description 

lopsided_amount = 0;
offset = [
	{ y1: random_amp(lopsided_amount), y2: random_amp(lopsided_amount) },
	{ y1: random_amp(lopsided_amount), y2: random_amp(lopsided_amount) }
];
switched = false;
value = 0;

audio_play_sfx(snd_transition);