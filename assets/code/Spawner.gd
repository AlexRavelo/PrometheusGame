class_name Spawner
extends Node3D

@export var type : GlobalScript.EnemyType
var enemyDetails = []
var enemyAxe = preload("res://assets/code/Enemies/axe_enemy.tscn")
#var locationID = GlobalScript.CurrentArea TODO: Uncomment and delete below when we start using the setArea() function
var locationID = GlobalScript.Area.First
var enemy


func spawnEnemy(type):
	match locationID: 
		0:
			if(type == 0):
				enemy = enemyAxe.instantiate()
				enemy.global_position = Vector3.ZERO
				add_child(enemy)
			else:  #you get the gist
				pass
			
		1:
			pass
		
		2:
			pass


#TODO: NEED HELP WITH THIS, VisibleOnScreenNotifier3D doesn't seem to work on afaik. Was thinking about binding it to the camera areas 
#func OnCameraExit():
	##destroy enemy object and store stats
	#enemyDetails = []
		#enemy.queue_free()
	#else:
		#print("Enemy Defeated")
		#
#func OnCameraReEnter():
	#spawnEnemy()
	#
	#pass
	
func _ready():
	spawnEnemy(type)
	

func _process(delta):
	
	pass
	



