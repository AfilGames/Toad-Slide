/// @description Setup

// Inherit the parent event
event_inherited();

update_depth = function() {
	depth = -y + UNIT * 1.1;
}

update_depth();

found_portal = noone;
for (var i = 0; i < instance_number(other.object_index); i++) {
	var _element = instance_find(other.object_index, i);

	if (instance_exists(_element) && (_element.id != other.id)) {
		found_portal = _element;
	}
}

check = function(_x, _y, _spdx = 0, _spdy = 0) {
	var _cx = found_portal.x + _spdx * UNIT;
	var _cy = found_portal.y + _spdy * UNIT;
	
	var _obstacle = grid_data.check_obstacle(_cx, _cy);
	var _freespace = grid_data.check_freespace(_cx, _cy);
	var _modifier = grid_data.check_modifier(_cx, _cy);
	
	var _valid_space = instance_exists(_freespace);
	var _valid_obstacle = !(instance_exists(_obstacle) and !_obstacle.deactivated);
	var _valid_modifier = (instance_exists(_modifier) and !_modifier.deactivated and _modifier.check(found_portal.x, found_portal.y, _spdx, _spdy)) or !instance_exists(_modifier);
	
	return _valid_space and _valid_obstacle and _valid_modifier;
}

#region Grid Data
	
	grid_data.action_modify = function(_instance) {
		with(_instance.grid_data) {
			var _found_portal = noone;
			for (var i = 0; i < instance_number(other.object_index); i++) {
				var _element = instance_find(other.object_index, i);
		
				if (instance_exists(_element) && (_element.id != other.id)) {
					_found_portal = _element;
				}
			}
			
			pos_target = new Vector2(_found_portal.x + move_direction.x * UNIT, _found_portal.y + move_direction.y * UNIT);
			action_start = template_pushable_action_start;
			action_end = template_pushable_action_end;
		}
		
		_instance.grid_data_set(_instance.grid_data);
	}

#endregion

sprites = {};
with(sprites) {
	shadow = spr_portal_shadow;
	base = spr_portal_base;
	ring = spr_portal_ring;
}