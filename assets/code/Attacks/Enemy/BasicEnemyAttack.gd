extends BaseAttack


func do_attack(body):
	if body is PlayerEntity:
		body.on_hit(self)
