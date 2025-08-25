#macro DEBUG_ACHIEVEMENTS true
#macro BASE_W 640
#macro BASE_H 360
#macro SCALE 1


function unlock_achievement_test(_text_achievement){
	with(oTesteAchievement){
		text_achievement[array_length(text_achievement)] = _text_achievement
		show_achievement = true
	}
}