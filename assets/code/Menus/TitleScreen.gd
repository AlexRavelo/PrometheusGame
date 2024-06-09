extends Node2D


func _on_start_button_button_up():
	get_tree().change_scene_to_file("res://assets/scenes/test_scenes/dev_test_area.tscn")


func _on_options_button_button_up():
	get_tree().call_group("Buttons","set_disabled", true)
	$Options.show()
