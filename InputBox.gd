extends Control

@onready var enter_key = $EnterKey
@onready var debug = $Debug
@onready var answer
@onready var guess_limit = 6
@onready var current_guess = 0

@export var light_theme: Theme
@export var dark_theme: Theme
@export var yellow_theme: Theme
@export var green_theme: Theme

@onready var guess_text_array = [$GuessText1, $GuessText2, $GuessText3, $GuessText4, $GuessText5, $GuessText6]


func new_input(input: String) -> void:
	guess_text_array[current_guess].insert_letter(input)


func _ready() -> void:
	debug.text = "Write a " + str(answer.length()) + "-letter word."
	for n in guess_text_array.size():
		guess_text_array[n].create_letter_slots(answer.length())


func _on_enter_key_pressed():
	var my_word = guess_text_array[current_guess].get_word()
	if my_word.length() != answer.length():
		debug.text = "Not a " + str(answer.length()) + "-letter word."
	
	else:
		if my_word == answer:
			debug.text = "Victory!"
		else:
			debug.text = "Try again"
			
		for x in my_word.length():
			var missing_letter = get_node(my_word[x] + "Key")
			
			if not answer.contains(my_word[x]):
				missing_letter.theme = dark_theme
				guess_text_array[current_guess].set_dark(x)
			elif answer[x] == my_word[x]:
				missing_letter.theme = green_theme
				guess_text_array[current_guess].set_green(x)
			else:
				if missing_letter.theme != green_theme:
					missing_letter.theme = yellow_theme
					guess_text_array[current_guess].set_yellow(x)
		
		current_guess += 1
		if current_guess == guess_limit:
			enter_key.disabled = true


func _on_delete_key_pressed():
	guess_text_array[current_guess].delete_letter()


func _on_a_key_pressed():
	new_input("A")


func _on_b_key_pressed():
	new_input("B")


func _on_c_key_pressed():
	new_input("C")


func _on_d_key_pressed():
	new_input("D")


func _on_e_key_pressed():
	new_input("E")


func _on_f_key_pressed():
	new_input("F")


func _on_g_key_pressed():
	new_input("G")


func _on_h_key_pressed():
	new_input("H")


func _on_i_key_pressed():
	new_input("I")


func _on_j_key_pressed():
	new_input("J")


func _on_k_key_pressed():
	new_input("K")


func _on_l_key_pressed():
	new_input("L")


func _on_m_key_pressed():
	new_input("M")


func _on_n_key_pressed():
	new_input("N")


func _on_o_key_pressed():
	new_input("O")


func _on_p_key_pressed():
	new_input("P")


func _on_q_key_pressed():
	new_input("Q")


func _on_r_key_pressed():
	new_input("R")


func _on_s_key_pressed():
	new_input("S")


func _on_t_key_pressed():
	new_input("T")


func _on_u_key_pressed():
	new_input("U")


func _on_v_key_pressed():
	new_input("V")


func _on_w_key_pressed():
	new_input("W")


func _on_x_key_pressed():
	new_input("X")


func _on_y_key_pressed():
	new_input("Y")


func _on_z_key_pressed():
	new_input("Z")
