extends "res://ui/menus/pages/menu_general_options.gd"

onready var info_text_label = get_node('InfoText')
onready var screen_stretch_container = get_node("Options/Column1/VideoContainer/VBoxContainer/ScreenStretchContainer")

func _ready():
	pass
	screen_stretch_container.connect("item_selected", self , "_on_screen_stretch_setting_changed")
	
func _on_screen_stretch_setting_changed(index):
	ModLoader.mod_log( str("KANAMultiRes: stretch setting changed to -> ", index))
	info_text_label.show_info_text("MENU_INFO_TEXT_NEXT_WAVE")
	
