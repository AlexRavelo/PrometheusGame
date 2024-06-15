class_name PlayerEntity

extends BaseEntity


var pause_menu = preload("res://assets/scenes/Menus/PauseMenu.tscn")

@onready var sprite = $Sprite3D
@onready var cooldown = $"Attack Cooldown"
@onready var animation_tree = $AnimationTree
@onready var animation_player = $AnimationPlayer
@onready var burn_timer = $BurnTimer

@export var state : States = States.NEUTRAL
@export var RollCooldown: float = 0.5
@export var ClawAttackCooldown: float = 0.25
@export var FireAttackCooldown: float = 0.5
@export var isGravity = true # TODO: add this to baseentity whenever i'm sure that there'll be no conflicts
@export var isBurned = false
@export var burnTime = 3.0


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
	if isBurned:
		set_health(current_health - 1)
	if isGravity: # TODO: add this to baseentity whenever i'm sure that there'll be no conflicts
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
	
	if Input.is_action_just_pressed("Pause"):
		var pause = pause_menu.instantiate()
		add_child(pause)
		get_tree().paused = true
	
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
		direction.x = lerpf(direction.x, inputdir.x, 0.05)
		direction.y = lerpf(direction.y, inputdir.y, 0.05)
		anim_state.travel("Run")
		
	else:
		anim_state.travel("Idle")
	animation_tree.set("parameters/Idle/blend_position", direction.y)
	animation_tree.set("parameters/Run/blend_position", direction.y)
	
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
				anim_state.travel("ClawAttack")
				animation_tree.set("parameters/ClawAttack/blend_position", direction.y)
			AttackSelect.Fire:
				anim_state.travel("FireAttack")
	else:
		state = States.NEUTRAL


func state_rolling(): #Rolling State: Like attack but simpler
	if cooldown.time_left <= 0:
		direction = Input.get_vector("Left","Right", "Up", "Down")
		# Direction is usually interpolated to make it smooth, but this needs to
		# be precise.
		velocity = Vector3.ZERO
		cooldown.start(RollCooldown)
		anim_state.travel("Roll")
		print("Ratchet ROLL")
	else:
		state = States.NEUTRAL

func attack_direction(): 
	self.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))

func on_hit(incoming_attack):
	super(incoming_attack)
	# Plays the hit flash effect so we know we're taking damage
	sprite.material_override.set_shader_parameter("active",true)
	await get_tree().create_timer(0.1).timeout 
	sprite.material_override.set_shader_parameter("active",false)
	
func get_burned():
	isBurned = true
	sprite.modulate = Color8(224, 87, 0)
	burn_timer.start(burnTime)
	


func on_death():
	print("FUCK IM DEAD")


func _on_burn_timer_timeout():
	isBurned = false
	sprite.modulate = Color(1,1,1)
