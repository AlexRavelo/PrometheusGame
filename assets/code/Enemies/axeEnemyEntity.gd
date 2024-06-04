extends BaseEnemyEntity

class_name AxeEnemyEntity

@onready var n_agent = $NavigationAgent3D
@onready var detection = $DetectionBubble/CollisionShape3D
@onready var attk_bubble = $AttackBubble
@onready var anim = $AnimationPlayer
@onready var hitbox = $AttackBubble/Hitbox/CollisionShape3d



# Called when the node enters the scene tree for the first time.
func _ready():
	nav_agent = n_agent
	detection_bubble = detection
	attack_hitbox = hitbox
	attack_bubble = attk_bubble
	enemy_id = 100
	super()

func attack(): # TODO: refine this later
	nav_agent.set_velocity(Vector3.ZERO)
<<<<<<< Updated upstream
	anim.play("attack")


func _on_detection_bubble_body_entered(body):
	if(behavior_state != GlobalScript.EnemyState.Attack):
		behavior_state = GlobalScript.EnemyState.Alert
	target = body



func _on_attack_bubble_body_entered(body):
	behavior_state = GlobalScript.EnemyState.Attack


func _on_hitbox_body_entered(body):
	if body is PlayerEntity:
		body.on_hit(base_damage)


func _on_attack_bubble_body_exited(body):
	if(body == target): # TODO: When animations are implemented make sure this doesnt happen before the animation finishes
		behavior_state = GlobalScript.EnemyState.Alert
=======
	super();

>>>>>>> Stashed changes
