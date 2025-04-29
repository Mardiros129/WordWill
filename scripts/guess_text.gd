extends Container

@onready var letter_slots: Array
@onready var offset = 65
@onready var current_character = 0

@export var light_theme: Theme
@export var dark_theme: Theme
@export var yellow_theme: Theme
@export var green_theme: Theme
@export var empty_theme: Theme
@export var full_theme: Theme

@export var box_scene: PackedScene

signal reveal_anim_finished
signal victory_anim_finished


func create_letter_slots(letter_count: int) -> void:
	for n in letter_count:
		var letter_box = box_scene.instantiate()
		self.add_child(letter_box)
		letter_box.position.x = offset * n
		letter_slots.append(letter_box)
	
	position.x -= letter_count * offset / 2


func delete_letter():
	if current_character > 0:
		current_character -= 1
		letter_slots[current_character].delete_letter()
		set_empty(current_character)


func insert_letter(input: String) -> void:
	if current_character < letter_slots.size():
		letter_slots[current_character].insert_letter(input)
		set_full(current_character)
		current_character += 1


func get_word() -> String:
	var word = ""
	for n in letter_slots.size():
		word += letter_slots[n].return_letter()
	return word


func full_reset() -> void:
	current_character = 0
	for n in letter_slots.size():
		letter_slots[n].delete_letter()
		set_empty(n)
		set_dark(n)
		letter_slots[n].reset_anim()


func play_reveal_anim() -> void:
	for n in letter_slots.size():
		letter_slots[n].play_box_reveal()
		await get_tree().create_timer(0.2).timeout
	
	reveal_anim_finished.emit()


func play_mistake_anim() -> void:
	for n in letter_slots.size():
		letter_slots[n].play_shake()


func play_victory_anim() -> void:
	await letter_slots[letter_slots.size() - 1].get_node("AnimationPlayer").animation_finished
	await get_tree().create_timer(1.0).timeout
	
	for n in letter_slots.size():
		letter_slots[n].play_box_victory()
		await get_tree().create_timer(0.2).timeout
	
	victory_anim_finished.emit()


func set_dark(index: int) -> void:
	letter_slots[index].get_node("ColorPanel").theme = dark_theme


func set_light(index: int) -> void:
	letter_slots[index].get_node("ColorPanel").theme = light_theme


func set_yellow(index: int) -> void:
	letter_slots[index].get_node("ColorPanel").theme = yellow_theme


func set_green(index: int) -> void:
	letter_slots[index].get_node("ColorPanel").theme = green_theme


func set_empty(index: int) -> void:
	letter_slots[index].get_node("CoverPanel").theme = empty_theme


func set_full(index: int) -> void:
	letter_slots[index].get_node("CoverPanel").theme = full_theme
