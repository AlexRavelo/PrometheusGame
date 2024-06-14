extends StaticBody3D

class_name  Door


func _ready():
	var parent = get_parent()
	if not parent is Room || parent == null:
		print("ERROR: This door REQUIRES a parent to a Room.")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
