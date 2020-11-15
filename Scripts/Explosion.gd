extends AnimatedSprite


func _ready():
	play()


func _on_Explosion_animation_finished():
	Events.emit_signal("sig_enemy_destroyed")
