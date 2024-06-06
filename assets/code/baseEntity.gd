class_name BaseEntity

extends CharacterBody3D

# Basic Stats
var direction := Vector2(0, 1)
var gravity := 10
var current_health = 1
var anim_state

@export var control := true # Wether or not the creature can move
@export var lockdir := false # Wether or not to lock the direction of the creature
@export_range(0, 100, 1, "or_greater", "or_less") var max_health := 100
@export_range(0.0, 20.0, 0.1) var base_speed: float = 3.0 # Might want to make an int to be consistent but float might be better for calcs
@export_range(0.0, 25.0, 0.1) var base_damage: int = 10 
@export var friction := 0.8 # For use with move_toward(to: Vector3, friction)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
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
func on_hit(incoming_attack):
	set_health(current_health - incoming_attack.damage)
	print(current_health)
	applyvelocity(incoming_attack.knockback, true) #NOT WORKING YET !!
	
	if current_health <= 0:
		self.on_death()
	


func load_sprite():
	pass

# mainly for use in Animation Players
# TODO: figure out why this isn't rotating correctly, 
# forward is positive X instead of the usual negative Z
func applyvelocity(givenVelocity : Vector3, towardsDir : bool): 
	if towardsDir:
		velocity += givenVelocity.rotated(Vector3(0, 1, 0).normalized(), -direction.angle())
	else:
		velocity += givenVelocity
