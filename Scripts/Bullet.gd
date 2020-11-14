extends KinematicBody2D
class_name Bullet


const SPEED = 400
var m_velocity = Vector2.UP * SPEED
var window_height = ProjectSettings.get_setting("display/window/size/height")


func _physics_process(_delta):
	move_and_slide(m_velocity)
	if position.y < -50 or position.y > window_height + 50:
		queue_free()
