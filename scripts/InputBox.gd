extends Control

@onready var enter_key = $Keyboard/EnterKey
@onready var delete_key = $Keyboard/DeleteKey
@onready var keyboard = $Keyboard

@onready var debug = $Debug
@onready var answer
@onready var guess_limit = 6
@onready var current_guess = 0

@export var light_theme: Theme
@export var dark_theme: Theme
@export var yellow_theme: Theme
@export var green_theme: Theme

@onready var guess_text_array = [$GuessText1, $GuessText2, $GuessText3, $GuessText4, $GuessText5, $GuessText6]


func _ready() -> void:
	debug.text = "Write a " + str(answer.length()) + "-letter word."
	for n in guess_text_array.size():
		guess_text_array[n].create_letter_slots(answer.length())


func _unhandled_input(event):
	if Input.is_action_just_pressed("Action_A"):
		new_input("A")
	elif Input.is_action_just_pressed("Action_B"):
		new_input("B")
	elif Input.is_action_just_pressed("Action_C"):
		new_input("C")
	elif Input.is_action_just_pressed("Action_D"):
		new_input("D")
	elif Input.is_action_just_pressed("Action_E"):
		new_input("E")
	elif Input.is_action_just_pressed("Action_F"):
		new_input("F")
	elif Input.is_action_just_pressed("Action_G"):
		new_input("G")
	elif Input.is_action_just_pressed("Action_H"):
		new_input("H")
	elif Input.is_action_just_pressed("Action_I"):
		new_input("I")
	elif Input.is_action_just_pressed("Action_J"):
		new_input("J")
	elif Input.is_action_just_pressed("Action_K"):
		new_input("K")
	elif Input.is_action_just_pressed("Action_L"):
		new_input("L")
	elif Input.is_action_just_pressed("Action_M"):
		new_input("M")
	elif Input.is_action_just_pressed("Action_N"):
		new_input("N")
	elif Input.is_action_just_pressed("Action_O"):
		new_input("O")
	elif Input.is_action_just_pressed("Action_P"):
		new_input("P")
	elif Input.is_action_just_pressed("Action_Q"):
		new_input("Q")
	elif Input.is_action_just_pressed("Action_R"):
		new_input("R")
	elif Input.is_action_just_pressed("Action_S"):
		new_input("S")
	elif Input.is_action_just_pressed("Action_T"):
		new_input("T")
	elif Input.is_action_just_pressed("Action_U"):
		new_input("U")
	elif Input.is_action_just_pressed("Action_V"):
		new_input("V")
	elif Input.is_action_just_pressed("Action_W"):
		new_input("W")
	elif Input.is_action_just_pressed("Action_X"):
		new_input("X")
	elif Input.is_action_just_pressed("Action_Y"):
		new_input("Y")
	elif Input.is_action_just_pressed("Action_Z"):
		new_input("Z")
	elif Input.is_physical_key_pressed(KEY_BACKSPACE):
		_on_delete_key_pressed()
	elif Input.is_physical_key_pressed(KEY_ENTER):
		_on_enter_key_pressed()


func new_input(input: String) -> void:
	if current_guess < guess_limit:
		guess_text_array[current_guess].insert_letter(input)


func disable_keyboard(disable: bool) -> void:
	for n in keyboard.get_child_count():
		keyboard.get_child(n).disabled = disable


func _on_reset_button_pressed() -> void:
	current_guess = 0
	
	disable_keyboard(false)
	
	for n in guess_text_array.size():
		guess_text_array[n].full_reset()
	
	for n in keyboard.get_child_count():
		keyboard.get_child(n).theme = light_theme


func _on_enter_key_pressed():
	var my_word = guess_text_array[current_guess].get_word()
	if my_word.length() != answer.length():
		debug.text = "Not a " + str(answer.length()) + "-letter word."
	
	else:
		if my_word == answer:
			debug.text = "Victory!"
			disable_keyboard(true)
		else:
			debug.text = "Try again"
			
		for x in my_word.length():
			var missing_letter = keyboard.get_node(my_word[x] + "Key")
			
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
				else:
					guess_text_array[current_guess].set_dark(x)
		
		current_guess += 1
		if current_guess == guess_limit:
			disable_keyboard(true)


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
