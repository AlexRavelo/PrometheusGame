class_name BaseBossEntity

extends BaseEnemyEntity

@export var attack_time: float = 1.0
@onready var attack_timer = $AttackTimer


func alert():
	if attack_timer.is_stopped():
		attack_timer.start(attack_time)
		
	super()
		

func _on_attack_timer_timeout():
	behavior_state = GlobalScript.EnemyState.Attack
	
	
# Bosses will behave differently from normal enemies so uhh ye lol
# Definitely is a better solution but not enough time to do code it rn

func _on_attack_bubble_body_entered(body):
	pass


func _on_attack_bubble_body_exited(body):
	pass
	
