class_name BaseAttack

extends Area3D


var damage: int
var knockback: Vector3 # Implement this later
@export var hitsound: AudioStreamPlayer
@export var whiffsound: AudioStreamPlayer

var attack_property: GlobalScript.AttackProperty = GlobalScript.AttackProperty.Basic

#Did we hit an enemy? Export for anim player
@export var enemy_hit = false
#The sound that we're going to use
var picked_sound: AudioStreamPlayer

func _on_body_entered(body):
	do_attack(body)

func do_attack(body):
	pass
	
#Determines if we're going to play a hitsound or not
func handle_hitsound():
	picked_sound = whiffsound
	if enemy_hit:
		picked_sound = hitsound
	if picked_sound:
		picked_sound.play()

