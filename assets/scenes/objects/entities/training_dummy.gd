extends BaseEntity

class_name Training_Dummy

@onready var damage_label = $Label3D

var current_dps = 0
var DamageNum = preload("res://assets/scenes/test_scenes/damagenumbers.tscn")

func on_hit(damage):
	current_dps += damage
	damage_label.text = str(current_dps)
	var attack = DamageNum.instantiate()
	add_child(attack)
	attack.play_float(damage)

func _on_dps_reset_timeout():
	current_dps = 0
	damage_label.text = "0"
