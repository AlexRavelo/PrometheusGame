class_name CampfireEntity

extends Node3D

@export var id: int
@export var isLit: bool
@export var canSave: bool = false

# TODO: rn there's two sprite3Ds, when animations come for this just use one
@onready var debug_unlit_sprite = $PLACEHOLDERUNLIT
@onready var debug_lit_sprite = $PLACEHOLDERLIT

func _init(id):
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
	if isLit:
		debug_lit_sprite.visible = true
		debug_unlit_sprite.visible = false
	else:
		debug_lit_sprite.visible = false
		debug_unlit_sprite.visible = true

func _on_interaction_range_body_entered(body):
	if body is PlayerEntity:
		canSave = true


func _on_interaction_range_body_exited(body):
	if body is PlayerEntity:
		canSave = false
