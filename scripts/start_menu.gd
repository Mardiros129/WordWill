extends Control

@onready var line_edit = $LineEdit
@export var game_scene: PackedScene



func _on_button_pressed() -> void:
	if line_edit.text.length() > 2:
		var answer = line_edit.text.to_upper()
		
		var game = game_scene.instantiate()
		game.get_node("InputBox").answer = answer
		get_tree().root.add_child(game)
		line_edit.clear()
		self.hide()


func _unhandled_input(event):
	if Input.is_action_pressed("Exit"):
		get_tree().quit()


func _on_visibility_toggle_toggled(toggled_on: bool) -> void:
	line_edit.secret = toggled_on
