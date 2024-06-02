extends BaseEntity

class_name Training_Dummy

@onready var damage_label = $Label3D

var current_dps = 0
var DamageNum = preload("res://assets/scenes/test_scenes/damagenumbers.tscn")

func on_hit(attack):
	current_dps += attack.damage
	damage_label.text = str(current_dps)
	var attack_number = DamageNum.instantiate()
	add_child(attack_number)
	attack_number.play_float(attack.damage)

func _on_dps_reset_timeout():
	current_dps = 0
	damage_label.text = "0"
