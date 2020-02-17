extends Node

var pause_menu
var post_p

var tracked_movement = 0.0
var max_tracked_movement = 100000.0

func _ready():
	var ui = get_tree().get_nodes_in_group("UI")
	for i in ui:
		if i.get_name() == "Pause Menu":
			pause_menu = i
		if i.get_name() == "Post-Processing":
			post_p = i

	pause_menu.visible = false
	post_p.visible = true
	
	OS.window_size = Vector2(800, 600)
	pass

func _input(event):
	if Input.is_action_just_pressed("ui_cancel"):
		pause_menu.visible = !pause_menu.visible
		get_tree().paused = !get_tree().paused
	
	if Input.is_action_just_pressed("restart"):
		reset_scene()
	
	if Input.is_action_just_pressed("fullscreen toggle"):
		OS.window_fullscreen = !OS.window_fullscreen
	
	if Input.is_action_just_pressed("debug key 1"):
#		var scene = load("res://Room.tscn")
		get_tree().change_scene("res://Room.tscn")
		print("switched scene to room")


func increment_player_distance(amount):
	tracked_movement += amount
	
	if tracked_movement > max_tracked_movement:
		reset_scene()


func reset_scene():
	get_tree().paused = false
	pause_menu.visible = false
	reset_vars()
	
	get_tree().reload_current_scene()


func reset_vars():
	tracked_movement = 0.0












