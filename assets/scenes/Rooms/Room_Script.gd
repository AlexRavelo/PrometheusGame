extends Node3D

@export var areaName: String
@onready var spawner = $Spawner

signal on_player_entry
signal on_player_exit

# Called when the node enters the scene tree for the first time.
func _ready():
	#spawner.on_player_entry.connect(spawner.Mama())
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if body is PlayerEntity:
		on_player_entry.emit()


func _on_area_3d_body_exited(body):
	if body is PlayerEntity:
		on_player_exit.emit()
