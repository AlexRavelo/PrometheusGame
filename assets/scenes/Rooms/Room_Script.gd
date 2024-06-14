extends Node3D
class_name Room

@export var areaName: String
@onready var spawner = $Spawner

signal on_player_entry
signal on_player_exit

# Called when the node enters the scene tree for the first time.
func _ready():
	get_node("Spawner").connect("on_enemies_cleared", _remove_doors)
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _activate_doors():
	var door_list = get_children()
	for n in door_list:
		if n is Door:
			n.show()
			n.get_child(0).set_deferred("disabled", false)


func _remove_doors():
	var door_list = get_children()
	for n in door_list:
		if n is Door:
			n.hide()
			n.get_child(0).set_deferred("disabled", true)


func _on_area_3d_body_entered(body):
	if body is PlayerEntity:
		_activate_doors()
		on_player_entry.emit()


func _on_area_3d_body_exited(body):
	if body is PlayerEntity:
		on_player_exit.emit()
