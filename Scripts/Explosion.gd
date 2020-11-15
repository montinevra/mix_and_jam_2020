extends AnimatedSprite


func _ready():
	play()


func _on_explosion1_animation_finished():
	Events.emit_signal("sig_enemy_destroyed")
