class_name PlayerEntity

extends BaseEntity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_x = Input.get_axis("Left","Right")
	var input_z = Input.get_axis("Up","Down")
	var direction = (self.transform.basis * Vector3(input_x,0,input_z)).normalized()
	
	velocity.x = move_toward(velocity.x, direction.x, base_speed)
	velocity.z = move_toward(velocity.y, direction.z, base_speed)
	
	
	move_and_slide()
