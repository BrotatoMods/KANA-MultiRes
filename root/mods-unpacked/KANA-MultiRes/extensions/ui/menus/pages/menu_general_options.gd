extends "res://ui/menus/pages/menu_general_options.gd"

const KANA_MULTI_RES_LOG_NAME = "KANA-MultiRes"

onready var info_text_label = get_node('InfoText')
onready var screen_stretch_container = get_node("%LeftContainer/ScreenStretchContainer")

func _ready():
	screen_stretch_container.connect("item_selected", self , "_on_screen_stretch_setting_changed")

func _on_screen_stretch_setting_changed(index):
	ModLoaderLog.debug("stretch setting changed to -> " + str(index), KANA_MULTI_RES_LOG_NAME)
	info_text_label.show_info_text("MENU_INFO_TEXT_NEXT_WAVE")

