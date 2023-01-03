extends "res://singletons/utils.gd"

# Set this to the ProjectSettings by default and change it to the viewport Values if needed
var width = ProjectSettings.get_setting("display/window/size/width")
var height = ProjectSettings.get_setting("display/window/size/height")

var viewport_width
var viewport_height
var visible_rect_width 
var visible_rect_height

func _ready():
	handle_size_changed()
	get_tree().get_root().connect("size_changed", self, "handle_size_changed")

func check_main():
	return get_tree().get_root().has_node("Main")

func set_strecht_mode() -> void:
	ModLoader.mod_log(str('KANAMultiRes: Calling set_strecht_mode with argument -> ', ProgressData.screen_stretch[ProgressData.settings.screen_stretch]))	
	
	var is_main = check_main()
	
	if(ProgressData.settings.screen_stretch == 0 || !is_main):
		
		width = Utils.project_width
		height = Utils.project_height
		
		ModLoader.mod_log(str("KANAMultiRes: set stretch mode to KEEP: ", width, " x ", height))
		
		# Set Screen Stretch to keep
		get_tree().set_screen_stretch(
			SceneTree.STRETCH_MODE_2D,
			SceneTree.STRETCH_ASPECT_KEEP,
			Vector2(width, height)
			)
	elif(viewport_width > project_width):
		# Only if the viewport with is actually higher then the project widht
		if(ProgressData.settings.screen_stretch == 2):
			# Settings set to "expand width"
			width = Utils.visible_rect_width
			height = Utils.project_height
			
			ModLoader.mod_log(str("KANAMultiRes: set stretch mode to KEEP_HEIGHT: ", width, " x ", height))
			
			get_tree().set_screen_stretch(
					SceneTree.STRETCH_MODE_2D,
					SceneTree.STRETCH_ASPECT_KEEP_HEIGHT,
					Vector2(Utils.project_width, Utils.height)
					)
		# Settings set to "expand"
		elif(ProgressData.settings.screen_stretch == 1):
				width = viewport_width
				height = viewport_height
				
				ModLoader.mod_log(str("KANAMultiRes: set stretch mode to EXPAND: ", width, " x ", height))
				
				get_tree().set_screen_stretch(
					SceneTree.STRETCH_MODE_2D,
					SceneTree.STRETCH_ASPECT_EXPAND,
					Vector2(width, height)
				)
	else:
		print('ERROR: Expected EXPAND or KEEP!')

func handle_size_changed() -> void:
	var viewport = get_tree().root.get_viewport()
	var visible_rect_size = viewport.get_visible_rect().size
	
	viewport_width = viewport.size.x
	viewport_height = viewport.size.y
	visible_rect_width = visible_rect_size.x
	visible_rect_height = visible_rect_size.y
	
	ModLoader.mod_log(str("KANAMultiRes: Viewport visible_rect -> ", visible_rect_size))
	ModLoader.mod_log(str("KANAMultiRes: Size changed! : ", viewport_width , ' x ', viewport_height))
	set_strecht_mode()
