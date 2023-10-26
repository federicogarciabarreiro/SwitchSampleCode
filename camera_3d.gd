class_name CustomCamera extends Camera3D

var target_offset : float = 0.0
var follow_offset : int = 4
var delta_intensity : float = 5.0

func _ready():
	target_offset = global_position.z
	top_level = true

var lerp_value : float = 0
func _process(delta):
	if !GameManager.end:
		if GameManager.player_body != null:
			global_position.z = get_parent().global_position.z + target_offset
			
			var current_look_target_position : Vector3 = get_parent().global_position 
			
			var sign_y : float = _get_sign(GameManager.player_body.global_position.y,get_parent().global_position.y)
			var sign_x : float = _get_sign(GameManager.player_body.global_position.x,get_parent().global_position.x)
			
			lerp_value += delta * delta_intensity
			
			current_look_target_position.y = lerp(current_look_target_position.y,(sign_y * follow_offset),lerp_value)
			current_look_target_position.x = lerp(current_look_target_position.x,(sign_x * follow_offset),lerp_value)
	
func _get_sign(go_position, to_position) -> float:
	var dir_value = go_position - to_position
	var dir_sign = 0
	
	if dir_value > 0:
		dir_sign = 1
	elif dir_value < 0:
		dir_sign = -1
	else:
		dir_sign = 0
	
	return dir_sign
