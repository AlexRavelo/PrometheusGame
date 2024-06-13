extends Node

func _ready():
	GlobalScript.default_focused_button = $"Options Button"

func _on_resume_button_button_up():
	get_tree().paused = false
	self.queue_free()


func _on_options_button_button_up():
	get_tree().call_group("Buttons","set_disabled", true)
	$Options.show()
	get_node("Options/PanelContainer/Back Button").grab_focus()
