extends Node2D


const PLAYER_SCENE = preload("res://Scenes/Player.tscn")
const ENEMY_SCENE = preload("res://Scenes/Enemy.tscn")
export var enemy_count: int = 8
var m_core_colors = [Color.red, Color.blue, Color.green, Color.yellow, Color.red, Color.blue, Color.green, Color.yellow]
var m_last_core = null
var m_enemy_list = []
onready var c_player_start = $PlayerStart
onready var c_enemy_grid = $EnemyGrid


func _ready():
	randomize()
# warning-ignore:return_value_discarded
	Events.connect("sig_bullet_spawned", self, "_on_bullet_spawned")
# warning-ignore:return_value_discarded
	Events.connect("sig_enemy_hit", self, "_on_enemy_hit")
# warning-ignore:return_value_discarded
	Events.connect("sig_core_exposed", self, "_on_core_exposed")
# warning-ignore:return_value_discarded
	Events.connect("sig_enemy_destroyed", self, "_on_enemy_destroyed")
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
		m_enemy_list.append(new_enemy)
	enemy.queue_free()


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
	var exposed_cores = 0
	var matching_cores = 0
	
	for i in m_enemy_list:
		if is_instance_valid(i) and i.is_core_exposed():
			exposed_cores += 1
	if exposed_cores >= 2:
		for i in m_enemy_list:
			if is_instance_valid(i) and i.is_core_exposed() and i.get_core_color() == t_color:
				matching_cores += 1
		if matching_cores >= 2:
			Events.emit_signal("sig_core_matched", t_color)
		else:
			Events.emit_signal("sig_core_unmatched")


func _on_enemy_destroyed():
	for i in m_enemy_list:
		if is_instance_valid(i):
			return
	get_tree().change_scene("res://Scenes/Victory.tscn")
