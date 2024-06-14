extends Control

func _on_back_button_button_up():
	get_tree().call_group("Buttons","set_disabled", false)
	$".".hide()


func _on_credits_buton_button_up():
	var credits_scene = load("res://assets/scenes/Menus/credits.tscn")
	var credits = credits_scene.instantiate()
	add_child(credits)
	#i will be changing this later. why did i do this
