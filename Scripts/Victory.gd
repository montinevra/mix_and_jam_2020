extends Node2D


func _input(event):
	if Input.is_action_just_pressed("ui_accept") or Input.is_action_just_pressed("fire"):
		get_tree().change_scene("res://Scenes/MainMenu.tscn")
