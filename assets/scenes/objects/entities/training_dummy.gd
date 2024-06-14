extends BaseEntity

class_name Training_Dummy

@onready var damage_label = $Label3D
@onready var sprite := $Sprite3D

var current_dps = 0
var DamageNum = preload("res://assets/scenes/test_scenes/damagenumbers.tscn")

func on_hit(attack):
	current_dps += attack.damage
	damage_label.text = str(current_dps)
	var attack_number = DamageNum.instantiate()
	add_child(attack_number)
	attack_number.play_float(attack.damage)
	sprite.material_override.set_shader_parameter("active",true)
	await get_tree().create_timer(0.1).timeout 
	sprite.material_override.set_shader_parameter("active",false)

func _on_dps_reset_timeout():
	current_dps = 0
	damage_label.text = "0"
