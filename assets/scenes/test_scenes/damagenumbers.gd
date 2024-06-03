extends Label3D

@onready var animplayer = $AnimationPlayer

#region Floats upwards & sways randomly from left/right
func play_float(damage):
	var anim = animplayer.get_animation("float")
	for i in anim.track_get_key_count(0):
		if i == 0:
			continue
		var swayval = Vector3(randf_range(-0.5, 0.5), anim.track_get_key_value(0, i).y, 0)
		anim.track_set_key_value(0, i, swayval)
	
	text = str(damage)
	animplayer.play("float")
#endregion 

func free_queue():
	queue_free()
