

extends BaseEntity

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var direction: Vector2 = Input.get_vector("Left","Right","Up","Down")
	
	velocity.x = move_toward(velocity.x, direction.x*base_speed, base_speed)
	velocity.y = move_toward(velocity.y, direction.y*base_speed, base_speed)
	
	
	move_and_slide()
