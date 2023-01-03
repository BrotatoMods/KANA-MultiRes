extends "res://singletons/progress_data.gd"

var screen_stretch = [
	"OPTION_SCREEN_STRETCH_KEEP",
		"OPTION_SCREEN_STRETCH_EXPAND",
	"OPTION_SCREEN_STRETCH_EXPAND_WIDTH"]

func _init():
	if(!settings.has("screen_stretch")):
		settings["screen_stretch"] = 0
