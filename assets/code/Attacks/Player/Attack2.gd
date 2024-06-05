extends BaseAttack
#fire attack

func do_attack(body):
	damage = 30
	if body.is_in_group("enemies"):
		body.on_hit(self)
