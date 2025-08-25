/// @description Update

if global.paused exit;

//	Timers
anim_offset.x = lerp(anim_offset.x, 0, .3);
anim_offset.y = lerp(anim_offset.y, 0, .3);
anim_tilt = lerp(anim_tilt, 0, .2);
anim_height = lerp(anim_height, 0, .17);
anim_invalid = lerp(anim_invalid, 0, .2);

if (!deactivated and (sprite_index != sprite_default)) {
	sprite_index = sprite_default;
}

if ((sprite_index == sprite_filled) and animation_has_ended()) {
	image_speed = 0;
	image_index = sprite_get_number(sprite_index) - 1;
}