extends KinematicBody2D


const SPEED = 200
const SHOOT_CD = 1
const BULLET_SCENE = preload("res://scenes/EnemyBullet.tscn")
const BULLET_SPAWN_POS = Vector2.DOWN * 12
onready var c_shoot_timer = $ShootTimer



#private:
func _shoot():
	print("shooting!")
	var bullet = BULLET_SCENE.instance()

	bullet.position = position + BULLET_SPAWN_POS
	get_parent().add_child(bullet)


func _on_ShootTimer_timeout():
	_shoot()
	c_shoot_timer.wait_time = SHOOT_CD + randf()
