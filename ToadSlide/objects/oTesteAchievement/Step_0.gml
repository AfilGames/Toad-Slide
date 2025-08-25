/// @description Atualiza variáveis

if(show_achievement){
	if(width < width_max){
		width = lerp(width, width_max, speed_draw)
	}
	
	if(height < height_max){
		height = lerp(height, height_max, speed_draw)
	}
	
	if(point_distance(width, height, width_max, height_max) <= 0.3 && show_text = false){
		width = width_max
		height = height_max
		show_text = true
		alarm[0] = timer_achievement
	}
	
}else{
	width = 0
	height = 0
	show_text = false
}