class_name PlayerEntity

extends BaseEntity



@onready var sprite = $Sprite3D
@onready var cooldown = $"Attack Cooldown"
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer

@export var state : States = States.NEUTRAL
@export var RollCooldown: float = 0.5
@export var ClawAttackCooldown: float = 0.25
@export var FireAttackCooldown: float = 0.5

var anim_state
var attack_selection : AttackSelect
var Attack1 = preload("res://assets/scenes/Attacks/Attack1.tscn")
var Attack2 = preload("res://assets/scenes/Attacks/Attack2.tscn")

enum States{
	NEUTRAL,
	ATTACKING,
	ROLLING,
}

enum AttackSelect{
	Claw,
	Fire,
}

func _ready():
	anim_state = animation_tree["parameters/playback"]
	control = true
	lockdir = false
	

func _process(delta):
	if !is_on_floor(): #Gravity
		velocity.y -= gravity * delta
	
#region State Code
	match state:
		States.NEUTRAL:
			state_neutral()
		States.ATTACKING:
			state_attacking()
		States.ROLLING:
			state_rolling()
#endregion
	
	debug_commands()#REMOVE THIS FUNCTION FOR FINAL RELEASE !!
	move_and_slide()


func debug_commands():
	if Input.is_key_pressed(KEY_R): #in case you fall and fucking die, DELETE LATER
		get_tree().reload_current_scene()


func state_neutral(): # Neutral State: Idle, Running, ETC
#region Input Code
	var inputdir = Vector2(0, 0)
	if control: 
		inputdir = Input.get_vector("Left","Right", "Up", "Down")
		if Input.is_action_just_pressed("Roll"):
			state = States.ROLLING
		if Input.is_action_just_pressed("ClawAttack"):
			attack_selection = AttackSelect.Claw
			state = States.ATTACKING
		if Input.is_action_just_pressed("FireAttack"):
			attack_selection = AttackSelect.Fire
			state = States.ATTACKING
	else:
		inputdir = Vector2(0, 0)
#endregion 


#region Direction Handling
	if inputdir and !lockdir:
		direction.x = lerpf(direction.x, inputdir.x, 0.09)
		direction.y = lerpf(direction.y, inputdir.y, 0.09)
	animation_tree.set("parameters/Idle/blend_position", direction.y)
	if direction.x < 0:
		sprite.flip_h = true
	else: 
		sprite.flip_h = false
#endregion

#region Movement Code
	velocity.x = move_toward(velocity.x, inputdir.x*base_speed, friction)
	velocity.z = move_toward(velocity.z, inputdir.y*base_speed, friction)
#endregion


func state_attacking(): #Attacking State: Regular Attack Handling.
	if cooldown.time_left <= 0:
		velocity = Vector3.ZERO
		cooldown.start(ClawAttackCooldown)
		
		match attack_selection:
			AttackSelect.Claw:
				anim_state.travel("AttackFront")
			AttackSelect.Fire:
				anim_state.travel("FireAttack")
			
		print("Ratchet ATTACK")
	else:
		state = States.NEUTRAL


func state_rolling(): # TODO: Rolling State for dodging.
	if cooldown.time_left <= 0:
		velocity = Vector3.ZERO
		cooldown.start(RollCooldown)
		anim_state.travel("Roll")
		print("Ratchet ROLL")
	else:
		state = States.NEUTRAL


func claw_attack(): 
	var attack = Attack1.instantiate()
	add_child(attack)
	attack.damage = base_damage
	attack.knockback = Vector3(0,0,0) # TODO CHANGE LATER
	attack.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	await get_tree().create_timer(0.2).timeout
	attack.queue_free()
	#individual attack properties are located in their respective .gd scripts
	
func fire_attack():
	var attack = Attack2.instantiate()
	add_child(attack)
	attack.damage = base_damage
	attack.knockback = Vector3(0,0,0) # TODO CHANGE LATER
	attack.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	await get_tree().create_timer(0.5).timeout
	attack.queue_free()

func on_death():
	print("FUCK IM DEAD")
