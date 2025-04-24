extends Control

@onready var line_edit = $LineEdit
@export var game_scene: PackedScene
@onready var dictionary_data = {}
@onready var visiblity_toggle = $VisibilityToggle

@onready var dictionary_path = "res://JSON/test_index.json" # This doesn't seem to work with very big files


func _ready() -> void:
	line_edit.grab_focus()


func _process(delta: float) -> void:
	if Input.is_action_pressed("Exit"):
		get_tree().quit()
	
	if Input.is_action_just_pressed("Enter"):
		start_game()


func start_game() -> void:
	if line_edit.text.length() > 2:
		var answer = line_edit.text.to_upper()
		
		var game = game_scene.instantiate()
		game.get_node("InputScreen").answer = answer
		get_tree().root.add_child(game)
		line_edit.clear()
		self.hide()


func restart() -> void:
	self.show()
	line_edit.grab_focus()
	visiblity_toggle.button_pressed = true


func _on_button_pressed() -> void:
	start_game()


func _on_visibility_toggle_toggled(toggled_on: bool) -> void:
	line_edit.secret = toggled_on


func _on_dictionary_pressed() -> void:
	var data_file = FileAccess.open(dictionary_path, FileAccess.READ)
	var parsed_result = JSON.parse_string(data_file.get_as_text())
	dictionary_data = parsed_result
