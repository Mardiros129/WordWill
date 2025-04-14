extends Node2D


func _unhandled_input(event):
	if Input.is_action_pressed("Exit"):
		get_tree().quit()


func _on_menu_button_pressed() -> void:
	get_tree().root.get_node("StartMenu").show()
	self.queue_free()
