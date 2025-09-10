/// @description Animations

var _pushable = instance_position(x, y, obj_pushable);
var _player = position_meeting(x, y, obj_player)

if (objective_type == "container") {
	if (instance_exists(_pushable) and !_pushable.is_moving() and !_pushable.deactivated and !_player) {
		if (sprite_index != spr_objective_stone) {
		
			sprite_index = spr_objective_stone;
			image_index = 0;
			depth = -y - 2;
		}
	}
	else {
		if (sprite_index != spr_objective) {
		
			sprite_index = spr_objective;
			image_index = 0;
			depth = -y + UNIT * 1.5;
		}
	}
}