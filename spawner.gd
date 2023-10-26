class_name Spawner extends Node3D

@onready var spawn_point : Node3D = $spawn_point

func _ready():
	spawn_point.global_position += Vector3.UP * GameManager.displacement_offset;

func _process(_delta):
	if !GameManager.end:
		global_position.z = GameManager.player.global_position.z + GameManager.spawn_offset;

func create_instance(prefab):
	
	rotate(Vector3.FORWARD, randi() * 360.0)
	
	var new_object : Node3D = prefab.instantiate()
	
	get_parent().add_child(new_object)
	
	new_object.global_position = spawn_point.global_position
	new_object.target_position = new_object.global_position
	new_object.target_position.y += new_object.obstacle_offset
	new_object.rotation_degrees = rotation_degrees
	new_object.scale = Vector3(1, 1, 1)
	
func spawn_object(prefab):
	create_instance(prefab)
