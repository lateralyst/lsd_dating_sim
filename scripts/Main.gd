extends Node

onready var pause_menu = get_node("../../CanvasLayer/Pause Menu")
onready var post_p = get_node("../../CanvasLayer/Post-Processing")

func _ready():
#	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	pause_menu.visible = false
	post_p.visible = true
	OS.window_size = Vector2(1200, 900)
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
#		get_tree().quit()
		pause_menu.visible = !pause_menu.visible
		get_tree().paused = !get_tree().paused
	if Input.is_action_just_pressed("restart"):
		get_tree().reload_current_scene()
	if Input.is_action_just_pressed("fullscreen toggle"):
		OS.window_fullscreen = !OS.window_fullscreen

