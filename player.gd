class_name Player extends CharacterBody3D

@onready var body : MeshInstance3D = $geo/mesh
@onready var area : Area3D = $geo/area
@onready var anim : AnimationPlayer = $anim

func _ready():
	body.position += Vector3.DOWN * GameManager.displacement_offset

func _process(delta):
	if !GameManager.paused:
		velocity = Vector3.FORWARD * GameManager.speed
		
		move_and_slide()

		if Input.is_action_just_pressed("ui_accept"):
			GameManager.rotate_speed = GameManager.rotate_speed * -1 
			
			if GameManager.rotate_speed < 0:
				anim.play("left")
			else:
				anim.play("right")
		
		rotate_z(delta * GameManager.rotate_speed)
