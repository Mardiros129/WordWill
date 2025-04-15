extends Control

@onready var letter_slots: Array
@onready var offset = 90
@onready var current_character = 0

@export var light_theme: Theme
@export var dark_theme: Theme
@export var yellow_theme: Theme
@export var green_theme: Theme
@export var empty_theme: Theme

@export var box_scene: PackedScene


func create_letter_slots(letter_count: int) -> void:
	for n in letter_count:
		var letter_box = box_scene.instantiate()
		self.add_child(letter_box)
		letter_box.position.x = offset * n
		letter_slots.append(letter_box)


func delete_letter():
	if current_character > 0:
		current_character -= 1
		letter_slots[current_character].delete_letter()


func insert_letter(input: String) -> void:
	if current_character < letter_slots.size():
		letter_slots[current_character].insert_letter(input)
		current_character += 1


func get_word() -> String:
	var word = ""
	for n in letter_slots.size():
		word += letter_slots[n].return_letter()
	return word


func full_reset() -> void:
	for n in letter_slots.size():
		letter_slots[n].delete_letter()
		set_empty(n)


func set_dark(index: int) -> void:
	letter_slots[index].get_node("Panel").theme = dark_theme


func set_light(index: int) -> void:
	letter_slots[index].get_node("Panel").theme = light_theme


func set_yellow(index: int) -> void:
	letter_slots[index].get_node("Panel").theme = yellow_theme


func set_green(index: int) -> void:
	letter_slots[index].get_node("Panel").theme = green_theme


func set_empty(index: int) -> void:
	letter_slots[index].get_node("Panel").theme = empty_theme
