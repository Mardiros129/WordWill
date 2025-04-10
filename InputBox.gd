extends Label

@onready var output = $Output


func new_input(input: String) -> void:
	text += input


func _on_enter_key_pressed():
	var my_word = text
	text = ""
	output.text += my_word + "\n"


func _on_delete_key_pressed():
	if text.length() > 0:
		text = text.substr(0, text.length() - 1)


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
