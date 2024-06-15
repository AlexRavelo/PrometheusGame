class_name treeBossEntity

extends BaseBossEntity

enum AttackStates{Beam, Fireball, Spawn}

@export var attack_state: AttackStates
@onready var beam_attack_entity = $BeamAttack
@onready var anim_tree = $AnimationTree
var blendpoint = Vector2(0,0)

func _ready():
	control = true
	anim_state = anim_tree["parameters/playback"]
	beam_attack_entity.monitoring = false
	attack_state = AttackStates.Beam

func _process(delta):
	blendpoint.x = move_toward(blendpoint.x, velocity.x, 0.25)
	blendpoint.y = move_toward(blendpoint.y, velocity.z, 0.25)
	anim_tree.set("parameters/Neutral/blend_position", blendpoint)

func alert():
	anim_state.travel("Neutral")
	super()


func attack():
	if control:
		match attack_state:
			AttackStates.Beam:
				beam_attack()
			AttackStates.Fireball:
				fireball_attack()
			AttackStates.Spawn:
				spawn_adds()


func beam_attack():
	control = false
	beam_attack_entity.look_at(Vector3(position.x + direction.x, position.y, position.z + direction.y))
	anim_state.travel("BeamAttack")


func fireball_attack():
	# Full health: 2 Fireballs
	# Half health: 4 Fireballs
	# Qrt health: 6 fireballs
	attack_state = AttackStates.Beam


func spawn_adds():
	var coinflip = randi_range(0, 1)
	if coinflip == 0:
		attack_state = AttackStates.Beam
	else:
		attack_state = AttackStates.Fireball
