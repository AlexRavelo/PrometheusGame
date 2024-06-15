extends CharacterBody3D


@onready var sprite = $Sprite3D
@export var active: bool = false
@export var spearId: int

func on_hit(attack):
	if attack.attack_property == GlobalScript.AttackProperty.Fire:
		self.queue_free()

func _process(delta):
	handlesprite()
	
	
func handlesprite():
	if active:
		sprite.visible = true
	else:
		sprite.visible = false


func _on_pickup_range_body_entered(body):
	if body is SpearEnemyEntity and spearId == body.enemy_id and active == true:
		body.pickupSpear()
