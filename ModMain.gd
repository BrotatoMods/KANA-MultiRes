extends Node

# Ensure this runs before any mods which cause ships/Shipyard.gd to be
# loaded, as it loads ship .tscn files which bind the original
# ship-ctrl.gd, not giving us a chance to replace it.
const MOD_PRIORITY = -1

func _init(modLoader = ModLoader):
	modLoader.installScriptExtension("res://KANA-MultiRes/singletons/utils.gd")
	modLoader.installScriptExtension("res://KANA-MultiRes/singletons/progress_data.gd")
	modLoader.installScriptExtension("res://KANA-MultiRes/main.gd")
	modLoader.installScriptExtension("res://KANA-MultiRes/ui/menus/run/end_run.gd")
	modLoader.installScriptExtension("res://KANA-MultiRes/ui/menus/shop/shop.gd")
	modLoader.installScriptExtension("res://KANA-MultiRes/ui/menus/title_screen/title_screen.gd")
	modLoader.installScriptExtension("res://KANA-MultiRes/ui/menus/pages/menu_general_options.gd")

#	modLoader.addTranslationsFromCSV("res://KANAMultiRes/KANAMultiRes_Translation.csv")
	modLoader.addTranslationFromResource("res://KANA-MultiRes/KANAMultiRes_Translation.de.translation")
	modLoader.addTranslationFromResource("res://KANA-MultiRes/KANAMultiRes_Translation.en.translation")
	
	modLoader.mod_log("KANAMultiRes: Initialized")
	
func _ready():
	KANA_edit_general_options_scene(ModLoader)
	ModLoader.mod_log("KANAMultiRes: Finished loading KANA-Multi-Res mod.")

func KANA_edit_general_options_scene(modLoader):
	var screen_stretch_container = load("res://KANA-MultiRes/ui/menus/pages/ScreenStretchContainer.tscn").instance()
	var screen_stretch_button = screen_stretch_container.get_node('ScreenStretchButton')
	var info_text = load("res://KANA-MultiRes/ui/menus/pages/InfoText.tscn").instance()
	
	var menu_general_options = load("res://ui/menus/pages/menu_general_options.tscn").instance()
	menu_general_options.add_child(info_text)
	info_text.set_owner(menu_general_options)
	var wrapper = menu_general_options.get_node('Options/Column1/VideoContainer/VBoxContainer')
	var full_screen_btn = wrapper.get_node('FullScreenButton')
	wrapper.add_child_below_node(full_screen_btn, screen_stretch_container, true)
	screen_stretch_button.select(ProgressData.settings.screen_stretch)
	screen_stretch_container.set_owner(menu_general_options)
	
	modLoader.saveScene(menu_general_options, "res://ui/menus/pages/menu_general_options.tscn")
