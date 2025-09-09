/// @description Variáveis de inicialização

show_message(room_get_name(room))

if(!DEBUG_ACHIEVEMENTS) || (os_type == os_switch){
	instance_destroy();
	exit;
}

depth = -999999

text_achievement = [];
show_achievement = false;
show_text = false

timer_achievement = game_get_speed(gamespeed_fps) * 2.5
timer_next_achievement = 10

width_max = 80 * SCALE
height_max = 32 * SCALE

height = 0
width = 0

colour_rectangle = c_white
colour_text = c_black

//CREATE
enum POSITION {
    TOP_LEFT,
    BOTTOM_LEFT,
    TOP_RIGHT,
    BOTTOM_RIGHT,
    TOP_CENTER,
    BOTTOM_CENTER
}

my_position            = POSITION.TOP_CENTER;
x_draw                = 0;
y_draw                = 0;

switch (my_position) {
    case POSITION.TOP_LEFT:
        x_draw        = 0;
        y_draw        = 0;
    break;
    
    case POSITION.BOTTOM_LEFT:
        y_draw        = (BASE_H - height_max);
    break;
    
    case POSITION.TOP_RIGHT:
        x_draw        = (BASE_W - width_max);
    break;
    
    case POSITION.BOTTOM_RIGHT:
        x_draw        = (BASE_W - width_max);
        y_draw        = (BASE_H - height_max);
    break;
    
    case POSITION.TOP_CENTER:
        x_draw        = (BASE_W - width_max) /2;
    break;
    
    case POSITION.BOTTOM_CENTER:
        x_draw        = (BASE_W - width_max) /2;
        y_draw        = (BASE_H - height_max);
    break;
}

alpha_text = 1

speed_draw = 0.09