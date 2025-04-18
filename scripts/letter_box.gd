extends Control

@onready var anim_player = $AnimationPlayer
@onready var label = $Label


func insert_letter(letter: String):
	label.text = letter
	anim_player.play("pop")


func delete_letter():
	label.text = ""


func return_letter() -> String:
	return label.text


func play_box_reveal():
	anim_player.play("reveal")


func play_box_victory():
	anim_player.play("victory")


func reset_anim():
	anim_player.play("RESET")
