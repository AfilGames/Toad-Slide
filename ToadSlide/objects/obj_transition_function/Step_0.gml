/// @description 
var _excess = 0.1;

if (value < .5) {
	value = lerp(value, .6, spd);
}
else if (value < (1 + _excess)) {
	if !switched action();
	value = lerp(value, (1 + _excess), spd);
	switched = true;
}

if (value >= 1) {
	input_unlock_all(true);
	instance_destroy();
}