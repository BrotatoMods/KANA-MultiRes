extends "res://main.gd"

const KANA_MULTI_RES_LOG_NAME = "KANA-MultiRes"

func KANA_change_background():
	ModLoaderUtils.log_debug("Change Background", KANA_MULTI_RES_LOG_NAME)
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
	_background.material.set_shader_param("second_color", RunData.get_background_gradient_color())
	ModLoaderUtils.log_debug("Changed Background", KANA_MULTI_RES_LOG_NAME)

func KANA_add_ARC():
	ModLoaderUtils.log_debug("adding ARC", KANA_MULTI_RES_LOG_NAME)
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
	_life_label = $UI / ARC / HUD / LifeContainer / UILifeBar / MarginContainer / LifeLabel
	_level_label = $UI / ARC / HUD / LifeContainer / UIXPBar / MarginContainer / LevelLabel
	_hud = $UI / ARC / HUD
	_life_bar = $UI / ARC / HUD / LifeContainer / UILifeBar
	_xp_bar = $UI / ARC / HUD / LifeContainer / UIXPBar
	_ui_gold = $UI / ARC / HUD / LifeContainer / UIGold
	_ui_bonus_gold = $UI / ARC / HUD / LifeContainer / UIBonusGold
	_ui_bonus_gold_pos = $UI / ARC / HUD / LifeContainer / UIBonusGold / Position2D
	_current_wave_label = $UI / ARC / HUD / WaveContainer / CurrentWaveLabel
	_wave_timer_label = $UI / ARC / HUD / WaveContainer / WaveTimerLabel
	_ui_wave_container = $UI / ARC / HUD / WaveContainer
	_ui_upgrades_to_process = $UI / ARC / HUD / ThingsToProcessContainer / Upgrades
	_ui_consumables_to_process = $UI / ARC / HUD / ThingsToProcessContainer / Consumables

	ModLoaderUtils.log_debug("added ARC", KANA_MULTI_RES_LOG_NAME)

func _ready():
	KANA_change_background()
	KANA_add_ARC()

func init_camera():
	Utils.set_strecht_mode()
	KANA_init_camera()

func KANA_init_camera():
	ModLoaderUtils.log_debug(str("init_camera - Utils.width/height -> ", Utils.width, " x ", Utils.height), KANA_MULTI_RES_LOG_NAME)
	var max_pos = ZoneService.current_zone_max_position
	var min_pos = ZoneService.current_zone_min_position

	var zone_w = max_pos.x - min_pos.x
	var zone_h = max_pos.y - min_pos.y

	_camera.center_horizontal_pos = zone_w / 2
	_camera.center_vertical_pos = zone_h / 2

#	if zone_w + EDGE_SIZE * 2 <= Utils.project_width:
	if zone_w + EDGE_SIZE * 2 <= Utils.width:
		ModLoaderUtils.log_debug("_camera.center_horizontal = true", KANA_MULTI_RES_LOG_NAME)
		_camera.center_horizontal = true
	else :
		_camera.limit_right = max_pos.x + EDGE_SIZE
		_camera.limit_left = min_pos.x - EDGE_SIZE

#	if zone_h + EDGE_SIZE * 2 <= Utils.project_height:
	if zone_h + EDGE_SIZE * 2 <= Utils.height:
		_camera.center_vertical = true
	else :
		_camera.limit_bottom = max_pos.y + EDGE_SIZE
		_camera.limit_top = min_pos.y - EDGE_SIZE * 2
