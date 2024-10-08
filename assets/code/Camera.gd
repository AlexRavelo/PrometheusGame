extends Camera3D

@export var Camera_Target: Node3D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	if Camera_Target:
		position.x = lerpf(position.x, Camera_Target.position.x, 0.04)
		position.z = lerpf(position.z, Camera_Target.position.z + 10, 0.04)
