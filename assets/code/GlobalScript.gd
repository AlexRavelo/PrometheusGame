extends Node

enum Area{First, Second, Third}
enum EnemyState{Idle, Alert, Attack, Retreat}
enum EnemyType{Beast,Axe, Spear}
enum AttackProperty{Basic, Fire} # Will Add more
var LitCampfires: Dictionary
var CurrentArea

func areaGet():
	
	return Area.First
	
func _process(_delta):
	##check CurrentArea and change map/tileset accordingly
	##tried checking out changing the tilesets via function but ran into a block when it came to non homogenous tilesets
	pass
