class_name PlayerEntity

extends BaseEntity

@export_range(0.0,100.0,0.1) var player_movespeed = 5

@onready var attack_hitbox = $AttackHitbox
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_tree.set("parameters/Idle/blend_position", direction)
	
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("Attack"):
		_attack()
	
	
	move_input()
	
	move_and_slide()

func move_input():
	var inputdir = Input.get_vector("Left","Right", "Up", "Down")
	if inputdir:
		direction.x = move_toward(direction.x, inputdir.x, 0.1)
		direction.y = move_toward(direction.y, inputdir.y, 0.1)
		
	velocity.x = move_toward(velocity.x, inputdir.x*player_movespeed, base_speed)
	velocity.z = move_toward(velocity.z, inputdir.y*player_movespeed, base_speed)
	
func _attack():
	var target = attack_hitbox.get_overlapping_bodies()
	print("aaabaababababfbbfb")
