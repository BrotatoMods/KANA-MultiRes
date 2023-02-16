class_name ScreenStretchButton
extends OptionButton

onready var screen_stretch_button = $"%ScreenStretchButton"


func _ready()->void :
	for screen_option in ProgressData.screen_stretch:
		add_item(screen_option)

	screen_stretch_button.select(ProgressData.settings.screen_stretch)


func _on_ScreenStretchButton_item_selected(index):
	ProgressData.settings.screen_stretch = index
