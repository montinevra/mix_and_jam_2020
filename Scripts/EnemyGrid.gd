extends PathFollow2D


const SPEED:float = 100.0
var m_dir = 1

#func _ready():
#	print(offset)
#	offset = SPEED
#	print(offset)

func _physics_process(delta):
	set_offset(get_offset() + SPEED * delta * m_dir)
#	offset += SPEED * delta

