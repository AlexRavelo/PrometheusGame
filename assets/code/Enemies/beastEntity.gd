class_name BeastEntity

extends BaseEnemyEntity

@onready var lunge_timer = $LungeTimer
@onready var anim_tree = $AnimationTree



# Called when the node enters the scene tree for the first time.
func _ready():
	basic_attack = preload("res://assets/scenes/Attacks/BasicEnemyAttack.tscn")
	anim_state = anim_tree["parameters/playback"]
	enemy_id = 102
	super()
	

func idle():
	anim_state.travel("Idle")
	anim_tree.set("parameters/Idle/blend_position", direction.y)
	
	
func alert():
	if lunge_timer.is_stopped():
		lunge_timer.start(randf_range(0.5, 1.5))
		print(lunge_timer.time_left)
	anim_state.travel("Run")
	anim_tree.set("parameters/Run/blend_position", direction.y)
	super()
	
	
func attack():
	handle_direction()
	anim_state.travel("Attack")
	anim_tree.set("parameters/Run/blend_position", direction.y)
	
func bite_attack():
	var attack_direction = direction
	var bite_attack = basic_attack.instantiate()
	add_child(bite_attack)
	bite_attack.damage = base_damage
	bite_attack.knockback = Vector3(0,0,0) # TODO CHANGE LATER
	bite_attack.look_at(Vector3(position.x + attack_direction.x, position.y, position.z + attack_direction.y))
	await get_tree().create_timer(0.2).timeout
	behavior_state = GlobalScript.EnemyState.Alert
	bite_attack.queue_free()

func _on_lunge_timer_timeout():
	if behavior_state == GlobalScript.EnemyState.Alert:
		behavior_state = GlobalScript.EnemyState.Attack
	lunge_timer.stop()
