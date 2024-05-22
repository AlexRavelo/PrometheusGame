class_name PlayerEntity

extends BaseEntity

@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_tree.set("parameters/Idle/blend_position", direction)
	
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	input()
	
	move_and_slide()

func input():
	var inputdir = Input.get_vector("Left","Right", "Up", "Down")
	if inputdir:
		direction.x = move_toward(direction.x, inputdir.x, 0.1)
		direction.y = move_toward(direction.y, inputdir.y, 0.1)
	
	velocity.x = move_toward(velocity.x, inputdir.x, base_speed)
	velocity.z = move_toward(velocity.y, inputdir.y, base_speed)
	
	
