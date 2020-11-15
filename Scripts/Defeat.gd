extends Sprite


func _input(event):
	if Input.is_action_just_pressed("fire") or Input.is_action_just_pressed("ui_accept"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
