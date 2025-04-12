extends Node2D

@onready var line_edit = $LineEdit
@export var game_scene: PackedScene

func _on_button_pressed() -> void:
	if line_edit.text.length() > 0:
		var answer = line_edit.text.to_upper()
		
		var game = game_scene.instantiate()
		game.get_node("InputBox").answer = answer
		get_tree().root.add_child(game)
		get_tree().root.remove_child(self)
