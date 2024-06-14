class_name BaseEnemyEntity

extends BaseEntity


@onready var nav_agent = $NavigationAgent3D
@onready var detection_bubble = $DetectionBubble/CollisionShape3D
@onready var attack_bubble = $AttackBubble
@onready var animation_player = $AnimationPlayer
@onready var sprite = $Sprite3D
@onready var target_position = global_transform.origin

var enemy_id: int
var target: CharacterBody3D = null


@export var modifier_state: GlobalScript.Area
@export var behavior_state: GlobalScript.EnemyState

#func _init(health: int = 100, id: int = 0):
	#max_health = health
	#current_health = set_health(health)
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	control = true
	modifier_state = get_modifier_state()
	behavior_state = GlobalScript.EnemyState.Idle
	
	set_health(max_health)
	
func update_target_location(target_location):
	nav_agent.target_position = target_location
	
func attack():
	pass
	
func idle():
	pass
	

func _physics_process(delta):
	if control:
		match behavior_state:
			GlobalScript.EnemyState.Idle:
				idle()
			GlobalScript.EnemyState.Alert:
				alert()
			GlobalScript.EnemyState.Attack:
				attack()
			GlobalScript.EnemyState.Retreat:
				retreat()
				
		handle_sprite()
	

func retreat():
	update_target_location(target.global_transform.origin)
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = ((next_location - global_transform.origin).normalized() * base_speed) * Vector3(-1,-1,-1)
	
	nav_agent.set_velocity(new_velocity)
	
func alert():
	handle_movement(target)
	
func handle_movement(body):
	handle_direction(body)
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - global_transform.origin).normalized() * base_speed
	
	
	nav_agent.set_velocity(new_velocity)
		
func handle_random_movement():
	target_position = Vector3(global_transform.origin.x - randf_range(-32, 32), global_transform.origin.y, global_transform.origin.z - randf_range(-32, 32))
	update_target_location(target_position)
	
	
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - global_transform.origin).normalized() * base_speed
	
	
	nav_agent.set_velocity(new_velocity)
	
	
		
func handle_sprite():
	if not lockdir:
		if direction.x < 0:
			sprite.flip_h = true
		else: 
			sprite.flip_h = false

func handle_direction(body):
	if not lockdir:
		update_target_location(body.global_transform.origin)
		var current_location = global_transform.origin
		var target_position = nav_agent.target_position
	
	
		direction.x = clamp(lerpf(direction.x, (target_position.x - current_location.x), 0.09), -1, 1)
		direction.y = clamp(lerpf(direction.y, (target_position.z - current_location.z), 0.09), -1, 1)
	

func _on_navigation_agent_3d_target_reached():
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .35)
	move_and_slide()

# Gets the modifier state of the entity from global variables
func get_modifier_state():
	return GlobalScript.areaGet()
	
func _on_detection_bubble_body_entered(body):
	if control:
		if body is PlayerEntity:
			if(behavior_state != GlobalScript.EnemyState.Attack):
				behavior_state = GlobalScript.EnemyState.Alert
			target = body
			
	
func _on_attack_bubble_body_entered(body):
	if body is PlayerEntity:
		behavior_state = GlobalScript.EnemyState.Attack


func _on_attack_bubble_body_exited(body):
	if body is PlayerEntity: # TODO: When animations are implemented make sure this doesnt happen before the animation finishes
		behavior_state = GlobalScript.EnemyState.Alert
	
