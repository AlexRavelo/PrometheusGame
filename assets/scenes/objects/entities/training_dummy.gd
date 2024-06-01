extends BaseEntity

class_name Training_Dummy

@onready var damage_label = $Label3D

func on_hit(damage):
	damage_label.text = str(damage)
