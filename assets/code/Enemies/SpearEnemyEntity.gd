class_name SpearEnemyEntity

extends BaseEnemyEntity

# Called when the node enters the scene tree for the first time.

enum AttackState{Melee, Ranged, Pickup}
var attack_state: AttackState
var player_target: PlayerEntity = null
@onready var throw_timer = $ThrowTimer
@onready var stab_attack_entity = $BasicEnemyAttack
var spear


var throw_attack_entity = preload("res://assets/scenes/Attacks/spear_throw_attack.tscn")


func _init(id = 00):
	enemy_id = id

func _ready():
	attack_state = AttackState.Ranged
	super()
	
func attack():
	if control:
		match attack_state:
			AttackState.Melee:
				stab_attack()
			AttackState.Ranged:
				throw_attack()
			AttackState.Pickup:
				goto_spear()
	
func stab_attack():
	handle_direction(target)
	stab_attack_entity.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	
func throw_attack():
	print("hrnnng, spear... THROW!")
	handle_direction(target)
	var thrown_attack = throw_attack_entity.instantiate()
	add_child(thrown_attack)
	spear = thrown_attack.spear
	spear.spearId = enemy_id
	thrown_attack.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	thrown_attack.spear_throw()
	attack_state = AttackState.Pickup
	
func goto_spear():
	handle_movement(spear)
	
func pickupSpear():
	spear = null
	pass
	
func alert():
	if control:
		if throw_timer.is_stopped():
			throw_timer.start(randf_range(0.7, 1.5))
	super()
	


func _on_attack_bubble_body_entered(body):
	if body is PlayerEntity and attack_state != AttackState.Pickup:
		attack_state = AttackState.Melee
	super(body)

func _on_attack_bubble_body_exited(body):
	if body is PlayerEntity and attack_state != AttackState.Pickup:
		attack_state = AttackState.Ranged
		super(body)

func _on_throw_timer_timeout():
	behavior_state = GlobalScript.EnemyState.Attack
