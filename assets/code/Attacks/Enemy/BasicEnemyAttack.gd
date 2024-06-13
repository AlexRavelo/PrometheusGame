extends BaseAttack


func do_attack(body):
	print(collision_layer)
	print(body.collision_layer)
	if body is PlayerEntity:
		body.on_hit(self)
		enemy_hit = true
