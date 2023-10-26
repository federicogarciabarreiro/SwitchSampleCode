class_name PipeController extends CSGCombiner3D

var v3_rotate : Vector3 = Vector3.FORWARD
var intensity_rotate : float = 1.0
	
func _process(delta):
	if !GameManager.paused:
		if !GameManager.end:
			global_position = GameManager.player.global_position
		
		rotate(v3_rotate.normalized(), intensity_rotate * delta)
