/// @description Setup

target = new Vector2(x, y);
spd = new Vector2(0);
move = new Vector2(0);

offset = new Vector2(0);

mode = CAMERA_MODE.FOLLOW;

bounding = true;

scale_df = 1;
scale = 1;
scale_anim = 1;

scale_app = .033;
app = .17;

// Screen shake
shake_amount = 0;
shake_amplitude = 10;
shake_frequency = 1;
shake_progress = 0;

//	Methods
set = function(_x = x, _y = y) {
	if (is_struct(_x)) {
		x = floor(_x.x);
		y = floor(_x.y);
	}
	else {
		x = floor(_x);
		y = floor(_y);
	}
	target.x = _x;
	target.y = _y;
	return id;
}
follow = function(_x = self.x, _y = self.y) {
	if (is_struct(_x)) {
		target.x = floor(_x.x);
		target.y = floor(_x.y);
	}
	else {
		target.x = floor(_x);
		target.y = floor(_y);
	}
	return id;
}
shake = function(_amplitude, _frequency = 100, _amount = 1) {
	shake_amplitude = _amplitude;
	shake_amount = _amount;
	shake_frequency = _frequency;
}