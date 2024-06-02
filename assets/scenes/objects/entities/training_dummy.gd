extends BaseEntity

class_name Training_Dummy

@onready var damage_label = $Label3D

func on_hit(attack):
	damage_label.text = str(attack.damage)
