extends Node2D


func _unhandled_input(event):
	if Input.is_action_pressed("Exit"):
		get_tree().quit()


func _on_menu_button_pressed() -> void:
	get_tree().root.get_node("StartMenu").restart()
	self.queue_free()


func _on_close_button_pressed() -> void:
	get_tree().quit()
