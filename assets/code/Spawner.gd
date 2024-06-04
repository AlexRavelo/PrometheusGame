class_name Spawner
extends Node3D

@export var type : GlobalScript.EnemyType
var enemyDetails = []
var enemyAxe = preload("res://assets/code/Enemies/axe_enemy.tscn")
var enemyBeast= preload("res://assets/scenes/objects/entities/beast_enemy.tscn")
var locationID = GlobalScript.Area.First
var enemy

func spawnEnemy(type):
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
	spawnEnemy(type)
	

func _process(delta):
	
	pass
	



