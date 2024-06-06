extends BaseAttack
#fire attack

func _ready():
	attack_property = GlobalScript.AttackProperty.Fire

func do_attack(body):
	if body.is_in_group("enemies"):
		body.on_hit(self)
