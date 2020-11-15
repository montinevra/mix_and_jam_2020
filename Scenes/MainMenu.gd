extends Control


var player
var already_paused
var selected_menu = 0
var grayout = preload("res://Shaders/white2gray.shader")
var white = preload("res://Shaders/normal.shader")


func change_menu_color():
	$howto.material.shader = white
	$start.material.shader = white
	$credits.material.shader = white
	$quit.material.shader = white
	
	match selected_menu:
		0:
			$howto.material.shader = grayout
		1:
			$start.material.shader = grayout
		2:
			$credits.material.shader = grayout
		3:
			$quit.material.shader = grayout

func _input(event):
	if Input.is_action_just_pressed("ui_down"):
		if selected_menu < 3:
			selected_menu = (selected_menu + 1);
		else:
			selected_menu = 0
		change_menu_color()
	elif Input.is_action_just_pressed("ui_up"):
		if selected_menu > 0:
			selected_menu = selected_menu - 1
		else:
			selected_menu = 3
		change_menu_color()
	elif Input.is_action_just_pressed("ui_cancel"):
		_resume()
	elif Input.is_action_just_pressed("fire") or Input.is_action_just_pressed("ui_accept"):
		match selected_menu:
			0:
				# How To Play
				get_tree().change_scene("res://Scenes/HowTo.tscn")
			1:
				# Start game
				get_tree().change_scene("res://Scenes/Main.tscn")
				get_tree().paused = false
			2:
				# Credits Page
				get_tree().change_scene("res://Scenes/.tscn")
			3:
				# Quit game
				get_tree().quit()


func _resume():
	if not already_paused:
		get_tree().paused = false
		hide()
