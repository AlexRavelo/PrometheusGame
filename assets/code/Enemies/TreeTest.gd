extends CharacterBody3D

@onready var animation_tree = $AnimationTree

func _process(delta):
	if !is_on_floor():
		velocity.y -= 5 * delta
		
	var inputdir = Input.get_vector("numleft", "numright", "numup", "numdown")
	velocity.x = inputdir.x * 5
	velocity.z = inputdir.y * 5
	
	var blend_pos : Vector2
	blend_pos.x = lerpf(blend_pos.x, velocity.x, 0.2)
	blend_pos.y = lerpf(blend_pos.y, velocity.z, 0.2)
	animation_tree.set("parameters/blend_position", blend_pos)
	print(blend_pos)
	
	
	move_and_slide()
	
