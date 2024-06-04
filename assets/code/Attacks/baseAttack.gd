class_name BaseAttack

extends Area3D

@export var damage: int
@export var knockback: Vector3 # Implement this later
var attack_property: GlobalScript.AttackProperty = GlobalScript.AttackProperty.Basic


func _on_body_entered(body):
	call("do_attack",body)


func finish_attack():
	self.queue_free()
