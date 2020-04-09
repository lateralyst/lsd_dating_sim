extends KinematicBody

const gravity = 100
const mouseSensitivity = 0.13
const run_mod = 1.5

var turnSpeed = 0.017
var walkSpeed = 5
var jumpForce = 30
var camera_angle = 0
var movement = Vector3()

var rotateMode = false
var isTurning = false

var canMove = true
var canInteract = false
var interactionTarget

onready var main_script = get_node("/root/GameManager/Main")

func _ready():
	pass
#	var spawn = get_tree().get_nodes_in_group("Spawn")[0]
#
#	if spawn != null:
#		translation = spawn.translation

func _physics_process(delta):
	if canMove:
		move(delta)

func move(delta):
	var input = Vector3()
	var speed = walkSpeed
	
	if Input.is_action_pressed("left"):
		rotate_y(turnSpeed)
		isTurning = true
	elif Input.is_action_pressed("right"):
		rotate_y(-turnSpeed)
		isTurning = true
	else:
		isTurning = false
	
	if rotateMode:
		if Input.is_action_pressed("forward"):
			changeVerticalCamAngle(turnSpeed * 40.0)
		if Input.is_action_pressed("back"):
			changeVerticalCamAngle(-turnSpeed * 40.0)
	else:
		if Input.is_action_pressed("forward"):
			input.x = 1
		if Input.is_action_pressed("back"):
			input.x = -1
#		if Input.is_action_pressed("left"):
#			input.z = -1
#		if Input.is_action_pressed("right"):
#			input.z = 1
	
	if Input.is_action_pressed("sprint"):
		speed *= run_mod

	movement = input.rotated(Vector3.UP, rotation.y).normalized()
	
	if is_on_floor() && Input.is_action_just_pressed("jump"):
		movement.y += jumpForce
	
	if !is_on_floor():
		movement.y -= gravity * delta
	
	var actual_movement = move_and_slide(movement * speed, Vector3(0, 1, 0), true)
	
	var hor_dist_travelled_this_frame = Vector2(actual_movement.x, actual_movement.z).length()
	main_script.increment_player_distance(hor_dist_travelled_this_frame)

func _input(event):
	if event.is_action_pressed("rotateMode"):
		rotateMode = !rotateMode
		resetCamAngle()
	elif event.is_action_pressed("interact"):
		if canInteract and interactionTarget != null:
			print("interacting with " + interactionTarget.get_name() + "...")
			if interactionTarget.has_method("interact"):
				interactionTarget.call("interact")
			else:
				print("error: interactionTarget has no interact() function")
		else:
			print("no interaction target nearby")
	pass
#	if event is InputEventMouseMotion:
#		rotate_y(deg2rad(-event.relative.x * mouseSensitivity))
#
#		var change = -event.relative.y * mouseSensitivity
#		if change + camera_angle < 90 and change + camera_angle > -90:
#			$Head/Camera.rotate_z(deg2rad(change))
#			camera_angle += change

func changeVerticalCamAngle(change):
		if change + camera_angle < 90 and change + camera_angle > -90:
			$Head/Camera.rotate_z(deg2rad(change))
			camera_angle += change

func resetCamAngle():
	$Head/Camera.rotation_degrees = Vector3(0, -90, 0)
	camera_angle = 0

func max_movement_exceeded():
	get_tree().reload_current_scene()
	pass

func _on_area2d_body_entered(body, obj):
	if body.get_name() == "Player":
		canInteract = true
		interactionTarget = obj

func _on_area2d_body_exited(body, obj):
	if body.get_name() == "Player":
		canInteract = false
		interactionTarget = null


