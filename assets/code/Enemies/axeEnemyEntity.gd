class_name AxeEnemyEntity

extends BaseEnemyEntity

@onready var nav_agent = $NavigationAgent3D

const SPEED = 3.0

func _physics_process(delta):
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * base_speed
	
	nav_agent.set_velocity(new_velocity)

func update_target_location(target_location):
	nav_agent.target_position = target_location


# Called when the node enters the scene tree for the first time.
func _ready():
	base_speed = SPEED
	super()

func attack():
	pass

func _on_navigation_agent_3d_target_reached():
	attack()
	print("lol!")


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	print("safe:")
	velocity = velocity.move_toward(safe_velocity, .35)
	move_and_slide()
