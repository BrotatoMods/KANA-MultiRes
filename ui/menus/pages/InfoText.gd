extends Label

onready var info_text = $"."

func _ready():
	info_text.text = ''

func show_info_text(text:String):
		info_text.text = text
		info_text.show()
