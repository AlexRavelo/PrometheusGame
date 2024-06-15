class_name BasicEnemyAttack

extends BaseAttack

func do_attack(body):
	if body is PlayerEntity:
		body.on_hit(self)
		enemy_hit = true
