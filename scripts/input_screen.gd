extends Control

@onready var enter_key = $EnterKey
@onready var delete_key = $DeleteKey
@onready var keyboard = $Keyboard

@onready var debug = $Debug
@onready var answer: String
@onready var answer_letter_count: Array[int]
@onready var guess_limit = 6
@onready var current_guess = 0
@onready var input_enabled = true

@onready var update_color_queue: Array

@export var light_theme: Theme
@export var dark_theme: Theme
@export var yellow_theme: Theme
@export var green_theme: Theme

@onready var guess_text_array = [$GuessText1, $GuessText2, $GuessText3, $GuessText4, $GuessText5, $GuessText6]

const ALPHABET_SIZE = 26


func _ready() -> void:
	set_debug_default()
	count_letters(answer, answer_letter_count)
	
	for n in guess_text_array.size():
		guess_text_array[n].create_letter_slots(answer.length())


func set_debug_default() -> void:
	debug.text = "Write a " + str(answer.length()) + "-letter word."
	

func _unhandled_input(event):
	if input_enabled:
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
		elif Input.is_action_just_pressed("Enter"):
			_on_enter_key_pressed()


func new_input(input: String) -> void:
	if current_guess < guess_limit:
		guess_text_array[current_guess].insert_letter(input)


func disable_keyboard(disable: bool) -> void:
	for n in keyboard.get_child_count():
		keyboard.get_child(n).disabled = disable
	input_enabled = not disable
	enter_key.disabled = disable
	delete_key.disabled = disable


func _on_reset_button_pressed() -> void:
	current_guess = 0
	
	disable_keyboard(false)
	
	for n in guess_text_array.size():
		guess_text_array[n].full_reset()
	
	for n in keyboard.get_child_count():
		keyboard.get_child(n).theme = light_theme
		keyboard.get_child(n).reset_key()
	
	set_debug_default()


func _on_enter_key_pressed():
	var my_word = guess_text_array[current_guess].get_word()
	var shared_letter_count: Array[int]
	shared_letter_count.resize(ALPHABET_SIZE)
	shared_letter_count.fill(0)
	compare_letters(my_word, answer_letter_count, shared_letter_count)
	#print("Shared letter count: " + str(shared_letter_count))
	
	## Check if word is the right size
	if my_word.length() != answer.length():
		debug.text = "Not a " + str(answer.length()) + "-letter word."
		guess_text_array[current_guess].play_mistake_anim()
	
	## Check validity of each letter
	else:
		disable_keyboard(true)
		
		## Change keyboard color
		for x in my_word.length():
			var missing_letter = keyboard.get_node(my_word[x] + "Key")
			missing_letter.checked = true
			update_color_queue.append(missing_letter)
			
			if not answer.contains(my_word[x]):
				missing_letter.in_word = false
			elif answer[x] == my_word[x]:
				missing_letter.in_word = true
				missing_letter.in_position = true
			else:
				if not missing_letter.in_position:
					missing_letter.in_word = true
					missing_letter.in_position = false
			
		## Change guess boxes color
		# First check for green letters and lower the counter
		var checked: Array[bool] # Keep track of what we checked already
		checked.resize(my_word.length())
		checked.fill(false)
		
		for x in my_word.length():
			if answer[x] == my_word[x]:
				guess_text_array[current_guess].set_green(x)
				deprecate_letter(my_word[x], shared_letter_count)
				checked[x] = true
				
		# Next, check for yellow letters but skip what was checked
		for x in my_word.length():
			if not checked[x]:
				checked[x] = true
				
				var my_letter_index = get_letter_index(my_word[x])
				# Check if the letter is in the answer and if there's still letters remaining in the guess
				if shared_letter_count[my_letter_index] > 0:
					guess_text_array[current_guess].set_yellow(x)
					deprecate_letter(my_word[x], shared_letter_count)
		
		guess_text_array[current_guess].play_reveal_anim()
		
		## Victory condition
		if my_word == answer:
			# Play anim and then signal when it's done so that the answer isn't spoiled early
			guess_text_array[current_guess].play_victory_anim()
		
		current_guess += 1


# Counts the number of letters in the string and assigns that number to size-26 array
func count_letters(word: String, letter_count: Array[int]) -> void:
	letter_count.resize(ALPHABET_SIZE)
	letter_count.fill(0)

	for n in word.length():
		var letter = word.substr(n, 1)
		var letter_index:int
		letter_index = get_letter_index(letter)
		letter_count[letter_index] += 1
		# Adds to array at index of letter pos


# Compare the answer with the guess to see how many letters they share. Assign to size-26 array.
func compare_letters(my_guess: String, answer_letter_count: Array[int], shared_letter_count: Array[int]) -> void:
	var guess_letter_count: Array[int]
	count_letters(my_guess, guess_letter_count)
	
	#print("Answer letter count: " + str(answer_letter_count))
	#print("Guess letter count: " + str(guess_letter_count))
	
	# Take the minimum value and assign it to the comparison
	for n in ALPHABET_SIZE:
		if answer_letter_count[n] < guess_letter_count[n]:
			shared_letter_count[n] = answer_letter_count[n]
		else:
			shared_letter_count[n] = guess_letter_count[n]


# The letter has been counted, so deprecate the number in the size-26 array.
func deprecate_letter(letter: String, letter_count: Array[int]) -> void:
	var letter_index = get_letter_index(letter)
	letter_count[letter_index] -= 1


# Calculate a single letter's unique index using its hex value.
func get_letter_index(letter: String) -> int:
	var letter_hex = letter.to_utf8_buffer().hex_encode()
	var letter_index = letter_hex.hex_to_int() % ALPHABET_SIZE # 'N' is the first letter in the array, change to 'A'?
	return letter_index


func _on_delete_key_pressed():
	guess_text_array[current_guess].delete_letter()


func _on_guess_text_reveal_anim_finished() -> void:
	disable_keyboard(false)
	for n in update_color_queue.size():
		if not update_color_queue[n].in_word:
			update_color_queue[n].theme = dark_theme
		elif update_color_queue[n].in_word and not update_color_queue[n].in_position:
			update_color_queue[n].theme = yellow_theme
		elif update_color_queue[n].in_word and update_color_queue[n].in_position:
			update_color_queue[n].theme = green_theme
	
	update_color_queue.clear()
	
	# Defeat
	if current_guess == guess_limit:
			disable_keyboard(true)
			debug.text = answer


func _on_guess_text_victory_anim_finished() -> void:
	debug.text = "Good job!"
	disable_keyboard(true)


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
