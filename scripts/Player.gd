extends KinematicBody

const antiDelta = 60  # multiply with delta to get to about 1
const gravity = 100
const mouseSensitivity = 0.13
const run_mod = 1.5

var walkSpeed = 8
var jumpForce = 10
var camera_angle = 0
var movement = Vector3()

var tracked_movement = 0.0
var max_tracked_movement = 4000.0


func _physics_process(delta):
	var input = Vector3()
	
	if Input.is_action_pressed("left"):
		rotate_y(0.017)
	if Input.is_action_pressed("right"):
		rotate_y(-0.017)
	
	if Input.is_action_pressed("forward"):
		input.x = 1
	if Input.is_action_pressed("back"):
		input.x = -1
#	if Input.is_action_pressed("left"):
#		input.z = -1
#	if Input.is_action_pressed("right"):
#		input.z = 1
	
	movement = input.rotated(Vector3.UP, rotation.y).normalized()
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		print("jumped")
		movement.y += jumpForce
	
	if !is_on_floor():
		movement.y -= gravity * delta
	
	var actual_movement = move_and_slide(movement * delta * antiDelta * walkSpeed, Vector3(0, 1, 0))
	
	if tracked_movement < max_tracked_movement:
		if actual_movement.length() > 1:
			tracked_movement += actual_movement.length()
	else:
		max_movement_exceeded()

func _input(event):
	pass
#	if event is InputEventMouseMotion:
#		rotate_y(deg2rad(-event.relative.x * mouseSensitivity))
#
#		var change = -event.relative.y * mouseSensitivity
#		if change + camera_angle < 90 and change + camera_angle > -90:
#			$Head/Camera.rotate_z(deg2rad(change))
#			camera_angle += change


func max_movement_exceeded():
	get_tree().reload_current_scene()
	pass

