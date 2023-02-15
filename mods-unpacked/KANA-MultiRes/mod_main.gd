extends Node

const KANA_MULTI_RES_LOG_NAME = "KANA-MultiRes"

func _init(modLoader = ModLoader, modLoaderUtils = ModLoaderUtils):
	modLoader.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/singletons/utils.gd")
	modLoader.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/singletons/progress_data.gd")
	modLoader.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/main.gd")
	modLoader.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/run/end_run.gd")
#	modLoader.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/shop/shop.gd")
	# Extending debug_service with script extension for shop.gd because in shop.gd is a reference to RunData.
	# And RunData is not yet initialized when calling this extension here.
	# To avoid an error in editor I moved the  script extension for shop.gd inside the debug_service extension
	# ¯\_ツ)_/¯
	modLoader.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/singletons/debug_service.gd")
	modLoader.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/title_screen/title_screen.gd")
	modLoader.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/pages/menu_general_options.gd")
	modLoader.add_translation_from_resource("res://mods-unpacked/KANA-MultiRes/translations/KANAMultiRes_Translation.de.translation")
	modLoader.add_translation_from_resource("res://mods-unpacked/KANA-MultiRes/translations/KANAMultiRes_Translation.en.translation")

	modLoaderUtils.log_info("Initialized", KANA_MULTI_RES_LOG_NAME)

func _ready():
	ModLoaderUtils.log_info("Finished loading KANA-Multi-Res mod.", KANA_MULTI_RES_LOG_NAME)
	KANA_edit_general_options_scene()

func KANA_edit_general_options_scene():
	var screen_stretch_container = load("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/pages/ScreenStretchContainer.tscn").instance()
	var screen_stretch_button = screen_stretch_container.get_node('ScreenStretchButton')
	var info_text = load("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/pages/InfoText.tscn").instance()

	var menu_general_options = load("res://ui/menus/pages/menu_general_options.tscn").instance()
	menu_general_options.add_child(info_text)
	info_text.set_owner(menu_general_options)
	var wrapper = menu_general_options.get_node('Options/Column1/VideoContainer/VBoxContainer')
	var full_screen_btn = wrapper.get_node('FullScreenButton')
	wrapper.add_child_below_node(full_screen_btn, screen_stretch_container, true)
	screen_stretch_button.select(ProgressData.settings.screen_stretch)
	screen_stretch_container.set_owner(menu_general_options)

	ModLoader.save_scene(menu_general_options, "res://ui/menus/pages/menu_general_options.tscn")
