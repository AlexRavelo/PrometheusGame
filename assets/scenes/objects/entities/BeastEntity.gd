extends BaseEnemyEntity

class_name BeastEntity

@onready var n_agent = $NavigationAgent3D
@onready var detection = $DetectionBubble/CollisionShape3D
@onready var attk_bubble = $AttackBubble
@onready var anim = $AnimationPlaye
@onready var animation_tree = $AnimationTree
@onready var hitbox = $AttackBubble/Hitbox/CollisionShape3d
@onready var timer = $Timer
@onready var sprite = $Sprite3D

var anim_state

# Called when the node enters the scene tree for the first time.
func _ready():
	nav_agent = n_agent
	detection_bubble = detection
	attack_hitbox = hitbox
	attack_bubble = attk_bubble
	enemy_id = 101
	anim_state = animation_tree["parameters/playback"]
	super()

func _process(delta):
	#region Direction Handling
	animation_tree.set("parameters/Idle/blend_position", direction.y) # TODO: make it so direction is actually updated
	animation_tree.set("parameters/Attack/blend_position", direction.y)  # TODO: figure out if you can change these all at once instead of
	animation_tree.set("parameters/Run/blend_position", direction.y) # doing it one by one
	if direction.x < 0:
		sprite.flip_h = true
	else: 
		sprite.flip_h = false
	#endregion

func attack(): # TODO: refine this later
	anim_state.travel("Attack")


func _on_detection_bubble_body_entered(body):
	if(behavior_state != GlobalScript.EnemyState.Attack):
		behavior_state = GlobalScript.EnemyState.Alert
	target = body

func on_hit(damage):
	super(damage)
	behavior_state = GlobalScript.EnemyState.Retreat
	# If the beast's health is more than a 4th I want it to still be gutsy enough to keep at it
	# Otherwise, it keeps running
	if(current_health >= (max_health / 4)):
		timer.start(3.0)

func _on_attack_bubble_body_entered(body):
	behavior_state = GlobalScript.EnemyState.Attack


func _on_hitbox_body_entered(body):
	if body is PlayerEntity:
		body.on_hit(base_damage)


func _on_attack_bubble_body_exited(body):
	if(body == target): # TODO: When animations are implemented make sure this doesnt happen before the animation finishes
		behavior_state = GlobalScript.EnemyState.Alert


func _on_timer_timeout():
	behavior_state = GlobalScript.EnemyState.Alert
