extends AnimatedSprite


func _ready():
	play()


func _on_PlayerExplosion_animation_finished():
	get_tree().change_scene("res://Scenes/Defeat.tscn")
