class_name TreeFireballAttack

extends BasicEnemyAttack

@onready var linger_timer = $LingerTimer

func start_timer():
	linger_timer.start(3.0)

func do_attack(body):
	if body is PlayerEntity:
		body.get_burned()
		print("get burnt dumbass lol")



func _on_linger_timer_timeout():
	self.queue_free()
