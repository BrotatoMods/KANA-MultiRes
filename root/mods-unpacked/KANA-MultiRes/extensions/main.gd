extends "res://main.gd"


const KANA_MULTI_RES_LOG_NAME = "KANA-MultiRes"


func KANA_change_background():
	ModLoaderLog.debug("Change Background", KANA_MULTI_RES_LOG_NAME)
	# modify texture rect
	_background.rect_rotation = 0
	_background.size_flags_horizontal = 3
	_background.size_flags_vertical = 3
	_background.anchor_right = 1.0
	_background.anchor_bottom = 1.0
	_background.margin_top = 0
	_background.margin_right = 0
	_background.margin_bottom = 0
	_background.margin_left = 0
	_background.expand = true

	# Load gradient material
	var gradient_material = load("res://mods-unpacked/KANA-MultiRes/extensions/gradient_material.tres")
	_background.material = gradient_material
	_background.material.set_shader_param("second_color", ItemService.get_background_gradient_color())
	ModLoaderLog.debug("Changed Background", KANA_MULTI_RES_LOG_NAME)


func KANA_add_ARC():
	ModLoaderLog.debug("adding ARC", KANA_MULTI_RES_LOG_NAME)
	# Create ARC Node
	var arc = AspectRatioContainer.new()
	arc.name = "ARC"

	# Add it to the UI node
	var ui = .get_node("UI")
	ui.add_child(arc)
	arc.mouse_filter = Control.MOUSE_FILTER_IGNORE
	arc.ratio = 1.7778
	arc.anchor_right = 1.0
	arc.anchor_bottom = 1.0

	# Move HUD in ARC Node
	var hud = ui.get_node('HUD')
	hud.rect_position = Vector2.ZERO
	ui.remove_child(hud)
	arc.add_child(hud)
	hud.size_flags_horizontal = Control.SIZE_FILL
	hud.size_flags_vertical = Control.SIZE_FILL
	hud.mouse_filter = Control.MOUSE_FILTER_IGNORE

	# Update all HUD Paths
	_hud = $UI / ARC / HUD
	_ui_bonus_gold = $UI / ARC / HUD / LifeContainerP1 / UIBonusGold
	_ui_bonus_gold_pos = $UI / ARC / HUD / LifeContainerP1 / UIBonusGold / Position2D
	_current_wave_label = $UI / ARC / HUD / WaveContainer / CurrentWaveLabel
	_wave_timer_label = $UI / ARC / HUD / WaveContainer / WaveTimerLabel
	_ui_wave_container = $UI / ARC / HUD / WaveContainer

	ModLoaderLog.debug("added ARC", KANA_MULTI_RES_LOG_NAME)


func _ready():
	KANA_change_background()
	KANA_add_ARC()
	Utils.set_stretch_mode()
