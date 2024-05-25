class_name PlayerEntity

extends BaseEntity

@onready var attack_hitbox = $AttackHitbox
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_tree.set("parameters/Idle/blend_position", direction)
	
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("Attack"):
		attack()
	
	debug_commands()
	
	move_input()
	
	move_and_slide()

func debug_commands():
	if Input.is_key_pressed(KEY_R): #in case you fall and fucking die, DELETE LATER
		get_tree().reload_current_scene()

func move_input():
	var inputdir = Input.get_vector("Left","Right", "Up", "Down")
	if inputdir:
		direction.x = lerpf(direction.x, inputdir.x, 0.08)
		direction.y = lerpf(direction.y, inputdir.y, 0.08)
	
	attack_hitbox.look_at(Vector3(position.x + direction.x + 0.00001, position.y, position.z + direction.y)) #the tiny ass number is so the debugger doesn't shit itself
	
	velocity.x = move_toward(velocity.x, inputdir.x*base_speed, 0.8)
	velocity.z = move_toward(velocity.z, inputdir.y*base_speed, 0.8)
	
func attack():
	var target = attack_hitbox.get_overlapping_bodies()
	print("RATCHET ATTACK")
	#if target is in enemy group then emit signal
