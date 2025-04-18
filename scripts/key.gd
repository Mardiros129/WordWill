extends Button

@onready var checked = false
@onready var in_word = false
@onready var in_position = false


func reset_key() -> void:
	checked = false
	in_word = false
	in_position = false
