class_name treeBossEntity

extends BaseBossEntity

enum AttackStates{Beam, Fireball, Spawn}

@export var attack_state: AttackStates
@onready var beam_attack_entity = $BeamAttack

func _ready():
	beam_attack_entity.monitoring = false
	attack_state = AttackStates.Beam
	
func attack():
	if control:
		match attack_state:
			AttackStates.Beam:
				beam_attack()
			AttackStates.Fireball:
				fireball_attack()
			AttackStates.Spawn:
				spawn_adds()
				
			
func beam_attack():
	control = false
	beam_attack_entity.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	# Bottom four lines will be removed when animations are added
	velocity = Vector3.ZERO
	await get_tree().create_timer(.5).timeout
	beam_attack_entity.monitoring = true
	await get_tree().create_timer(.5).timeout
	
	control = true
	
	
	behavior_state = GlobalScript.EnemyState.Alert
	#attack_state = AttackStates.Fireball
	
func fireball_attack():
	# Full health: 2 Fireballs
	# Half health: 4 Fireballs
	# Qrt health: 6 fireballs
	attack_state = AttackStates.Beam
	
func spawn_adds():
	var coinflip = randi_range(0, 1)
	if coinflip == 0:
		attack_state = AttackStates.Beam
	else:
		attack_state = AttackStates.Fireball
