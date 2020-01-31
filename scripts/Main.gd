extends Node

onready var pause_menu = get_node("../../UI/CanvasLayer/Pause Menu")
onready var post_p = get_node("../../UI/CanvasLayer/Post-Processing")

func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_menu.visible = false
	post_p.visible = true
	OS.window_size = Vector2(800, 600)
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		pause_menu.visible = !pause_menu.visible
		get_tree().paused = !get_tree().paused
	
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	
	if Input.is_action_just_pressed("fullscreen toggle"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("debug key 1"):
#		var scene = load("res://Room.tscn")
		get_tree().change_scene("res://Room.tscn")
		print("switched scene to room")