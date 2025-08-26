/// @description Desenhando o achievement

if(show_achievement){
	//desenha o achievement
	draw_rectangle_color(x_draw,y_draw,x_draw + width, y_draw + height, colour_rectangle, colour_rectangle, colour_rectangle, colour_rectangle, false)
}

if(show_text){
	//desenha o texto
	var _halign = draw_get_halign()
	var _valign = draw_get_valign()
	var _font = draw_get_font()
	draw_set_halign(fa_center)
	draw_set_valign(fa_middle)
	draw_set_font(FontTesteAchievementAfil)
	draw_text_transformed_color(x_draw + width/2,y_draw + height/2, text_achievement[0], SCALE, SCALE, 0, colour_text, colour_text, colour_text, colour_text, alpha_text)
	draw_set_halign(_halign)
	draw_set_valign(_valign)
	draw_set_font(_font)
}