extends HBoxContainer

signal item_selected(index)

const KANA_MULTI_RES_LOG_NAME = "KANA-MultiRes"

func _on_ScreenStretchButton_item_selected(index):
	ModLoaderUtils.log_debug(str("Screen Stretch Button item selected -> ", index) , KANA_MULTI_RES_LOG_NAME)
	ProgressData.settings.screen_stretch = index
	emit_signal("item_selected", index)
