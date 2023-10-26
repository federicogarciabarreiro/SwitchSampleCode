class_name SpawnableObject extends Node3D

enum {Enemy, Obstacle, Powerup, Reward}

@export var speed_multiplier : float = 3.0

@export_enum("Enemy", "Obstacle", "Powerup", "Reward") var type: int = Obstacle

var delta_intensity : float = 5.0

@export var target_position : Vector3 = Vector3.ZERO
@export var obstacle_offset : float = 2.0

@onready var _area : Area3D = $Area3D

func _ready():
	_area.connect("area_entered", Callable(self, "_on_collision"))

var lerp_value : float = 0
func _process(delta):
	
	if type == Enemy:
		global_position.z += GameManager.speed * delta
		
	if type == Obstacle:
		lerp_value += delta
		position = lerp(global_position, target_position, lerp_value)
	
	if type == Powerup:
		rotate(Vector3.ONE.normalized(), 1.0)
	
	if type == Reward:
		rotate(Vector3.UP.normalized(), 1.0)

func _on_collision(area):
	if area == GameManager.player_area:
		self.visible = false
