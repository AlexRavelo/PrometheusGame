extends BaseAttack
#claw attack

func _ready():
	pass

func do_attack(body):
	damage = 10
	if body.is_in_group("enemies"):
		body.on_hit(self)
