class_name BaseEntity

extends CharacterBody2D

# Basic Stats
var max_health: int = 100
@export var current_health: int:
	set(value):
		clamp(value, 0, max_health)
@export var base_speed: float = 500.0 # Might want to make an int to be consistent but float might be better for calcs
@export var base_damage: int = 10 


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Functions below to be inherited by Player and Enemy entities

# Upon Entity dying
func on_death():
	pass

# Entity Attacking
func attack():
	pass

# Upon Entity getting hit
func got_hit():
	pass

