extends Node


const KANA_MULTI_RES_DIR := "KANA-MultiRes"
const KANA_MULTI_RES_LOG_NAME := "KANA-MultiRes:ModMain"

var mod_dir_path := ""
var extensions_dir_path := ""
var translations_dir_path := ""


func _init():
	mod_dir_path = ModLoaderMod.get_unpacked_dir().plus_file(KANA_MULTI_RES_DIR)

	install_script_extensions()
	add_translations()

	ModLoaderLog.info("Initialized", KANA_MULTI_RES_LOG_NAME)


func install_script_extensions() -> void:
	extensions_dir_path = mod_dir_path.plus_file("extensions")
	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/singletons/utils.gd")
	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/main.gd")
	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/run/end_run.gd")
	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/singletons/debug_service.gd")
	#	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/shop/shop.gd")
	# Extending debug_service with script extension for shop.gd because in shop.gd is a reference to RunData.
	# And RunData is not yet initialized when calling this extension here.
	# To avoid an error in editor I moved the  script extension for shop.gd inside the debug_service extension
	# ¯\_ツ)_/¯
	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/title_screen/title_screen.gd")
	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/ingame/ingame_main_menu.gd")
	ModLoaderMod.install_script_extension("res://mods-unpacked/KANA-MultiRes/extensions/ui/menus/ingame/upgrades_ui.gd")
	ModLoaderMod.install_script_extension(extensions_dir_path.plus_file("ui/menus/global/focus_emulator.gd"))


func add_translations() -> void:
	translations_dir_path = mod_dir_path.plus_file("translations")
	ModLoaderMod.add_translation("res://mods-unpacked/KANA-MultiRes/translations/KANAMultiRes_Translation.de.translation")
	ModLoaderMod.add_translation("res://mods-unpacked/KANA-MultiRes/translations/KANAMultiRes_Translation.en.translation")


func _ready():
	ModLoaderLog.info("Finished loading KANA-Multi-Res mod.", KANA_MULTI_RES_LOG_NAME)
	var mod_options := get_node("/root/ModLoader/dami-ModOptions/ModsConfigInterface")
	mod_options.connect("setting_changed", self, "_on_mod_options_setting_changed")


func _on_mod_options_setting_changed(setting_name, value, mod_name) -> void:
	if mod_name == KANA_MULTI_RES_DIR:
		if ModLoaderConfig.get_current_config_name(KANA_MULTI_RES_DIR) == "default":
			var mod_config := ModLoaderConfig.duplicate_config(ModLoaderConfig.get_default_config(KANA_MULTI_RES_DIR), "custom")
			ModLoaderConfig.set_current_config(mod_config)

		ModLoaderConfig.update_config_value(
			ModLoaderConfig.get_current_config(KANA_MULTI_RES_DIR),
			setting_name,
			value
		)

		if Utils:
			Utils.set_stretch_mode()

