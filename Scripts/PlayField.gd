extends Node2D


const PLAYER_SCENE = preload("res://scenes/Player.tscn")
const ENEMY_SCENE = preload("res://scenes/Enemy.tscn")
export var enemy_count: int = 8
var m_core_colors = [Color.red, Color.blue, Color.green, Color.yellow, Color.red, Color.blue, Color.green, Color.yellow]
onready var c_player_start = $PlayerStart
onready var c_enemy_start = $EnemyStart
onready var c_enemy_grid = $Path2D/EnemyGrid


func _ready():
	randomize()
	_start_game()


func _start_game():
	var player = PLAYER_SCENE.instance()
	var enemy = ENEMY_SCENE.instance()
	var x = 0
	
	player.position = c_player_start.position
	add_child(player)
	m_core_colors.shuffle()
	for i in c_enemy_grid.get_children():
		var new_enemy = enemy.duplicate()
		c_enemy_grid.add_child(new_enemy)
		new_enemy.position = i.position
		new_enemy.set_core_color(m_core_colors[x])
		x += 1
