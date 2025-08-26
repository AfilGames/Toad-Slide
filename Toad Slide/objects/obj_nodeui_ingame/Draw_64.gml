/// @description 

black_bg_alpha = lerp(black_bg_alpha, global.paused, .3);

draw_set_alpha(black_bg_alpha * .45);
draw_rectangle_color(0, 0, GUI_WIDTH, GUI_HEIGHT, 0, 0, 0, 0, false);
draw_set_alpha(1);

// Inherit the parent event
event_inherited();