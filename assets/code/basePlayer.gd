class_name PlayerEntity

extends BaseEntity

var Attack1 = preload("res://assets/scenes/Attack1.tscn")

@onready var cooldown = $"Attack Cooldown"
@onready var attack_hitbox = $AttackHitbox
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer

@export var Attack1coold: float = 0.25

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	animation_tree.set("parameters/Idle/blend_position", direction)
	
	if !is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("Attack"):
		attack()
	
	debug_commands()#REMOVE THIS FUNCTION FOR FINAL RELEASE !!
	
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
	
	attack_hitbox.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	
	velocity.x = move_toward(velocity.x, inputdir.x*base_speed, 0.8)
	velocity.z = move_toward(velocity.z, inputdir.y*base_speed, 0.8)
	
func attack(): #probably going to rename for different attacks
	#everything below is heavily in progress LOL
	if (cooldown.time_left <= 0):
		print("Ratchet ATTACK")
		cooldown.wait_time = Attack1coold
		cooldown.start()
		@warning_ignore("shadowed_variable") #remove later after renaming attack()
		var attack = Attack1.instantiate()
		add_child(attack)
		attack.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
		await get_tree().create_timer(0.2).timeout #kills hitbox after 0.2 seconds
		attack.queue_free()
	else:
		print("no attack :(")
		print("cooldown left = ", cooldown.time_left)
	
func _ready():
	current_health = 99
	print(current_health)
	
func on_death():
	print("FUCK IM DEAD")
