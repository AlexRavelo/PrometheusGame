class_name BaseAttack

extends Area3D


func _on_body_entered(body):
	call("do_attack",body)


