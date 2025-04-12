extends Control

@onready var letter_slots: Array
@onready var offset = 40
@onready var current_character = 0

@export var light_theme: Theme
@export var dark_theme: Theme
@export var yellow_theme: Theme
@export var green_theme: Theme


func create_letter_slots(letter_count: int) -> void:
	var letter = get_child(0)
	
	for n in letter_count:
		var new_letter = letter.duplicate()
		add_child(new_letter)
		new_letter.position.x = offset * n
		letter_slots.append(new_letter)
	
	letter.hide()


func delete_letter():
	if current_character > 0:
		current_character -= 1
		letter_slots[current_character].text = ""


func insert_letter(input: String) -> void:
	if current_character < letter_slots.size():
		letter_slots[current_character].text = input
		current_character += 1


func get_word() -> String:
	var word = ""
	for n in letter_slots.size():
		word += letter_slots[n].text
	return word


func set_dark(index: int) -> void:
	letter_slots[index].theme = dark_theme


func set_yellow(index: int) -> void:
	letter_slots[index].theme = yellow_theme


func set_green(index: int) -> void:
	letter_slots[index].theme = green_theme
