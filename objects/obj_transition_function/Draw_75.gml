var _h = value * (GUI_HEIGHT + lopsided_amount) * 2 - GUI_HEIGHT - lopsided_amount;

draw_primitive_begin(pr_trianglestrip);

draw_vertex_color(0, _h + offset[0].y1, #111111, 1);
draw_vertex_color(0, _h + offset[0].y2 + GUI_HEIGHT, #111111, 1);
draw_vertex_color(GUI_WIDTH, _h + offset[1].y1, #111111, 1);
draw_vertex_color(GUI_WIDTH, _h + offset[1].y2 + GUI_HEIGHT, #111111, 1);

draw_primitive_end();