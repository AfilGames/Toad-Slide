/// @description Setup

// Inherit the parent event
event_inherited();

continuous_movement = false;
can_move = true;

dir = new Vector2();

grid_data_reset = function() {
	grid_data = new ElementData(id);
	if audio_is_playing(slide_sound) audio_stop_sound(slide_sound);
}
grid_data_reset();

move_continuous = function() {
	with(grid_data) {
		pos_target = new Vector2(owner.x + move_direction.x * UNIT, owner.y + move_direction.y * UNIT);
		action_start = template_pushable_action_start;
		action_end = template_pushable_action_end;
	}
	grid_data_restart();
}
	
action = function(_instance) {
	if deactivated exit;
	
	//rewind_save();
	_instance.grid_data.action_modify(id);
}

collide = function(_instance) {
	if kinectic {
		grid_data.move_direction.x = _instance.grid_data.move_direction.x;
		grid_data.move_direction.y = _instance.grid_data.move_direction.y;
		
		move_continuous();
	}
}

anim_linear_target = new Vector2();

update_depth = function() {
	depth = -(y + anim_linear_offset.y);
}

animate_continuous = function(_x, _y) {
	anim_linear_offset.x = _x;
	anim_linear_offset.y = _y;
}

var _down =	[spr_pushable_vfx_down_01, spr_pushable_vfx_down_02, spr_pushable_vfx_down_03	];
var _up =	[spr_pushable_vfx_up_01, spr_pushable_vfx_up_02, spr_pushable_vfx_up_03			];
var _side =	[spr_pushable_vfx_side_01, spr_pushable_vfx_side_02, spr_pushable_vfx_side_03	];

vfx = {};
with(vfx) {
	var _biome = level_get_biome();
	down = _down[_biome];
	up = _up[_biome];
	side = _side[_biome];
}

draw_element = function() {
	draw_sprite_ext(
		sprite_index,
		image_index,
		x + X_OFFSET + anim_offset.x + anim_linear_offset.x,
		y + Y_OFFSET + anim_offset.y + anim_linear_offset.y + anim_height,
		image_xscale * (anim_xscale * anim_master_scale),
		image_yscale * (anim_yscale * anim_master_scale),
		image_angle + anim_tilt + anim_invalid * lengthdir_x(30, current_time * 2),
		image_blend,
		image_alpha
	);
	
	var _dx = grid_data.move_direction.x;
	var _dy = grid_data.move_direction.y;
	
	var _vfx = vfx.side;
	
	if (_dx != 0) {
		_vfx = vfx.side;
	}
	else {
		if (_dy > 0) {
			_vfx = vfx.down;
		}
		if (_dy < 0) {
			_vfx = vfx.up;
		}
	}
	
	draw_sprite_ext(
		_vfx,
		sprite_get_animated_image_index(_vfx),
		x + X_OFFSET + anim_offset.x + anim_linear_offset.x,
		y + Y_OFFSET + anim_offset.y + anim_linear_offset.y + anim_height,
		image_xscale * (!((_dx == 0) and (_dy != 0)) ? -_dx : 1),
		image_yscale,
		image_angle + anim_tilt + anim_invalid * lengthdir_x(30, current_time * 2),
		image_blend,
		image_alpha
	);
}