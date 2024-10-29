extends "res://ui/menus/global/focus_emulator.gd"



func _init() -> void:
	for base in focus_base_data:
		if base.path == "../Menus/MainMenu/MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer":
			base.path = "../Menus/MainMenu/ARC/MarginContainer/HBoxContainer/HBoxContainer/VBoxContainer"
