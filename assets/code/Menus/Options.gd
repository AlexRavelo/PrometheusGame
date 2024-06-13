extends Control

func _ready():
	$"PanelContainer/Back Button".grab_focus()

func _on_back_button_button_up():
	get_tree().call_group("Buttons","set_disabled", false)
	$".".hide()
