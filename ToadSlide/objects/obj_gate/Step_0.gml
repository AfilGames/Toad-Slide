/// @description Update

if animation_has_ended() {
	image_speed = 0;
	image_index = image_number - 1;
}

var _open_close = !starting_state;

var _weight = instance_position(x, y, [obj_player, obj_pushable]);

with(obj_button) {
	if deactivated {
		_open_close = !_open_close;
	}
}

if (!_open_close and instance_exists(_weight)) {
	_open_close = true;
}

deactivated = _open_close;

var _sprite_activated = spr_gate_horizontal_open;
var _sprite_deactivated = spr_gate_horizontal_close;

if (deactivated) {
	if (sprite_index != _sprite_activated) {
		
		sprite_index = _sprite_activated;
		image_index = 0;
		image_speed = 1;
	}
}
else {
	if (sprite_index != _sprite_deactivated) {
		
		sprite_index = _sprite_deactivated;
		image_index = 0;
		image_speed = 1;
	}
}