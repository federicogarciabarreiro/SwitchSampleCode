class_name Config extends Node3D

@export var _displacement_offset : float = 11.0
@export var _difficulty : int = 0
@export var _max_difficulty : int = 20
@export var _rewards : int = 0
@export var _difficulty_percent_rewards : int = 5
@export var _difficulty_percent_speed : float = 0.1
@export var _cool_down : float = 3.0
@export var _time_difficulty_change : float = 3.0
@export var _time_get_rewards : float = 3.0
@export var _time_spawn_object : float = 2.0
@export var _time_to_die : float = 5.0
@export var _amount_objects_to_spawn : int = 1
@export var _amount_get_rewards : int = 1
@export var _in_game : bool = false
@export var _paused : bool = false
@export var _speed : float = 8
@export var _rotate_speed : float = 1
@export var _spawner : Node3D
@export var _spawn_offset : float = -50.0
@export var _player : CharacterBody3D
@export var _enemy_probability : float = 90
@export var _obstacle_probability : float = 80
@export var _powerup_probability : float = 40
@export var _reward_probability : float = 0
@export var _enemy_prefab : PackedScene = preload("res://prefabs/enemy.tscn")
@export var _powerup_prefab : PackedScene = preload("res://prefabs/powerup.tscn")
@export var _reward_prefab : PackedScene = preload("res://prefabs/reward.tscn")
@export var _obstacle_prefab : PackedScene = preload("res://prefabs/obstacle.tscn")

func _enter_tree():
	GameManager.displacement_offset = _displacement_offset
	GameManager.difficulty = _difficulty
	GameManager.max_difficulty = _max_difficulty
	GameManager.rewards = _rewards
	GameManager.difficulty_percent_rewards = _difficulty_percent_rewards
	GameManager.difficulty_percent_speed = _difficulty_percent_speed
	GameManager.cool_down = _cool_down
	GameManager.time_difficulty_change = _time_difficulty_change
	GameManager.time_get_rewards = _time_get_rewards
	GameManager.time_spawn_object = _time_spawn_object
	GameManager.time_to_die = _time_to_die
	GameManager.amount_objects_to_spawn = _amount_objects_to_spawn
	GameManager.amount_get_rewards = _amount_get_rewards
	GameManager.in_game = _in_game
	GameManager.paused = _paused
	GameManager.speed = _speed
	GameManager.rotate_speed = _rotate_speed
	GameManager.spawner = _spawner
	GameManager.spawn_offset = _spawn_offset
	GameManager.player = _player
	GameManager.player_body = _player.get_node("geo")
	GameManager.player_area = _player.get_node("geo/area")
	GameManager.enemy_probability = _enemy_probability
	GameManager.obstacle_probability = _obstacle_probability
	GameManager.powerup_probability = _powerup_probability
	GameManager.reward_probability = _reward_probability
	GameManager.enemy_prefab = _enemy_prefab
	GameManager.obstacle_prefab = _obstacle_prefab
	GameManager.powerup_prefab = _powerup_prefab
	GameManager.reward_prefab = _reward_prefab
