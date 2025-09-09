/// @description Setup

// Inherit the parent event
event_inherited();

var _sprites = [spr_teleporter_in_01, spr_teleporter_out_01];
var _number = instance_number(object_index) mod 2;

sprite_index = _sprites[_number];