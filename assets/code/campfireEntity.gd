class_name CampfireEntity

extends Node3D

@export var id: int
@export var isLit: bool
@export var canSave: bool = false

@onready var fire_particle = $"fire particle"

func _init(id = 0):
	self.id = id

# Called when the node enters the scene tree for the first time.
func _ready():
	isLit = id in GlobalScript.LitCampfires and GlobalScript.LitCampfires[id] == true
	handle_sprite()
	
func _process(delta):
	if Input.is_key_pressed(KEY_SPACE) and canSave and isLit:
		print("Saved!")

func on_hit(attack):
	if attack.attack_property == GlobalScript.AttackProperty.Fire and not isLit:
		isLit = true
		handle_sprite()
		GlobalScript.LitCampfires[id] = true

func handle_sprite(): # Used for debug purposes
	fire_particle.emitting = isLit

func _on_interaction_range_body_entered(body):
	if body is PlayerEntity:
		canSave = true


func _on_interaction_range_body_exited(body):
	if body is PlayerEntity:
		canSave = false
