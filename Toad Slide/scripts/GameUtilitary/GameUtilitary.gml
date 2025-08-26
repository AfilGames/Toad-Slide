function game_check_valid_position(_x, _y) {
	return (position_meeting(_x, _y, obj_free_space) && !position_meeting(_x, _y, obj_grid_element))
}

//retorna uma string do número selecionado, se o numero foir menor que 10, adiciona um 0 na frente
function plus_zero(_number)
{
	if(abs(_number) < 10)
	{
		_number = "0" + string(_number)
	}
	
	return string(_number);
}

function draw_text_outlined(_x, _y, _string, _sep, _w, _xscale, _yscale, _angle, _c1, _c2, _c3, _c4, _alpha, _outline_color = c_black)
{
    draw_text_ext_transformed_color(_x, _y - (1 * _yscale), _string, _sep, _w, _xscale, _yscale, _angle, _outline_color, _outline_color, _outline_color, _outline_color, _alpha);
    draw_text_ext_transformed_color(_x, _y + (1* _yscale), _string, _sep, _w, _xscale, _yscale, _angle, _outline_color, _outline_color, _outline_color, _outline_color, _alpha);
    draw_text_ext_transformed_color(_x - (1 * _xscale), _y, _string, _sep, _w, _xscale, _yscale, _angle, _outline_color, _outline_color, _outline_color, _outline_color, _alpha);
    draw_text_ext_transformed_color(_x + (1 * _xscale), _y, _string, _sep, _w, _xscale, _yscale, _angle, _outline_color, _outline_color, _outline_color, _outline_color, _alpha);
    
    // Center
    draw_text_ext_transformed_color(_x, _y, _string, _sep, _w, _xscale, _yscale, _angle, _c1, _c2, _c3, _c4, _alpha);
}