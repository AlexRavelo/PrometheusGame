class_name BaseAttack

extends Area3D

var damage: int
var knockback: Vector3 # Implement this later
var attack_property: GlobalScript.AttackProperty = GlobalScript.AttackProperty.Basic


func _on_body_entered(body):
	do_attack(body)

func do_attack(body):
	pass

func finish_attack():
	self.queue_free()
