extends Node3D

@export var areaName: String

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_3d_body_entered(body):
	if(body is PlayerEntity):
		print("entered area")



func _on_area_3d_body_exited(body):
	if(body is PlayerEntity):
		print("clean up area")
