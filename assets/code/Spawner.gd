class_name Spawner
extends Node3D
@export var spawn_enemy : bool = true
@export var type : GlobalScript.EnemyType

var enemyDetails = []
#var enemyAxe = preload("res://assets/code/Enemies/axe_enemy.tscn")
var enemyBeast= preload("res://assets/scenes/objects/entities/beast_enemy.tscn")
var locationID = GlobalScript.Area.First
var enemy

func listener_entry():
	spawnEnemy(GlobalScript.EnemyType.Beast)

func listener_exit():
	var enemy_list = get_children()
	for n in enemy_list:
		n.queue_free()


func spawnEnemy(type):
	print("AHHH")
	if spawn_enemy == true:
		match type: 
			0:
				enemy = enemyBeast.instantiate()
				enemy.global_position = Vector3.ZERO
				add_child(enemy)
				
			1:
				pass
			
			2:
				pass


func _ready():
	#removed, as this will be triggered via signal now.
	#spawnEnemy(type)
	get_parent().connect("on_player_entry", listener_entry)
	get_parent().connect("on_player_exit", listener_exit)

func _process(delta):
	pass
	



