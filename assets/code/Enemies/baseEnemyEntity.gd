class_name BaseEnemyEntity

extends BaseEntity

var nav_agent: NavigationAgent3D
var attack_hitbox: CollisionShape3D
var attack_bubble: Area3D
var detection_bubble: CollisionShape3D
var enemy_id: int
var target: PlayerEntity = null
@export var behaviorState: int = 0

@export var modifier_state: GlobalScript.Area
@export var behavior_state: GlobalScript.EnemyState

# Called when the node enters the scene tree for the first time.
func _ready():
	modifier_state = get_modifier_state()
	behavior_state = GlobalScript.EnemyState.Idle
	set_health(max_health)
	

func _physics_process(delta):
	match behavior_state:
		GlobalScript.EnemyState.Idle:
			idle()
		GlobalScript.EnemyState.Alert:
			alert()
		GlobalScript.EnemyState.Attack:
			attack()
	

func update_target_location(target_location):
	nav_agent.target_position = target_location
	
func attack():
	print("This is an attack!")
	
func idle():
	pass

func retreat():
	target = null
	
func alert():
	if(behavior_state == GlobalScript.EnemyState.Alert):
		update_target_location(target.global_transform.origin)
		var current_location = global_transform.origin
		attack_bubble.look_at(nav_agent.target_position, Vector3.UP, true)
		var next_location = nav_agent.get_next_path_position()
		var new_velocity = (next_location - current_location).normalized() * base_speed
		
		nav_agent.set_velocity(new_velocity)

func _on_navigation_agent_3d_target_reached():
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .35)
	move_and_slide()


# Gets the modifier state of the entity from global variables
func get_modifier_state():
	return GlobalScript.areaGet()
	
