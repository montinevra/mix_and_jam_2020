extends AnimatedSprite


func _ready():
	play()


func _on_PlayerExplosion_animation_finished():
	print("u lose")
