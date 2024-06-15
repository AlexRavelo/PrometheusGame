extends Control


func _ready():
	get_tree().paused = true


func _on_return_to_title_button_button_up():
	get_tree().paused = false
	get_tree().change_scene_to_file("res://assets/scenes/Menus/TitleScreen.tscn")


func _on_continue_button_button_up():
	get_tree().paused = false
	get_tree().reload_current_scene()
