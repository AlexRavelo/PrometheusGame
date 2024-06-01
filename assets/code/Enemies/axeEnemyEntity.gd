class_name AxeEnemyEntity

extends BaseEnemyEntity



# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_id = 101
	super()
	
	
func attack():
	nav_agent.set_velocity(Vector3.ZERO)
	super();
