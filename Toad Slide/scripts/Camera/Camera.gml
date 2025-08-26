ProjectSettings();

enum CAMERA_MODE {
	FOLLOW,
	FREE,
	DEMO
}

enum DYNAMIC_VIEW {
	DISABLED,
	PRESERVE_HEIGHT,
	PRESERVE_WIDTH
}

global.camera_target_size = {};
with(global.camera_target_size) {
	mode = DYNAMIC_VIEW.PRESERVE_HEIGHT;
	width = DEF_CAMERA_WIDTH;
	height = DEF_CAMERA_HEIGHT;
}