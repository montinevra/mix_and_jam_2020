extends KinematicBody2D


const SPEED = 200
var m_velocity = Vector2(0, 0)
var m_inputs = {
	"player_move_right": Vector2.RIGHT,
	"player_move_left": Vector2.LEFT,
	"player_move_up": Vector2.UP,
	"player_move_down": Vector2.DOWN,
}


func _physics_process(_delta):
	_update_velocity()
	m_velocity = move_and_slide(m_velocity)


func _update_velocity() -> void:
	m_velocity = Vector2(0, 0)
	for dir in m_inputs.keys():
		if Input.is_action_pressed(dir):
			m_velocity += m_inputs[dir] * SPEED
