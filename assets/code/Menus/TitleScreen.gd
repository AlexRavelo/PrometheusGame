extends Control

func _ready():
	GlobalScript.default_focused_button = $"Main/Options Button"
	#$"Main/Start Button".grab_focus()

func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://assets/scenes/test_scenes/dev_test_area.tscn")


func _on_options_button_button_up():
	get_tree().call_group("Buttons","set_disabled", true)
	#$"Options/PanelContainer/Back Button".grab_focus()
	$Options.show()


func _on_exit_button_button_up():
	get_tree().quit()
