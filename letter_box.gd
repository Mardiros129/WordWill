extends Panel

@onready var anim_player = $AnimationPlayer
@onready var label = $Label


func new_letter(letter: String):
	print("hi")
	label.text = letter
	anim_player.play("pop")


func delete_letter():
	label.text = ""


func return_letter() -> String:
	return label.text
