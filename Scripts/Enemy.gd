extends KinematicBody2D
class_name Enemy


enum State {ALIVE, CORE}
const SPEED = 100
const SHOOT_CD = 1
const PLAYFIELD_EDGE = 20
const BULLET_SCENE = preload("res://scenes/EnemyBullet.tscn")
var m_state = State.ALIVE
var m_velocity = Vector2.RIGHT * SPEED
var window_width = ProjectSettings.get_setting("display/window/size/width")
onready var c_body: Sprite = $Body
onready var c_core: Sprite = $Core
onready var c_collider: CollisionPolygon2D = $CollisionPolygon2D
onready var c_shoot_timer: Timer = $ShootTimer
onready var c_bullet_spawn: Position2D = $BulletSpawn


func _ready():
	Events.connect("sig_core_matched", self, "_on_core_matched")
	Events.connect("sig_core_unmatched", self, "_on_core_unmatched")
	c_shoot_timer.set_wait_time(SHOOT_CD + randf())


func _physics_process(delta):
#	var collision
## warning-ignore:return_value_discarded
#	if m_state == State.ALIVE:
#		collision = move_and_collide(m_velocity * delta)
#		if position.x > window_width - PLAYFIELD_EDGE:
#			m_velocity = Vector2.LEFT * SPEED
#		elif position.x < PLAYFIELD_EDGE:
#			m_velocity = Vector2.RIGHT * SPEED
	pass

#public:
func on_hit() -> void:
	m_state = State.CORE
	c_body.hide()
	c_core.show()
	c_collider.disabled = true
	c_shoot_timer.stop()
	Events.emit_signal("sig_enemy_hit", self)
	Events.emit_signal("sig_core_exposed", c_core.get_modulate())


func set_core_color(t_color: Color):
	c_core.set_modulate(t_color)


#private:
func _shoot():
	var bullet = BULLET_SCENE.instance()

	bullet.position = c_bullet_spawn.global_position
	get_parent().add_child(bullet)
	Events.emit_signal("sig_bullet_spawned", bullet)


func _on_ShootTimer_timeout():
	_shoot()
	c_shoot_timer.set_wait_time(SHOOT_CD + randf())


func _on_core_matched(t_color):
	if c_core.get_modulate() == t_color:
		queue_free()


func _on_core_unmatched():
	c_core.hide()
	c_body.show()
	m_state = State.ALIVE
	c_collider.disabled = false
	c_shoot_timer.start()
	c_shoot_timer.set_wait_time(SHOOT_CD + randf())
	
#	if c_core.get_modulate() == t_color:
#		queue_free()
	
