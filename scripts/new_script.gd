extends AnimatedSprite3D

onready var camera = get_viewport().get_camera()

func _ready():
	pass

func _process(delta):
	look_at_player()

func look_at_player():	
	var camera_pos = camera.global_transform.origin
	var camera_dir = -camera.global_transform.basis.z

	camera_pos += 1000 * camera_dir

	look_at(camera_pos, Vector3(0, 1, 0))

