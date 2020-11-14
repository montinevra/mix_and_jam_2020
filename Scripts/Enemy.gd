extends KinematicBody2D


const SPEED = 100
const SHOOT_CD = 1
const PLAYFIELD_EDGE = 20
const BULLET_SCENE = preload("res://scenes/EnemyBullet.tscn")
const BULLET_SPAWN_POS = Vector2.DOWN * 18
var m_velocity = Vector2.RIGHT * SPEED
var window_width = ProjectSettings.get_setting("display/window/size/width")
onready var c_shoot_timer = $ShootTimer


func _physics_process(delta):
# warning-ignore:return_value_discarded
	move_and_collide(m_velocity * delta)
	if position.x > window_width - PLAYFIELD_EDGE:
		m_velocity = Vector2.LEFT * SPEED
	elif position.x < PLAYFIELD_EDGE:
		m_velocity = Vector2.RIGHT * SPEED


#private:
func _shoot():
	var bullet = BULLET_SCENE.instance()

	bullet.position = position + BULLET_SPAWN_POS
	get_parent().add_child(bullet)


func _on_ShootTimer_timeout():
	_shoot()
	c_shoot_timer.wait_time = SHOOT_CD + randf()
