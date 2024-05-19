class_name BaseEnemyEntity

extends BaseEntity


# Playing with Inheretance here ignore this
const MAX_ENEMY_HEALTH = 80

# TODO: Figure out how this below variable works. Ignore for now
@export var modifier_state = 0:
	get:
		return get_modifier_state()

# Called when the node enters the scene tree for the first time.
func _ready():
	max_health = MAX_ENEMY_HEALTH
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

# Gets the modifier state of the entity from global variables
func get_modifier_state():
	# TODO: Get this function working
	return 0
