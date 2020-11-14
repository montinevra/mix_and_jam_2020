extends RigidBody2D
class_name Bullet


export var m_speed: float
var m_velocity: Vector2
var window_height = ProjectSettings.get_setting("display/window/size/height")


func _ready():
	m_velocity = Vector2.UP * m_speed
	apply_central_impulse(m_velocity)
	pass


func _physics_process(delta):
	var collision

#	collision = move_and_collide(m_velocity * delta)
	if collision:
		_collide(collision)
	if position.y < -50 or position.y > window_height + 50:
		queue_free()


#private:
func _collide(t_collision) -> void:
	pass
