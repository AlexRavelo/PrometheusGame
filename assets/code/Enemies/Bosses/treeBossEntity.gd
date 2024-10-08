class_name treeBossEntity

extends BaseBossEntity

enum AttackStates{Beam, Fireball, Spawn}

@export var attack_state: AttackStates
@onready var beam_attack_entity = $BeamAttack
@onready var anim_tree = $AnimationTree
var blendpoint = Vector2(0,0)
var adds_spawned: bool = false
var fireball_entity = preload("res://assets/scenes/Attacks/TreeFireballAttack.tscn")
var tree_add_entity = preload("res://assets/scenes/objects/entities/tree_stump_enemy.tscn")

func _ready():
	beam_attack_entity.monitoring = false
	attack_state = AttackStates.Beam
	
func alert():
	if control:
		anim_state = anim_tree["parameters/playback"]
		anim_state.travel("Neutral")
		super()


func _process(delta):
	blendpoint.x = move_toward(blendpoint.x, velocity.x, 0.25)
	blendpoint.y = move_toward(blendpoint.y, velocity.z, 0.25)
	anim_tree.set("parameters/Neutral/blend_position", blendpoint)

func attack():
	if control:
		target_position = global_position
		match attack_state:
			AttackStates.Beam:
				anim_state.travel("BeamAttack")
			AttackStates.Fireball:
				fireball_attack()
			AttackStates.Spawn:
				spawn_adds()
			
func beam_attack():
	handle_direction(target)
	nav_agent.set_velocity(Vector3.ZERO)
	beam_attack_entity.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	
	attack_state = change_attack_behavior()
	
func fireball_attack():
	var num_fireballs: int = min((2 * get_n()), 6)
	
	for i in range(num_fireballs):
		
		var temp_direction = Vector3(coinflipYipee(), 0, coinflipYipee())
		var distance = randf_range(1.5, 6.0)
		
		var attack = fireball_entity.instantiate()
		attack.position = Vector3(position.x + (temp_direction.x * distance), position.y, position.z + (temp_direction.z * distance))
		behavior_state = GlobalScript.EnemyState.Alert
		attack.top_level = true
		
		add_child(attack)
		attack.start_timer()
		
		
		# Idea:
		# Get random distance and direction of fireballs
		# Then shoot em out
		# Reuse this for adds spawn
	await get_tree().create_timer(1.0).timeout
	attack_state = change_attack_behavior()
	control = true
	
func spawn_adds():
	control = false
	
	for i in range(3):
		var temp_direction = Vector3(coinflipYipee(), 0, coinflipYipee())
		var distance = randf_range(1.5, 6.0)
		
		var spawning_add = tree_add_entity.instantiate()
		
		spawning_add.position = Vector3(position.x + (temp_direction.x * distance), position.y, position.z + (temp_direction.z * distance))
		
		add_child(spawning_add)
		spawning_add.top_level = true
		spawning_add.target = target
		spawning_add.behavior_state = GlobalScript.EnemyState.Alert
	
	await get_tree().create_timer(1.0).timeout
	attack_state = change_attack_behavior()
	behavior_state = GlobalScript.EnemyState.Alert
	control = true
	

func coinflipYipee():
	var coinflip = randi_range(0, 1)
	if coinflip == 0:
		return -1.0
	return 1.0

func change_attack_behavior():
	if(get_n() >= 3) and not adds_spawned:
		adds_spawned = true
		return AttackStates.Spawn
	match attack_state:
		AttackStates.Beam:
			return AttackStates.Fireball
		AttackStates.Fireball:
			return AttackStates.Beam
		AttackStates.Spawn:
			var coinflip = randi_range(0, 1)
			if coinflip == 0:
				return AttackStates.Beam
			else:
				return AttackStates.Fireball
				


func _on_attack_timer_timeout():
	behavior_state = GlobalScript.EnemyState.Attack
