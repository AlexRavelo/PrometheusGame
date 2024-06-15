extends Room

@onready var boss_entity = $FireTreeBoss

# Called when the node enters the scene tree for the first time.
func _on_area_3d_body_entered(body):
	super(body)
	boss_entity.control = true
