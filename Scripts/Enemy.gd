extends KinematicBody2D


enum State {ALIVE, CORE}
const SPEED = 100
const SHOOT_CD = 1
const PLAYFIELD_EDGE = 20
const BULLET_SCENE = preload("res://scenes/EnemyBullet.tscn")
var m_state = State.ALIVE
var m_velocity = Vector2.RIGHT * SPEED
var window_width = ProjectSettings.get_setting("display/window/size/width")
onready var c_body = $Body
onready var c_core = $Core
onready var c_collider = $CollisionPolygon2D
onready var c_shoot_timer = $ShootTimer
onready var c_bullet_spawn = $BulletSpawn


func _physics_process(delta):
	var collision
# warning-ignore:return_value_discarded
	if m_state == State.ALIVE:
		collision = move_and_collide(m_velocity * delta)
		if position.x > window_width - PLAYFIELD_EDGE:
			m_velocity = Vector2.LEFT * SPEED
		elif position.x < PLAYFIELD_EDGE:
			m_velocity = Vector2.RIGHT * SPEED


#public:
func on_hit() -> void:
	m_state = State.CORE
	c_body.hide()
	c_core.show()
	c_collider.disabled = true
	c_shoot_timer.stop()


func set_core_color(t_color: Color):
	c_core.set_modulate(t_color)


#private:
func _shoot():
	var bullet = BULLET_SCENE.instance()

	bullet.position = c_bullet_spawn.global_position
	get_parent().add_child(bullet)


func _on_ShootTimer_timeout():
	_shoot()
	c_shoot_timer.wait_time = SHOOT_CD + randf()
