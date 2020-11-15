extends Node2D


const PLAYER_SCENE = preload("res://scenes/Player.tscn")
const ENEMY_SCENE = preload("res://scenes/Enemy.tscn")
export var enemy_count: int = 8
var m_core_colors = [Color.red, Color.blue, Color.green, Color.yellow, Color.red, Color.blue, Color.green, Color.yellow]
var m_last_core = null
onready var c_player_start = $PlayerStart
#onready var c_enemy_start = $EnemyStart
onready var c_enemy_grid = $Path2D/EnemyGrid


func _ready():
	randomize()
	Events.connect("sig_bullet_spawned", self, "_on_bullet_spawned")
	Events.connect("sig_enemy_hit", self, "_on_enemy_hit")
	Events.connect("sig_core_exposed", self, "_on_core_exposed")
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
		add_child(new_enemy)
		new_enemy.position = i.position
		new_enemy.set_core_color(m_core_colors[x])
		x += 1


#private:
func _on_bullet_spawned(t_bullet):
	t_bullet.get_parent().remove_child(t_bullet)
	add_child(t_bullet)


func _on_enemy_hit(t_enemy):
	var pos = t_enemy.get_global_position()
	
	t_enemy.get_parent().remove_child(t_enemy)
	add_child(t_enemy)
	t_enemy.set_global_position(pos)


func _on_core_exposed(t_color):
	if !m_last_core:
		m_last_core = t_color
	elif m_last_core == t_color:
#	if m_last_core and m_last_core == t_color:
		Events.emit_signal("sig_core_matched", t_color)
	else:
		m_last_core = null
		Events.emit_signal("sig_core_unmatched")
	pass
