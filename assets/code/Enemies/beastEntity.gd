class_name BeastEntity

extends BaseEnemyEntity

@onready var lunge_timer = $LungeTimer
@onready var anim_tree = $AnimationTree
@export var lunge_strength: float = 10.0
@onready var bite_attack_entity = $BasicEnemyAttack


# Called when the node enters the scene tree for the first time.
func _ready():
	anim_state = anim_tree["parameters/playback"]
	enemy_id = 102
	super()
	

func idle():
	anim_state.travel("Idle")
	anim_tree.set("parameters/Idle/blend_position", direction.y)
	
	
	
func alert():
	if control:
		if lunge_timer.is_stopped():
			lunge_timer.start(randf_range(0.7, 1.5))
		anim_state.travel("Run")
		anim_tree.set("parameters/Run/blend_position", direction.y)
		super()
	
	
func attack():
	if control:
		handle_direction(target)
		anim_state.travel("Attack")
		anim_tree.set("parameters/Run/blend_position", direction.y)
	
func bite_attack():
	bite_attack_entity.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	
	
func apply_velocity():
	applyvelocity(Vector3(lunge_strength, 0, 0), true)

func _on_lunge_timer_timeout():
	if behavior_state == GlobalScript.EnemyState.Alert:
		behavior_state = GlobalScript.EnemyState.Attack
	
func _on_attack_bubble_body_entered(body):
	if behavior_state == GlobalScript.EnemyState.Alert:
		lunge_strength = 3.0
		super(body)
		

func _on_attack_bubble_body_exited(body):
		lunge_strength = 7.0


