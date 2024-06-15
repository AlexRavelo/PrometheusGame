extends BasicEnemyAttack

@onready var spear = $SpearProp
@onready var landing_timer = $LandingTimer
@export var landingtime: float = 1.6
@export var speed = 5.0
@export var travelState: bool = false
# Called when the node enters the scene tree for the first time.

func _physics_process(delta):
	if travelState:
		global_transform.origin -= transform.basis.z.normalized() * speed * delta;

func spear_throw():
	landing_timer.start()
	travelState = true


func _on_landing_timer_timeout():
	travelState = false
	spear.active = true
