extends Node

enum Area{First, Second, Third}
enum EnemyState{Idle, Alert, Attack, Retreat}
var CurrentArea

func areaSet():
	## or func areaSet(Area x)
	##area boss flag condiction or just call when defeating a boss/getting an item
	##CurrentArea = area.First / x
	pass

func areaGet():
	##return CurrentArea
	##not really needed since currentArea is global
	return Area.First
	
func _process(delta):
	##check CurrentArea and change map/tileset accordingly
	##tried checking out changing the tilesets via function but ran into a block when it came to non homogenous tilesets
	pass
