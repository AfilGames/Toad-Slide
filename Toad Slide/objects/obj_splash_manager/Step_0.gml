if(currentAlphaTimer >=0){
	//var _current_value = isIncreasing ? currentAlphaTimer + 1 : currentAlphaTimer - 1;
	var _current_value = currentAlphaTimer + 1;
	currentAlphaTimer = clamp(_current_value, 0, maxAlphaTimer);
}

if(isIncreasing && currentAlphaTimer >= maxAlphaTimer){
	isIncreasing = false;
}
//O jogo só avança depois do global.load_finished
if(!isIncreasing && global.load_finished)
{
	room_goto(global.first_scene);
}