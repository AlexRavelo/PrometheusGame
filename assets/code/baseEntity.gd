class_name BaseEntity

extends CharacterBody3D

# Basic Stats
var max_health: int = 100

var direction := Vector2(0, 1)
var gravity := 10

@export var current_health: int = 100
@export var base_speed: float = 3.0 # Might want to make an int to be consistent but float might be better for calcs
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
	self.queue_free()

# Entity Attacking
func attack():
	# This function will likely be empty at this level because each enemy attacks differently
	pass
	
func set_health(health):
	current_health = clamp(health, 0, 100)

# Upon Entity getting hit
func on_hit(damage):
	set_health(current_health - damage)
	print(current_health)
	
	if current_health <= 0:
		self.on_death()
	


func load_sprite():
	pass

