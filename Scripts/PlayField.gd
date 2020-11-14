extends Node2D


const PLAYER_SCENE = preload("res://scenes/Player.tscn")
const ENEMY_SCENE = preload("res://scenes/Enemy.tscn")
onready var c_player_start = $PlayerStart
onready var c_enemy_start = $EnemyStart


func _ready():
	randomize()
	_start_game()


func _start_game():
	var player = PLAYER_SCENE.instance()
	var enemy = ENEMY_SCENE.instance()
	
	player.position = c_player_start.position
	enemy.position = c_enemy_start.position
	add_child(player)
	add_child(enemy)
	enemy.set_core_color(Color(randf(), randf(), randf()))
