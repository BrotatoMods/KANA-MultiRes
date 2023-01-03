extends HBoxContainer

signal item_selected(index)

func _on_ScreenStretchButton_item_selected(index):
	ModLoader.mod_log(str("KANAMultiRes: Screen Stretch Button item selected: ", index))
	ProgressData.settings.screen_stretch = index
	emit_signal("item_selected", index)
