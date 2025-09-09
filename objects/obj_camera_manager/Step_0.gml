/// @description Update

//	Set position
if (mode == CAMERA_MODE.FOLLOW) {
	spd.x = lerp(0, target.x - x, app);
	spd.y = lerp(0, target.y - y, app);
}
else if (mode == CAMERA_MODE.FREE) {
	spd.x = lerp(spd.x, move.x, app);
	spd.y = lerp(spd.y, move.y, app);
}
else if (mode == CAMERA_MODE.DEMO) {
	move.x = 1.75;
	
	spd.x = lerp(spd.x, move.x, app);
	spd.y = lerp(spd.y, move.y, app);
}

x += spd.x;
y += spd.y;

//	Set view position
if (bounding && (mode != CAMERA_MODE.DEMO)) {
	x = clamp(x, CAMERA_WIDTH * .5, room_width - CAMERA_WIDTH * .5);
	y = clamp(y, CAMERA_HEIGHT * .5, room_height - CAMERA_HEIGHT * .5);
}

//	Scale
scale_anim = lerp(scale_anim, scale, scale_app);

//	Shake
shake_amount = lerp(shake_amount, 0, .066);
shake_progress += shake_amount * shake_frequency;

camera_set_view_size(CURRENT_CAMERA, global.camera_target_size.width * scale_anim, global.camera_target_size.height * scale_anim);

//	Shake & pos
camera_set_view_pos(
	CURRENT_CAMERA,
	x - CAMERA_WIDTH * .5 + lengthdir_x(shake_amplitude * shake_amount, shake_progress) + offset.x,
	y - CAMERA_HEIGHT * .5 + lengthdir_y(shake_amplitude * shake_amount, shake_progress) + offset.y
);