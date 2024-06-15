class_name TreeStumpEnemyEntity

extends BaseEnemyEntity


@onready var explosion_entity = $ExplosionAttack
@onready var fuse_timer = $FuseTimer
@export var fuse_time: float = 4.0
@export var speedup: float = .0045

func _ready():
	explosion_entity.damage = base_damage
	explosion_entity.knockback = Vector3(15, 0, 0)
	explosion_entity.monitoring = false
	fuse_timer.stop()
	

		
func attack():
	velocity = Vector3.ZERO
	explosion_entity.monitoring = true
	explosion_entity.sprite.visible = true
	await get_tree().create_timer(0.3).timeout # TODO: when animations happen get rid of this shit
	queue_free()
	
func alert():
	if fuse_timer.is_stopped():
		fuse_timer.start(fuse_time)
	else:
		base_speed += speedup
	
	super()
	
func _on_fuse_timer_timeout():
	behavior_state = GlobalScript.EnemyState.Attack
