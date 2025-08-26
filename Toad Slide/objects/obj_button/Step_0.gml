/// @description Update

if global.paused exit;

//	Timers
anim_offset.x = lerp(anim_offset.x, 0, .3);
anim_offset.y = lerp(anim_offset.y, 0, .3);
anim_tilt = lerp(anim_tilt, 0, .2);
anim_height = lerp(anim_height, 0, .17);
anim_invalid = lerp(anim_invalid, 0, .2);

var _weight = instance_position(x, y, [obj_pushable, obj_player]);
var _condition = instance_exists(_weight)

deactivated = _condition;

image_index = deactivated;