class_name BeastEntity

extends BaseEnemyEntity

@onready var retreat_timer = $RetreatTimer



# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_id = 102
	super()

func on_hit(damage):
	super(damage)
	behavior_state = GlobalScript.EnemyState.Retreat
	# If the beast's health is more than a 4th I want it to still be gutsy enough to keep at it
	# Otherwise, it keeps running
	if(current_health >= (max_health / 4)):
		retreat_timer.start(3.0)

func _on_retreat_timer_timeout():
	behavior_state = GlobalScript.EnemyState.Alert
