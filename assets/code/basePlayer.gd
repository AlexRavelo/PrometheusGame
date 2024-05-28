class_name PlayerEntity

extends BaseEntity

@onready var sprite = $Sprite3D
@onready var attack_hitbox = $AttackHitbox
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("Attack"):
		attack()
	
	if Input.is_key_pressed(KEY_R): #in case you fall and fucking die, DELETE LATER
		get_tree().reload_current_scene()
		
	move_input()
	
	move_and_slide()

func move_input():
	var inputdir = Input.get_vector("Left","Right", "Up", "Down")
	if inputdir:
		direction.x = lerpf(direction.x, inputdir.x, 0.09)
		direction.y = lerpf(direction.y, inputdir.y, 0.09)
	
	attack_hitbox.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	
	if direction.x < 0:
		sprite.flip_h = true
	else:
		sprite.flip_h = false
	if direction.y < 0:
		animation_tree.set("parameters/FrontBack/blend_amount",1)
	else:
		animation_tree.set("parameters/FrontBack/blend_amount",0)
		
	velocity.x = move_toward(velocity.x, inputdir.x*base_speed, 0.8)
	velocity.z = move_toward(velocity.z, inputdir.y*base_speed, 0.8)
	
func attack():
	var target = attack_hitbox.get_overlapping_bodies()
	print("RATCHET ATTACK")
