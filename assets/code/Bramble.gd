extends Node3D

var isLit : bool = false
@onready var debug_idle_sprite = $BrambleIdle
@onready var debug_burn_sprite = $BrambleBurn
var timer = 3

func on_hit(attack):
	if attack.attack_property == GlobalScript.AttackProperty.Fire:
		isLit = true
		handle_sprite()

func handle_sprite():
	debug_idle_sprite.visible = false
	debug_burn_sprite.visible = true

func _process(delta):
	if debug_burn_sprite.visible == true:
		await get_tree().create_timer(1.0).timeout
		queue_free()
