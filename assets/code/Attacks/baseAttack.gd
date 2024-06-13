class_name BaseAttack

extends Area3D

@export var damage: int
@export var knockback: Vector3 # Implement this later
@export var hitsound: AudioStreamPlayer3D
@export var whiffsound: AudioStreamPlayer3D

var attack_property: GlobalScript.AttackProperty = GlobalScript.AttackProperty.Basic

#Did we hit an enemy?
var enemy_hit = false
#The sound that we're going to use
var picked_sound: AudioStreamPlayer3D

func _on_body_entered(body):
	call("do_attack",body)

#Determines if we're going to play a hitsound or not
func handle_hitsound():
	picked_sound = whiffsound
	if enemy_hit:
		picked_sound = hitsound
	if picked_sound:
		picked_sound.play()

