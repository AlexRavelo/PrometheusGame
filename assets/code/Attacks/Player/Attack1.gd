extends BaseAttack
#claw attack

func _ready():
	set_visible(false) #this exists because you cannot hide the hitbox in the editor
	#go ahead try it and run the game

func do_attack(body):
	damage = 10
	if body.is_in_group("enemies"):
		body.on_hit(self)
