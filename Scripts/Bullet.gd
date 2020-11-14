extends KinematicBody2D

const SPEED = 400
var m_velocity = Vector2.UP * SPEED


func _physics_process(_delta):
	move_and_slide(m_velocity)
	if position.y < -50:
		queue_free()

