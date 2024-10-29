extends "res://ui/menus/ingame/upgrades_ui.gd"


func _ready() -> void:
	if is_coop_ui:
		KANA_add_margin_container()


func KANA_add_margin_container() -> void:
	var new_margin_container := MarginContainer.new()
	new_margin_container.mouse_filter = Control.MOUSE_FILTER_IGNORE
	new_margin_container.anchor_right = 1.0
	new_margin_container.anchor_bottom = 1.0
	add_child(new_margin_container)

	var content = get_node("Content")

	for child in content.get_children():
		content.remove_child(child)
		new_margin_container.add_child(child)

	remove_child(content)

	new_margin_container.name = "Content"
