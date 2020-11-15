extends KinematicBody2D
class_name Enemy


enum State {ALIVE, CORE, UNEXPLODING}
const DEBUG = false
const SPEED = 100
const SHOOT_CD = 1
const PLAYFIELD_EDGE = 20
const BULLET_SCENE = preload("res://scenes/EnemyBullet.tscn")
const EXPLOSION_SCENE = preload("res://Sprites/Animated/Explosion.tscn")
var m_state = State.ALIVE
var m_velocity = Vector2.RIGHT * SPEED
var window_width = ProjectSettings.get_setting("display/window/size/width")
onready var c_body: Sprite = $Body
onready var c_core: Sprite = $Core
onready var c_collider: CollisionPolygon2D = $CollisionPolygon2D
onready var c_shoot_timer: Timer = $ShootTimer
onready var c_bullet_spawn: Position2D = $BulletSpawn
onready var c_core_explosion: AnimatedSprite = $CoreExplosion
onready var c_core_unexplosion: AnimatedSprite = $CoreUnexplosion


func _ready():
# warning-ignore:return_value_discarded
	Events.connect("sig_core_exploded", self, "_on_core_exploded")
# warning-ignore:return_value_discarded
	Events.connect("sig_core_matched", self, "_on_core_matched")
# warning-ignore:return_value_discarded
	Events.connect("sig_core_unmatched", self, "_on_core_unmatched")
	c_shoot_timer.set_wait_time(SHOOT_CD + randf())
	c_shoot_timer.start()


func _physics_process(delta):
	if DEBUG:
		return
	var collision
	if m_state == State.ALIVE:
		collision = move_and_collide(m_velocity * delta)
		if collision:
			m_velocity *= -1
		if position.x > window_width - PLAYFIELD_EDGE:
			m_velocity = Vector2.LEFT * SPEED
		elif position.x < PLAYFIELD_EDGE:
			m_velocity = Vector2.RIGHT * SPEED


#public:
func on_hit() -> void:
	if m_state == State.UNEXPLODING:
		return
	m_state = State.CORE
	c_body.hide()
	c_core.show()
	c_collider.disabled = true
	c_shoot_timer.stop()
	c_core_explosion.set_frame(0)
	c_core_explosion.show()
	c_core_explosion.play()
	$CoreExplosionSound.play()


func set_core_color(t_color: Color):
	c_core.set_modulate(t_color)


func get_core_color():
	return c_core.get_modulate()


func is_core_exposed():
	if m_state == State.CORE:
		return true
	return false


#private:
func _shoot():
	if DEBUG:
		return
	var bullet = BULLET_SCENE.instance()

	bullet.position = c_bullet_spawn.global_position
	get_parent().add_child(bullet)
	Events.emit_signal("sig_bullet_spawned", bullet)


func _on_ShootTimer_timeout():
	_shoot()
	c_shoot_timer.set_wait_time(SHOOT_CD + randf())


func _on_core_exploded():
	if m_state == State.CORE:
		Events.emit_signal("sig_core_exposed", c_core.get_modulate())


func _on_core_matched(t_color):
	if c_core.get_modulate() == t_color:
		var explosion = EXPLOSION_SCENE.instance()
		get_parent().add_child(explosion)
		explosion.set_position(get_position())
#		Events.emit_signal("sig_enemy_destroyed")
		queue_free()


func _on_core_unmatched():
	if m_state == State.ALIVE:
		return
	m_state = State.UNEXPLODING
	c_core_unexplosion.set_frame(0)
	c_core_unexplosion.show()
	c_core_unexplosion.play()
	$CoreUnexplosionSound.play()
	

func _on_CoreExplosion_animation_finished():
	c_core_explosion.hide()
	Events.emit_signal("sig_core_exposed", c_core.get_modulate())


func _on_CoreUnexplosion_animation_finished():
	c_core_unexplosion.hide()
	c_core.hide()
	c_body.show()
	m_state = State.ALIVE
	c_collider.disabled = false
	c_shoot_timer.start()
	c_shoot_timer.set_wait_time(SHOOT_CD + randf())
