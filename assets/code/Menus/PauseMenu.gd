extends Node2D

func _ready():
	pass

func _on_resume_button_button_up():
	get_tree().paused = false
	self.queue_free()


func _on_options_button_button_up():
	$Options.show()
