class_name CampfireEntity

@export var id: int
@export var isLit: bool

# Called when the node enters the scene tree for the first time.
func _ready():
	isLit = id in GlobalScript.LitCampfires and GlobalScript.LitCampfires[id] == true

func on_hit(attack):
	if attack.attack_property == GlobalScript.AttackProperty.Fire and not isLit:
		isLit = true
		GlobalScript.LitCampfires[id] = true
