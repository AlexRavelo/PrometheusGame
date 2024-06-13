extends BaseAttack
#claw attack

func do_attack(body):
	if body.is_in_group("enemies"):
		body.on_hit(self)
		enemy_hit = true
