extends BaseAttack


func do_attack(body):
	if body.is_in_group("enemies"):
		body.on_hit(5)
		body.applyvelocity(Vector3(0,0,0), true) #NOT WORKING YET !!