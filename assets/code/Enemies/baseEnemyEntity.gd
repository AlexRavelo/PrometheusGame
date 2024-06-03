class_name BaseEnemyEntity

extends BaseEntity


@onready var nav_agent = $NavigationAgent3D
@onready var detection_bubble = $DetectionBubble/CollisionShape3D
@onready var attack_bubble = $AttackBubble
@onready var animation_player = $AnimationPlayer
@onready var basic_attack = $AttackBubble/BasicEnemyAttack

var enemy_id: int
var target: PlayerEntity = null


@export var modifier_state: GlobalScript.Area
@export var behavior_state: GlobalScript.EnemyState

# Called when the node enters the scene tree for the first time.
func _ready():
	basic_attack.damage = base_damage
	modifier_state = get_modifier_state()
	behavior_state = GlobalScript.EnemyState.Idle
	
	set_health(max_health)
	
func update_target_location(target_location):
	nav_agent.target_position = target_location
	
func attack():
	animation_player.play("attack")
	
func idle():
	pass
	

func _physics_process(delta):
	match behavior_state:
		GlobalScript.EnemyState.Idle:
			idle()
		GlobalScript.EnemyState.Alert:
			alert()
		GlobalScript.EnemyState.Attack:
			attack()
		GlobalScript.EnemyState.Retreat:
			retreat()
	

func retreat():
	update_target_location(target.global_transform.origin)
	var current_location = global_transform.origin
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = ((next_location - current_location).normalized() * base_speed) * Vector3(-1,-1,-1)
	
	nav_agent.set_velocity(new_velocity)
	
func alert():
	update_target_location(target.global_transform.origin)
	var current_location = global_transform.origin
	attack_bubble.look_at(nav_agent.target_position, Vector3.UP, true)
	var next_location = nav_agent.get_next_path_position()
	var new_velocity = (next_location - current_location).normalized() * base_speed
	
	nav_agent.set_velocity(new_velocity)

	direction.x = lerpf(direction.x, next_location.x, 0.09)
	direction.y = lerpf(direction.y, next_location.y, 0.09)

func _on_navigation_agent_3d_target_reached():
	pass


func _on_navigation_agent_3d_velocity_computed(safe_velocity):
	velocity = velocity.move_toward(safe_velocity, .35)
	move_and_slide()

# Gets the modifier state of the entity from global variables
func get_modifier_state():
	return GlobalScript.areaGet()
	
func _on_detection_bubble_body_entered(body):
	if(behavior_state != GlobalScript.EnemyState.Attack):
		behavior_state = GlobalScript.EnemyState.Alert
	target = body
	
func _on_attack_bubble_body_entered(body):
	behavior_state = GlobalScript.EnemyState.Attack


func _on_attack_bubble_body_exited(body):
	if(body == target): # TODO: When animations are implemented make sure this doesnt happen before the animation finishes
		behavior_state = GlobalScript.EnemyState.Alert
	
