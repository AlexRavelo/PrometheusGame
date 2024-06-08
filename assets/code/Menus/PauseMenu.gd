extends Node2D


func _on_resume_button_up():
	get_tree().paused = false
	self.queue_free()
