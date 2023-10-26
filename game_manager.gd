extends Node3D

@export var displacement_offset : float :
	set (value):
		displacement_offset = float_change(value)
	get:
		return displacement_offset

@export var difficulty : int :
	set (value):
		difficulty = int_change(value)
	get:
		return difficulty

@export var max_difficulty : int :
	set (value):
		max_difficulty = int_change(value)
	get:
		return max_difficulty
		
@export var rewards : int :
	set (value):
		rewards = int_change(value)
	get:
		return rewards
		
@export var difficulty_percent_rewards : int :
	set (value):
		difficulty_percent_rewards = int_change(value)
	get:
		return difficulty_percent_rewards
		
@export var difficulty_percent_speed : float :
	set (value):
		difficulty_percent_speed = float_change(value)
	get:
		return difficulty_percent_speed

@export var cool_down : float :
	set (value):
		cool_down = float_change(value)
	get:
		return cool_down
		
@export var time_difficulty_change : float :
	set (value):
		time_difficulty_change = float_change(value)
	get:
		return time_difficulty_change
		
@export var time_get_rewards : float :
	set (value):
		time_get_rewards = float_change(value)
	get:
		return time_get_rewards
		
@export var time_spawn_object : float :
	set (value):
		time_spawn_object = float_change(value)
	get:
		return time_spawn_object
		
@export var time_to_die : float :
	set (value):
		time_to_die = float_change(value)
	get:
		return time_to_die

@export var amount_objects_to_spawn : int :
	set (value):
		amount_objects_to_spawn = int_change(value)
	get:
		return amount_objects_to_spawn

@export var amount_get_rewards : int :
	set (value):
		amount_get_rewards = int_change(value)
	get:
		return amount_get_rewards

@export var in_game : bool:
	set (value):
		in_game = bool_change(value)
	get:
		return in_game
		
@export var paused : bool :
	set (value):
		paused = bool_change(value)
	get:
		return paused

@export var speed : float :
	set (value):
		speed = float_change(value)
	get:
		return speed
		
@export var rotate_speed : float :
	set (value):
		rotate_speed = float_change(value)
	get:
		return rotate_speed

@export var spawner : Node3D :
	set (value):
		spawner = node3d_change(value)
	get:
		return spawner

@export var spawn_offset : float :
	set (value):
		spawn_offset = float_change(value)
	get:
		return spawn_offset

@export var player : CharacterBody3D :
	set (value):
		player = characterbody3D_change(value)
	get:
		return player

@export var player_body : Node3D :
	set (value):
		player_body = node3d_change(value)
	get:
		return player_body

@export var player_area : Area3D :
	set (value):
		player_area = area3d_change(value)
	get:
		return player_area

var end : bool = false

var current_cool_down : float = 0.0
var current_time_difficulty_change : float = 0.0
var current_time_get_rewards : float = 0.0
var current_time_spawn_object : float = 0.0
var current_time_to_die : float = 0.0

@export var enemy_probability : float :
	set (value):
		enemy_probability = float_change(value)
	get:
		return enemy_probability

@export var obstacle_probability : float :
	set (value):
		obstacle_probability = float_change(value)
	get:
		return obstacle_probability

@export var powerup_probability : float :
	set (value):
		powerup_probability = float_change(value)
	get:
		return powerup_probability

@export var reward_probability : float :
	set (value):
		reward_probability = float_change(value)
	get:
		return reward_probability


@export var enemy_prefab : PackedScene :
	set (value):
		enemy_prefab = packedscene_change(value)
	get:
		return enemy_prefab

@export var powerup_prefab : PackedScene :
	set (value):
		powerup_prefab = packedscene_change(value)
	get:
		return powerup_prefab
		
@export var reward_prefab : PackedScene :
	set (value):
		reward_prefab = packedscene_change(value)
	get:
		return reward_prefab
		
@export var obstacle_prefab : PackedScene :
	set (value):
		obstacle_prefab = packedscene_change(value)
	get:
		return obstacle_prefab


func _ready():
	update_values()

func _process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		paused = !paused
	
	if !GameManager.paused:
		if end == false:
			if in_game == false:
				current_cool_down += delta

				if current_cool_down > cool_down:
					current_cool_down = 0
					in_game = true
				else:
					
					current_time_spawn_object += delta
					
					if current_time_spawn_object > time_spawn_object:
						
						var rnd = randf_range(0,(100 - max_difficulty) + difficulty)
						
						if rnd <= reward_probability:
							spawner.spawn_object(reward_prefab)
						
						if rnd <= powerup_probability and rnd > reward_probability:
							spawner.spawn_object(powerup_prefab)
						
						if rnd <= obstacle_probability and rnd > powerup_probability:
							spawner.spawn_object(obstacle_prefab)
						
						if rnd <= enemy_probability and rnd > obstacle_probability:
							spawner.spawn_object(enemy_prefab)
							
						current_time_spawn_object = 0
			else:
				current_time_difficulty_change += delta
				current_time_get_rewards += delta
							
				if current_time_difficulty_change > time_difficulty_change:
					current_time_difficulty_change = 0
					add_difficulty(1)
					
					if difficulty == max_difficulty:
						end = true
						
					update_values()
					in_game = false
					print("Difficulty ->" + str(difficulty))
				
				if current_time_get_rewards > time_get_rewards:
					current_time_get_rewards = 0
					add_rewards(1 + ((difficulty + 0.0) / difficulty_percent_rewards))
					print("Rewards ->" + str(rewards))
		else:
			current_time_to_die += delta
			
			if current_time_to_die < time_to_die:
				speed = lerp(speed, 0.0, current_time_to_die)
				rotate_speed *= (1 + delta)
			else:
				rotate_speed = 0
				speed += delta * 100.0
				player.global_position.y = 0

func update_values():
	time_get_rewards = time_difficulty_change / (amount_get_rewards + difficulty)
	time_spawn_object = cool_down / (amount_objects_to_spawn + difficulty)
	
	add_speed(difficulty_percent_speed)
	add_rotate_speed(difficulty_percent_speed)

func add_difficulty(amount):
	difficulty += amount
	print("new difficulty -> " + str(difficulty))

func add_rewards(amount):
	rewards += amount
	print("new rewards -> " + str(rewards))

func add_speed(amount):
	speed = speed * (1+amount)
	print("new speed -> " + str(speed))

func add_rotate_speed(amount):
	rotate_speed = rotate_speed * (1+amount)
	print("new rotate speed -> " + str(rotate_speed))

# Aux

func float_change(value: float) -> float:
	return value
	
func int_change(value: int) -> int:
	return value
	
func bool_change(value: bool) -> bool:
	return value

func node3d_change(value: Node3D) -> Node3D:
	return value
	
func characterbody3D_change(value: CharacterBody3D) -> CharacterBody3D:
	return value
	
func area3d_change(value: Area3D) -> Area3D:
	return value

func packedscene_change(value : PackedScene) -> PackedScene:
	return value
