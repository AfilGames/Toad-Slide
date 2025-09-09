/// @description Inserir descrição aqui
// Você pode escrever seu código neste editor

// Inherit the parent event
event_inherited();

draw_set_font(fnt_noto_10);
draw_set_halign(fa_left);
draw_set_valign(fa_bottom);

draw_text(2, GUI_HEIGHT, global.project_settings.game_version);

draw_set_font(-1);
draw_set_halign(-1);
draw_set_valign(-1);