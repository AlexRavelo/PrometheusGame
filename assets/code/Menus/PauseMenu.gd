extends Node2D


func _on_resume_button_button_up():
	get_tree().paused = false
	self.queue_free()


func _on_options_button_button_up():
	get_tree().call_group("Buttons","set_disabled", true)
	$Options.show()
	