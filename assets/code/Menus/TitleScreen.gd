extends Control

func _ready():
	#$"Main/Start Button".grab_focus()
	pass

func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://assets/scenes/test_scenes/dev_test_area.tscn")

func _on_options_button_button_up():
	get_tree().call_group("Buttons","set_disabled", true)
	$"Options".show()

func _on_credits_buton_button_up():
	get_tree().call_group("Buttons","set_disabled", true)
	$Credits.show()


func _on_exit_button_button_up():
	get_tree().quit()



