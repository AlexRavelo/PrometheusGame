class_name BaseEnemyEntity

extends BaseEntity

var nav_agent_2d: NavigationAgent2D
var enemy_id: int
var target: PlayerEntity = null
@export var behaviorState: int = 0

# TODO: Figure out how this below variable works. Ignore for now
@export var modifier_state: int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	modifier_state = get_modifier_state()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


# Gets the modifier state of the entity from global variables
func get_modifier_state():
	# TODO: Get this function working
	return 0
