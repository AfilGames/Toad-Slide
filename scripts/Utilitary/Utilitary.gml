//	Useful abstractions to speed up development

#region Math
		
	//	Vector 2
	//	Stores two values, a y position and a x position
	function Vector2(_x = 0, _y = _x) constructor {
		x = _x;
		y = _y;
						
		static get_magnitude = function(){
			var _mag = 0;
			//if (x > 0 && y > 0){
				_mag =  sqrt((x * x) + (y * y))	
			//}
			return _mag;
		}
			
		static normalize = function(){
			if ((x != 0) || (y != 0)){
			
				var _factor = 1/sqrt((x * x) + (y * y));
				x = _factor * x;
				y = _factor * y;
			}
				
			return self;
		}

		static get_speed = function() {
			return point_distance(0, 0, x, y);
		}
			
		static get_direction = function(_x_origin = 0, _y_origin = 0) {
			return point_direction(_x_origin, _y_origin, x, y);
		}
			
		static is_null = function() {
			return ((x == noone) && (y == noone)) || ((x == undefined) && (y == undefined));
		}
			
		static is_zero = function() {
			return (x == 0 && y == 0)
		}

		static lengthdir = function(_length, _dir) {
			x = lengthdir_x(_length, _dir);
			y = lengthdir_y(_length, _dir);
		
			return self;
		}
			
		static set_value = function(_x, _y) {
			x = _x;
			y = _y;	
			return self;
		}
			
		static lerpto = function(_vec2, _amount) {
			if is_vector2(_vec2) {
				x = lerp(x, _vec2.x, _amount);
				y = lerp(y, _vec2.y, _amount);
			}
			return self;
		}
			
		static compare = function(_vec2){
			return (round(x) == round(_vec2.x) && round(y) == round(_vec2.y));	
		}
		
		static multiply = function(_val) {
			if is_struct(_val) return new Vector2(_val.x * x, _val.y * y);	
			else return new Vector2(_val * x, _val * y);
		}
		
		static add = function(_val){
			if is_struct(_val) return new Vector2(_val.x + x, _val.y + y);	
			else return new Vector2(_val + x, _val + y);	
		}
		
		static difference = function(_val){
			if is_struct(_val) return new Vector2(_val.x - x, _val.y - y);	
			else return new Vector2(_val - x, _val - y);	
		}
		
		toString = function() {
			return $"({x},{y})"
		}
	}
		
	function Vector3(_x = 0, _y = 0, _z = 0) constructor
	{
		x = _x;
		y = _y;
		z = _z;
	}
		
	//	Rectangle
	//	Stores the width and height of a rectangle
	function Rectangle(_w = 0, _h = _w) constructor {
		w = _w;
		h = _h;
			
		static is_null = function() {
			return ((w == noone) && (h == noone)) || ((w == undefined) && (h == undefined));
		}
	}
		
	//	Is Vector 2
	//	Verifies if given value is a vector 2
	function is_vector2(val) {
		return is_instanceof(val, Vector2);
	}
		
	//	Chance (with percentage)
	//	Retuns true with a chance of '_percent'
	function chance(percent) { return (percent >= random(1)) };
		
	//	Random Amp
	//	Returns random number within the range of -amplitude and amplitude
	function random_amp(amp) { return random_range(-amp, amp) };
		
	//	Integer Random Amp
	//	Returns random integer number within the range of -amplitude and amplitude
	function irandom_amp(amp) { return irandom_range(-amp, amp) };
		
	//	Random Amp
	//	Returns random number within the range of (-amplitude / 2) and (amplitude / 2)
	function random_amp_normalized(amp) { return random_range(-amp * .5, amp * .5) };
		
	//	Integer Random Amp
	//	Returns random integer number within the range of (-amplitude / 2) and (amplitude / 2)
	function irandom_amp_normalized(amp) { return irandom_range(-amp div 2, amp div 2) };
		
	//	Choose element in array
	//	Returns a random element inside of an array
	function choose_in_array(array) { return array[irandom(array_length(array) - 1)] };
	
	//	Wrap (rapido)
	//	Algoritmo mais simples e leve que envolve o valor dentro do intervalo (precisão baixa).
	function qwrap(value, _min, _max) {
		if (value > _max) return _min;
		else if (value < _min) return _max;
		else return value;
	}
		
	//	Wrap
	//	Envolve o valor dentro do intervalo (abordagem iterativa) (desnecessário pesado).
	//	Tipo um clamp de trás pra frente
	function wrap(value, _min, _max) {
		if (value mod 1 == 0){
			while (value > _max || value < _min){
			    if (value > _max) value += _min - _max - 1;
			    else if (value < _min) value += _max - _min + 1;
			}
			return(value);
		} else {
			var vOld = value + 1;
			while (value != vOld){
			    vOld = value;
			    if (value < _min) value = _max - (_min - value);
			    else if (value > _max) value = _min + (value - _max);
			}
			return(value);
		}
	}
		
	///@function		approach(_current, _target, _amount)
	///@param {real}	_current
	///@param {real}	_target
	///@param {real}	_amount
	function approach(_current, _target, _amount) {
		/*
			* Example use:
			* x = approach(x, target_x, 2);
			*/
		var c = _current;
		var t = _target;
		var a = _amount;
		if (c < t)
		{
			c = min(c+a, t); 
		}
		else
		{
			c = max(c-a, t);
		}
		return c;
	}
		
	function dec_to_hex(dec, len = 1) 
	{
		var hex = "";
 
		if (dec < 0) {
		    len = max(len, ceil(logn(16, 2 * abs(dec))));
		}
 
		var dig = "0123456789ABCDEF";
		while (len-- || dec) {
		    hex = string_char_at(dig, (dec & $F) + 1) + hex;
		    dec = dec >> 4;
		}
 
		return hex;
	}
		
	//	Point in Line
	//	Returns if a given point is inside of the 1d range
	function point_in_line(_x, x1, x2) { return (_x >= x1) && (_x <= x2) };

	// Lerp a value in a spring like movement
	function spring_lerp(_value, _spring_value, _target, _spring_percent, _percent){			
		_spring_value = lerp(_spring_value, (_target - _value) * _spring_percent, _percent);
		return _spring_value;
	}
				
	// Sinusoidal wave
	function sine_wave(_time, _frequency, _amplitude, _midpoint) 
	{
		return sin(_frequency * _time) * _amplitude + _midpoint;
	}
		
	function sine_between(_time, _frequency, _minimum, _maximum) 
	{
		var _midpoint = mean(_minimum, _maximum);
		var _amplitude = _maximum - _midpoint;
		return sine_wave(_time, _frequency, _amplitude, _midpoint);
	}
		
	function sine_wave_directional(_amplitude, _frequency, _time, _direction) {

		// Apply the sine wave with influence from the direction
		var _wave_x = _amplitude * _direction.x * sin(_frequency * _time);
		var _wave_y = _amplitude * _direction.y * sin(_frequency * _time);
    
		return new Vector2(_wave_x, _wave_y)
	}
		
	// Time
	function delta_time_seconds()
	{
		return 1 / 60;
	}
			
	/// @function					bezier_get_points(x1, y1, x2, y2, x3, y3)
	/// @param _point1 {Struct}		The Vector2 coordinate of the first control point.
	/// @param _point1 {Struct}		The Vector2 coordinate of the second control point.
	/// @param _point2 {Struct}		The Vector2 coordinate of the third control point.
	function bezier_get_points(_point1, _point2, _point3, _step = 0.05) 
	{
		var _points = [_point1];    
		for (var _i = 0; _i <= 1; _i += _step) {
			
		    // Intermediate coordinates
		    var _x1 = lerp(_point1.x, _point2.x, _i);
		    var _y1 = lerp(_point1.y, _point2.y, _i);
		    var _x2 = lerp(_point2.x, _point3.x, _i);
		    var _y2 = lerp(_point2.y, _point3.y, _i);
        
		    // Further intermediate coordinates
		    var _further_x = lerp(_x1, _x2, _i);
		    var _further_y = lerp(_y1, _y2, _i);

		    array_push(_points, new Vector2(_further_x, _further_y));
		}
		array_push(_points, _point3);
		return _points;
	}
		
#endregion
	
#region Sprite
			
	//	Animation Has Ended
	//	Checks if current animated sprite has reached it`s last frame
	function animation_has_ended() { return image_index >= image_number - 1 }
		
	//	Get animated image_index from sprite
	//	Returns animated image_index number
	function sprite_get_animated_image_index(sprite, offset = 0) { return ((current_time - offset) / 1000 * sprite_get_speed(sprite)) };
		
#endregion
	
#region Room
		
	function layer_bg_get_id(_layer_name) { return layer_background_get_id(layer_get_id(_layer_name)) };
		
#endregion
	
#region Text
		
	function zero_padding(number, fill_count_int, fill_count_dec) {
		return string_replace_all(string_format(number, fill_count_int, fill_count_dec), " ", "0");
	}
		
#endregion
	
#region Array
	
	function array_sort_by_depth(_array)
	{
		var _amnt = array_length(_array);
		for (var _i = 0; _i < _amnt; _i++) 
		{
		    for (var _j = 0; _j < _amnt - _i - 1; _j++) 
			{
		        var _num1 = _array[_j].depth, 
					_num2 = _array[_j+1].depth;
				
		        if (floor(_num1) < floor(_num2)) 
				{
		            var _temp = _array[_j];
		            _array[_j] = _array[_j+1];
		            _array[_j+1] = _temp;
		        }
		    }
		}	
		return _array;
	}
	
	function array_pick_random(_array)
	{
		return _array[irandom(array_length(_array) - 1)];	
	}
	
	function array_find_value(_arr,_value)
	{
		if (!is_array(_arr)) return false;
		for (var _i = 0; _i < array_length(_arr); _i++) {
			if(_arr[_i] == _value){
				return true;
			}
		}
		return false;
	}
	
	function parse_list_to_array(_list)
	{
		var _arr = [];
		
		for (var i = 0; i < ds_list_size(_list); i++) {
			array_push(_arr, _list[| i]);
		}
	
		return _arr;
	}
	
	function array_push_unique(_array, _value)
	{
		if (!array_contains(_array, _value)){
			array_push(_array, _value);	
		}
		return _array;
	}
	
#endregion
	
#region Structs
	///@description Write missing variables from one struct to the other
	///@arg read_struct
	///@arg write_struct
	function struct_copy_missing_variables(struct_to_read, struct_to_write) 
	{
        
		var struct_variables = struct_get_names(struct_to_read);
		var struct_variables_n = array_length(struct_variables);
		for(var i = 0; i < struct_variables_n; i++)
		{
		    var struct_variable = struct_variables[i];
		    var struct_to_read_value = struct_to_read[$ struct_variable];
            
		    if (struct_to_write[$ struct_variable] == undefined)
		    {
		        struct_to_write[$ struct_variable] = struct_to_read[$ struct_variable];
		    }
		    else if (is_struct(struct_to_read_value))
		    {
		        var struct_to_write_value = struct_to_write[$ struct_variable];
		        struct_copy_missing_variables(struct_to_read_value, struct_to_write_value);
		    }
		}
	}

	function struct_update_missing_variables(source_struct, destination_struct) 
	{
		// Get a list of variable names from the source struct
		var _source_variables = struct_get_names(source_struct);
		var _source_variables_count = array_length(_source_variables);
    
		// Get a list of variable names from the destination struct
		var _destination_variables = struct_get_names(destination_struct);
		var _destination_variables_count = array_length(_destination_variables);
    
		// Iterate over all variables in the source struct
		for (var _i = 0; _i < _source_variables_count; _i++) {
		    var _variable_name = _source_variables[_i];
		    var _source_value = source_struct[$ _variable_name];
        
		    // If the variable does not exist in the destination struct
		    if (destination_struct[$ _variable_name] == undefined) {
		        // Copy the variable from the source struct to the destination struct
		        destination_struct[$ _variable_name] = _source_value;
		    } 
		    // If the variable in the source struct is also a struct
		    else if (is_struct(_source_value)) {
		        var _destination_value = destination_struct[$ _variable_name];
		        // Recursively call the function to copy nested variables
		        struct_copy_missing_variables(_source_value, _destination_value);
		    }
		}
    
		// Iterate over all variables in the destination struct
		for (var _j = 0; _j < _destination_variables_count; _j++) {
		    var _destination_variable_name = _destination_variables[_j];
        
		    // If the variable does not exist in the source struct
		    if (source_struct[$ _destination_variable_name] == undefined) {
		        // Remove the variable from the destination struct
		        variable_struct_remove(destination_struct, _destination_variable_name);
		    }
		}
	
		return destination_struct;
	}
	
	function variable_struct_get_all_names(_struct) 
	{
	
		var _result = variable_struct_get_names(_struct);
	
		for (var i = 0; i < array_length(_result); i++) {
			if is_struct(_struct[$ _result[i]]) {
				var _name = _result[i];
				_result[i] = variable_struct_get_all_names(_struct[$ _result[i]]);
				array_insert(_result[i], 0, $"${_name}");
			}
		}
	
		return _result;
	}
	
	function has_variable(_name, _element) 
	{
		var _val = false;
		if is_struct(_element) {
			_val = variable_struct_exists(_element, _name);
		}
		else if instance_exists(_element) {
			_val = variable_instance_exists(_element, _name);
		}
		return _val;
	}
	
	function struct_add_variable_once(_struct, _variable_name, _value = 0) 
	{
		if !has_variable(_variable_name, _struct) {
			_struct[$ _variable_name] = _value;
		}
	}
	
#endregion
	
#region Constants

	//	Window Macros
	#macro CURRENT_VIEWPORT 0
	#macro VIEW_WIDTH view_get_wport(CURRENT_VIEWPORT)
	#macro VIEW_HEIGHT view_get_hport(CURRENT_VIEWPORT)
	#macro CURRENT_CAMERA view_camera[CURRENT_VIEWPORT]
	#macro CAMERA_WIDTH camera_get_view_width(CURRENT_CAMERA)
	#macro CAMERA_HEIGHT camera_get_view_height(CURRENT_CAMERA)
	#macro DEF_CAMERA_WIDTH global.project_settings.resolution.x
	#macro DEF_CAMERA_HEIGHT global.project_settings.resolution.y
	#macro CAMERA_X camera_get_view_x(CURRENT_CAMERA)
	#macro CAMERA_Y camera_get_view_y(CURRENT_CAMERA)
	#macro WINDOW_WIDTH window_get_width()
	#macro WINDOW_HEIGHT window_get_height()
	#macro APPSURF_WIDTH surface_get_width(application_surface)
	#macro APPSURF_HEIGHT surface_get_height(application_surface)
	#macro DISPLAY_WIDTH display_get_width()
	#macro DISPLAY_HEIGHT display_get_height()
	#macro GUI_WIDTH display_get_gui_width()
	#macro GUI_HEIGHT display_get_gui_height()
	#macro FULLSCREEN window_get_fullscreen()
	
	#region PLATFORM
	
		#macro ON_BROWSER (os_browser != browser_not_a_browser)
		#macro ON_ANDROID (os_type == os_android)
		#macro ON_GX (os_type == os_operagx)
		#macro ON_DESKTOP ((os_type == os_windows) && !ON_BROWSER)
		#macro ON_WINDOWS (os_type == os_windows)
		
	#endregion

#endregion

#region Visuals
	//	Progress Bar
	//	Dado as dimensões, cor e progresso, a função desenha uma barra de progresso
	function progress_bar(_x, _y, width, height, outline_width, outline_color, bg_color, bg_alpha, progress_color, progress) {
		draw_line_width_color(_x - outline_width * .5, _y, _x + width + outline_width * .5, _y, outline_width, outline_color, outline_color);
		draw_line_width_color(_x - outline_width * .5, _y + height, _x + width + outline_width * .5, _y + height, outline_width, outline_color, outline_color);
		draw_line_width_color(_x, _y - outline_width * .5, _x, _y + height + outline_width * .5, outline_width, outline_color, outline_color);
		draw_line_width_color(_x + width, _y - outline_width * .5, _x + width, _y + height + outline_width * .5, outline_width, outline_color, outline_color);
	
		draw_set_alpha(bg_alpha);
		draw_rectangle_color(_x + outline_width * .5, _y + outline_width * .5, _x + width - outline_width * .5, _y + height - outline_width * .5, bg_color, bg_color, bg_color, bg_color, false);
		draw_set_alpha(1);
	
		if (progress > 0) {
			draw_rectangle_color(_x + outline_width, _y + outline_width, _x + floor(progress * (width - outline_width * .5)) + 1, _y + height - outline_width * .5, progress_color, progress_color, progress_color, progress_color, false);
			//if !audio_is_playing(snd_bar) and (progress > .05) and (progress < .975) audio_play_sound(snd_bar, 0, 0, global.main_volume * global.effects_volume * .25, , 1 + progress * 1);
		}
	}

	//	Color Cycle
	//	Dado os parametros a função retorna uma cor que altera a matriz de acordo com a frequência, criando um efeito "arco iris", é veloz pois usa bitwise
	function color_cycle(frequency, phase, saturation, value) 
	{
		return make_color_hsv((current_time * (frequency * 0.0255) + phase) & 255, saturation, value) 
	}

	//	Hollow Circle
	//	Desenha um circulo com um buraco no meio
	function hollow_circle(_x, _y, r1, r2, sn, istart = 0){
	    var i = istart;
	    draw_primitive_begin(pr_trianglestrip);
	    repeat (sn + 1){
	        var d, dx, dy;
	        d = i / sn * 360;
	        dx = lengthdir_x(1, d);
	        dy = lengthdir_y(1, d);
	        draw_vertex(_x + dx * r1, _y + dy * r1);
	        draw_vertex(_x + dx * r2, _y + dy * r2);
	        i += 1;
	    }
	    draw_primitive_end();
	}
	
	function progress_pie(_x ,_y ,_value, _max, _colour, _radius, _radius2, _transparency){
		if (_value > 0) { // no point even running if there is nothing to display (also stops /0
		    var i, len, tx1, ty1, val;
    
		    var numberofsections = 60 // there is no draw_get_circle_precision() else I would use that here
		    var sizeofsection = 360/numberofsections
    
		    val = (_value/_max) * numberofsections 
    
		    if (val > 1) { // HTML5 version doesnt like triangle with only 2 sides 
    
		        draw_set_colour(_colour);
		        draw_set_alpha(_transparency);
        
		        draw_primitive_begin(pr_trianglefan);
		        draw_vertex(_x, _y);
        
		        for(i=0; i<=val; i++) {
		            len = (i*sizeofsection)+90; // the 90 here is the starting angle
		            tx1 = lengthdir_x(_radius2, len);
		            ty1 = lengthdir_y(_radius2, len);
		            draw_vertex(_x+tx1, _y+ty1);				
		        }
		        draw_primitive_end();
				draw_circle(_x, _y, _radius, false);
		
		    }
		    draw_set_alpha(1);
		}
	}

	function progress_hollow_circle(_x, _y, _value, _max, r1, r2, sn, istart = 15){
	    var i = istart;
	    draw_primitive_begin(pr_trianglestrip);
		var _rpt = (_value/_max) * sn;
	    repeat (_rpt){
	        var d, dx, dy;
	        d = i / sn * 360;
	        dx = lengthdir_x(1, d);
	        dy = lengthdir_y(1, d);
	        draw_vertex(_x + dx * r1, _y + dy * r1);
	        draw_vertex(_x + dx * r2, _y + dy * r2);
	        i += 1;
	    }
	    draw_primitive_end();
	}

	/// @function					bezier_draw_curve(x1, y1, x2, y2, x3, y3)
	/// @param _point1 {Struct}		The Vector2 coordinate of the first control point.
	/// @param _point1 {Struct}		The Vector2 coordinate of the second control point.
	/// @param _point2 {Struct}		The Vector2 coordinate of the third control point.
	function bezier_draw_curve(_point1, _point2, _point3, _step = 0.25) 
	{
		draw_primitive_begin(pr_linestrip);
		
		draw_vertex(_point1.x, _point1.y);
		for (var _i = 0; _i <= 1; _i += _step) {
			
			// Intermediate coordinates
			var _x1 = lerp(_point1.x, _point2.x, _i);
			var _y1 = lerp(_point1.y, _point2.y, _i);
			var _x2 = lerp(_point2.x, _point3.x, _i);
			var _y2 = lerp(_point2.y, _point3.y, _i);
        
			// Further intermediate coordinates
			var _further_x = lerp(_x1, _x2, _i);
			var _further_y = lerp(_y1, _y2, _i);

			draw_vertex(_further_x, _further_y);
		}
		draw_vertex(_point3.x, _point3.y);
		draw_primitive_end();
	}

	function draw_sprite_ext_inside(_sprite, _subimage, _x, _y, _xscale, _yscale, _rot, _col, _alpha, _width, _height){ 
		var _ox, _oy
		_ox = sprite_get_xoffset(_sprite);
		_oy = sprite_get_yoffset(_sprite);

		draw_sprite_part_ext(_sprite, 0, _ox - _width / 2, _oy - _height / 2, _width, _height, _x - _width / 2, _y - _height / 2, _xscale, _yscale, _col, _alpha);
	}
	
#endregion

#region Misc

	function is_ascii(_str) {
	return (ord(_str) >= 0 && ord(_str) <= 127);
}
	
#endregion