extends KinematicBody2D


const SPEED = 200
const BULLET_SCENE = preload("res://scenes/Bullet.tscn")
const BULLET_SPAWN_POS = Vector2.UP * 12
var m_velocity = Vector2(0, 0)
var m_inputs = {
	"player_move_right": Vector2.RIGHT,
	"player_move_left": Vector2.LEFT,
	"player_move_up": Vector2.UP,
	"player_move_down": Vector2.DOWN,
}
onready var m_fire_cd = $FireCD


func _physics_process(_delta):
	_update_velocity()
	m_velocity = move_and_slide(m_velocity)


func _update_velocity() -> void:
	m_velocity = Vector2(0, 0)
	for dir in m_inputs.keys():
		if Input.is_action_pressed(dir):
			m_velocity += m_inputs[dir] * SPEED


func _unhandled_input(event):
	if event.is_action_pressed("fire") and !m_fire_cd.time_left:
		_fire()
		m_fire_cd.start()


#private:
func _fire():
	var bullet = BULLET_SCENE.instance()

	bullet.position = position + BULLET_SPAWN_POS
	get_parent().add_child(bullet)
