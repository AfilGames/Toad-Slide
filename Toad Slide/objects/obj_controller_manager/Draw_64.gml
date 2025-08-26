/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

if(global.disconnected_controller == true && room != room_init){
	//show_debug_message("Sem joy");
	//draw_clear_alpha(c_black, 1);
	
	
	//_0/*english*/ 
	//_1/*portuguese*/
	//_2/*spanish*/
	//_3/*deutsch*/ 
	/*chinese : "学分",*/
	//_4/*russian*/ 
	
	
	var _scale =  display_get_gui_width / 720;
	
	var _disconection_x_pos = display_get_gui_width()/2;
	var _disconection_y_pos = display_get_gui_height()/2;
 
	var _controller_conection_txt =  language_get_localized_text("Disconection_Title"); //"Controller Disconnected";
	var _controller_reconection_txt = language_get_localized_text("Disconection_Desc") //"Press Any Button \nor\nReconnect to Continue";	
	
		
	if (!global.paused && room == rm_main_menu)
	{
		with(obj_main)
		{
			event_user(0);
		}
	}
		
	if(os_type == os_xboxone || os_type == os_xboxseriesxs || os_type == os_ps4 || os_type == os_ps5 || os_type == os_switch)
	{
		var _controller_reconection_txt = language_get_localized_text("Disconection_Desc_Console")
	}


	draw_set_alpha(0.6);
	draw_rectangle_color(0,0,display_get_gui_width(),display_get_gui_height(),c_black,c_black,c_black,c_black,false);
	draw_set_alpha(1);
	draw_sprite_ext(spr_disconnect_screen, 0, _disconection_x_pos, _disconection_y_pos, _scale * .9, _scale , 0 ,c_white, 1);	

	var __halign	= draw_get_halign();
	var __font		= draw_get_font();
	var __colour	= draw_get_color();
	
	draw_set_halign(fa_center)
		draw_set_font(fnt_noto_12)
		draw_text_outlined(_disconection_x_pos, _disconection_y_pos - 35 * _scale, _controller_conection_txt, 20, 300, 0.8 * _scale, 0.8 * _scale, 0, c_white, c_white, c_white, c_white, 1, c_black);
		draw_text_outlined(_disconection_x_pos, _disconection_y_pos - 40, _controller_reconection_txt, 20, 300, 0.7 * _scale, 0.7 * _scale, 0, c_white, c_white, c_white, c_white, 1, c_black);
			
		draw_set_color(__colour)
	draw_set_font(__font);
	draw_set_halign(__halign);
}

