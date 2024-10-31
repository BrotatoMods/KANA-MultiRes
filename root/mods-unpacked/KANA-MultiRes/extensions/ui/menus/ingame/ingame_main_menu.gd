extends "res://ui/menus/ingame/ingame_main_menu.gd"


const KANA_MULTI_RES_LOG_NAME_INGAME_MAIN_MENU = "KANA-MultiRes:IngameMainMenu"


func _ready() -> void:
	KANA_add_ARC()


func KANA_add_ARC():
	ModLoaderLog.debug("adding ARC to ingame main menu", KANA_MULTI_RES_LOG_NAME_INGAME_MAIN_MENU)
	# Create ARC Node
	var arc = AspectRatioContainer.new()
	arc.name = "ARC"

	# Add it to the UI node
	.add_child(arc)
	arc.mouse_filter = Control.MOUSE_FILTER_IGNORE
	arc.ratio = 1.7778
	arc.anchor_right = 1.0
	arc.anchor_bottom = 1.0

	# Move MarginContainer in ARC Node
	var margin_container = .get_node('MarginContainer')
	.remove_child(margin_container)
	arc.add_child(margin_container)
	margin_container.size_flags_horizontal = Control.SIZE_FILL
	margin_container.size_flags_vertical = Control.SIZE_FILL
	margin_container.mouse_filter = Control.MOUSE_FILTER_IGNORE

	.move_child(arc, 0)

	ModLoaderLog.debug("added ARC to ingame main menu", KANA_MULTI_RES_LOG_NAME_INGAME_MAIN_MENU)
