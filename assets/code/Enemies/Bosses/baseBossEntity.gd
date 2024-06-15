class_name BaseBossEntity

extends BaseEnemyEntity

@export var attack_time: float = 1.0
@onready var attack_timer = $AttackTimer


func alert():
	if attack_timer.is_stopped():
		attack_timer.start(attack_time)
		
	
func get_n():
	# Where n is an arbitrary value determined by how much health the boss has left
	# Used for if we want bosses to get more intense the lower health they have
	if current_health > ((max_health/4) * 3):
		return 1
	elif current_health > max_health/2:
		return 2
	elif current_health > max_health/4:
		return 3
	return 4
		

	
# Bosses will behave differently from normal enemies so uhh ye lol
# Definitely is a better solution but not enough time to do code it rn

func _on_attack_bubble_body_entered(body):
	pass


func _on_attack_bubble_body_exited(body):
	pass
	
