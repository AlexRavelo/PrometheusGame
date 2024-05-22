class_name PlayerEntity

extends BaseEntity

<<<<<<< Updated upstream
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

=======
@onready var area_3d = $Area3D
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
>>>>>>> Stashed changes

var current_pos

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var input_x = Input.get_axis("Left","Right")
	var input_z = Input.get_axis("Up","Down")
	var direction = (self.transform.basis * Vector3(input_x,0,input_z)).normalized()
	
	velocity.x = move_toward(velocity.x, direction.x, base_speed)
	velocity.z = move_toward(velocity.y, direction.z, base_speed)
	
	
	move_and_slide()
<<<<<<< Updated upstream
=======

func input():
	var inputdir = Input.get_vector("Left","Right", "Up", "Down")
	if inputdir:
		direction.x = move_toward(direction.x, inputdir.x, 0.1)
		direction.y = move_toward(direction.y, inputdir.y, 0.1)

	
	area_3d.look_at($".".global_transform.origin)
	
	velocity.x = move_toward(velocity.x, inputdir.x, base_speed)
	velocity.z = move_toward(velocity.z, inputdir.y, base_speed)
	
	
>>>>>>> Stashed changes
