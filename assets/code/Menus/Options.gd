extends Control

func _ready():
	#$"PanelContainer/Back Button".grab_focus()
	pass

func _on_back_button_button_up():
	get_tree().call_group("Buttons","set_disabled", false)
	GlobalScript.default_focused_button.grab_focus()
	$".".hide()
