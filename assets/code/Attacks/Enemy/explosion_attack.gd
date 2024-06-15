class_name ExplosionAttack

extends BasicEnemyAttack

@onready var sprite = $AnimatedSprite3D

func _ready():
	attack_property = GlobalScript.AttackProperty.Fire
	sprite.visible = false
	
